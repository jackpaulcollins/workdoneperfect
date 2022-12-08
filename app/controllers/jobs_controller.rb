class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /jobs
  def index
    @pagy, @jobs = pagy(Job.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @jobs
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = if JobTemplate.default_template.present? && job_params.blank?
      Job.new(job_template: JobTemplate.default_template)
    elsif job_params.present?
      Job.new(job_template_id: job_params[:job_template_id])
    else
      Job.new
    end

    @job
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)
    # Uncomment to authorize with Pundit
    # authorize @job

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, status: :see_other, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @job
  rescue ActiveRecord::RecordNotFound
    redirect_to jobs_path
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.fetch(:job, {}).permit(
      :job_template_id,
      :account_id,
      :customer_id,
      :date_and_time,
      :estimated_hours,
      :total_hours,
      :revenue,
      job_attribute_answers_attributes: [:id, :job_attribute_id, :answer, :_destroy],
      :company_resource_ids => []
    )
  end
end
