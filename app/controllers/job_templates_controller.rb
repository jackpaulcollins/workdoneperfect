class JobTemplatesController < ApplicationController
  before_action :set_job_template, only: [:show, :edit, :update, :destroy, :form_fields]
  before_action :authenticate_user!

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /job_templates
  def index
    @pagy, @job_templates = pagy(JobTemplate.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @job_templates
  end

  # GET /job_templates/1 or /job_templates/1.json
  def show
  end

  # GET /job_templates/new
  def new
    @job_template = JobTemplate.new
    # Uncomment to authorize with Pundit
    # authorize @job_template
  end

  # GET /job_templates/1/edit
  def edit
  end

  def create
    @job_template = JobTemplate.new(job_template_params)

    # Uncomment to authorize with Pundit
    # authorize @job_template

    respond_to do |format|
      if @job_template.save
        format.html { redirect_to @job_template, notice: "Job template was successfully created." }
        format.json { render :show, status: :created, location: @job_template }
      else
        format.html do
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @job_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_templates/1 or /job_templates/1.json
  def update
    respond_to do |format|
      if @job_template.update(job_template_params)
        format.html { redirect_to @job_template, notice: "Job template was successfully updated." }
        format.json { render :show, status: :ok, location: @job_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_templates/1 or /job_templates/1.json
  def destroy
    @job_template.destroy
    respond_to do |format|
      format.html { redirect_to job_templates_url, status: :see_other, notice: "Job template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def form_fields
    @target = params[:target]
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job_template
    @job_template = JobTemplate.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @job_template
  rescue ActiveRecord::RecordNotFound
    redirect_to job_templates_path
  end

  # Only allow a list of trusted parameters through.
  def job_template_params
    params.require(:job_template).permit(:account_id, :title, :default_template, required_resources: [], job_attributes_attributes: [:id, :name, :data_type, :required, :_destroy])

    # Uncomment to use Pundit permitted attributes
    # params.require(:job_template).permit(policy(@job_template).permitted_attributes)
  end
end
