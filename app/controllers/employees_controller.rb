class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /employees
  def index
    @pagy, @employees = pagy(Employee.sort_by_params(params[:sort], sort_direction))

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
    @employee = Employee.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @employee
  rescue ActiveRecord::RecordNotFound
    redirect_to employees_path
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:name, :position, :start_date, :driver, :created_by_id)

    # Uncomment to use Pundit permitted attributes
    # params.require(:employee).permit(policy(@employee).permitted_attributes)
  end
end