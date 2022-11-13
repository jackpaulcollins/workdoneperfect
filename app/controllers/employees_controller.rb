class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :ensure_template, only: :new
  before_action :authenticate_user!

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /employees
  def index
    @q = Employee.ransack(params[:q])
    @pagy, @employees = pagy(@q.result)

    # Uncomment to authorize with Pundit
    # authorize @employees
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new

    # Uncomment to authorize with Pundit
    # authorize @employee
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    # Uncomment to authorize with Pundit
    # authorize @employee

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, status: :see_other, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.friendly.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @employee
  rescue ActiveRecord::RecordNotFound
    redirect_to employees_path
  end

  def ensure_template
    if current_account.employee_templates.none?
      flash[:notice] = "Please Create a Template Before Creating Employee Records"
      redirect_to new_employee_template_path
    end
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:account_id, :employee_template_id, :first_name, :last_name, :start_date, :final_date, attribute_answers_attributes: [:id, :answer])

    # Uncomment to use Pundit permitted attributes
    # params.require(:employee).permit(policy(@employee).permitted_attributes)
  end
end
