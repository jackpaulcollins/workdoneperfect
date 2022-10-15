class EmployeeAttributesController < ApplicationController
  before_action :set_employee_attribute, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_with_sign_up!

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /employee_attributes
  def index
    @pagy, @employee_attributes = pagy(EmployeeAttribute.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @employee_attributes
  end

  # GET /employee_attributes/1 or /employee_attributes/1.json
  def show
  end

  # GET /employee_attributes/new
  def new
    @employee_attribute = EmployeeAttribute.new

    # Uncomment to authorize with Pundit
    # authorize @employee_attribute
  end

  # GET /employee_attributes/1/edit
  def edit
  end

  # POST /employee_attributes or /employee_attributes.json
  def create
    @employee_attribute = EmployeeAttribute.new(employee_attribute_params)

    # Uncomment to authorize with Pundit
    # authorize @employee_attribute

    respond_to do |format|
      if @employee_attribute.save
        format.html { redirect_to @employee_attribute, notice: "Employee attribute was successfully created." }
        format.json { render :show, status: :created, location: @employee_attribute }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_attributes/1 or /employee_attributes/1.json
  def update
    respond_to do |format|
      if @employee_attribute.update(employee_attribute_params)
        format.html { redirect_to @employee_attribute, notice: "Employee attribute was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_attribute }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_attributes/1 or /employee_attributes/1.json
  def destroy
    @employee_attribute.destroy
    respond_to do |format|
      format.html { redirect_to employee_attributes_url, status: :see_other, notice: "Employee attribute was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee_attribute
    @employee_attribute = EmployeeAttribute.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @employee_attribute
  rescue ActiveRecord::RecordNotFound
    redirect_to employee_attributes_path
  end

  # Only allow a list of trusted parameters through.
  def employee_attribute_params
    params.require(:employee_attribute).permit(:employee_template_id, :name)

    # Uncomment to use Pundit permitted attributes
    # params.require(:employee_attribute).permit(policy(@employee_attribute).permitted_attributes)
  end
end
