class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

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
    @job = Job.new

    # Uncomment to authorize with Pundit
    # authorize @job
  end

  # GET /jobs/1/edit
  def edit
  end

  #json endpoint for stimulus
  def employees
    employees = Employee.all
    render json: { status: 200, employees: employees }
  end

  def append_employee
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append('job-employees', partial: 'appended_employee', locals: { employees: Employee.all }) }
    end
  end

  # POST /jobs or /jobs.json
  def create
    @job = Job.new(job_params)

    params[:employee_ids][:id].each do |e|
      if !e.empty?
        @job.employees << Employee.find(e)
      end
    end

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
    @job.employees.replace([])

    params[:employee_ids][:id].each do |e|
      if !e.empty?
        @job.employees << Employee.find(e)
      end
    end

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
    params.require(:job).permit(:customer_id, :date, :estimated_hours, :compeleted_hours, :revenue)

    # Uncomment to use Pundit permitted attributes
    # params.require(:job).permit(policy(@job).permitted_attributes)
  end
end
