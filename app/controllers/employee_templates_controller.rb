class EmployeeTemplatesController < Accounts::BaseController
  before_action :authenticate_user!
  before_action :set_employee_template, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /employees
  def index
    @pagy, @employee_templates = pagy(EmployeeTemplate.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @employees
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee_template = EmployeeTemplate.new

    # Uncomment to authorize with Pundit
    # authorize @employee
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee_template = EmployeeTemplate.new(employee_template_params.merge(user: current_user, account: current_account))

    # Uncomment to authorize with Pundit
    # authorize @employee

    respond_to do |format|
      if @employee_template.save
        format.html { redirect_to @employee_template, notice: "employee template was successfully created." }
        format.json { render :show, status: :created, location: @employee_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee_template.update(employee_template_params)
        format.html { redirect_to @employee_template, notice: "employee template was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee_template.destroy
    respond_to do |format|
      format.html { redirect_to employee_templates_url, status: :see_other, notice: "employee template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def append_template_attribute
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.append('template-attributes', partial: 'template_attribute') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee_template
    @employee_template = EmployeeTemplate.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @employee
  rescue ActiveRecord::RecordNotFound
    redirect_to employee_template_path
  end

  # Only allow a list of trusted parameters through.
  def employee_template_params
    params.require(:employee_template).permit(:title, template_attributes: [])
  end
    # Uncomment to use Pundit permitted attributes
    # params.require(:employee).permit(policy(@employee).permitted_attributes)
end
