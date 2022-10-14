class EmployeeTemplatesController < ApplicationController
  before_action :set_employee_template, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /employee_templates
  def index
    @pagy, @employee_templates = pagy(EmployeeTemplate.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @employee_templates
  end

  # GET /employee_templates/1 or /employee_templates/1.json
  def show
  end

  # GET /employee_templates/new
  def new
    @employee_template = EmployeeTemplate.new

    # Uncomment to authorize with Pundit
    # authorize @employee_template
  end

  # GET /employee_templates/1/edit
  def edit
  end

  # POST /employee_templates or /employee_templates.json
  def create
    @employee_template = EmployeeTemplate.new(employee_template_params)

    # Uncomment to authorize with Pundit
    # authorize @employee_template

    respond_to do |format|
      if @employee_template.save
        format.html { redirect_to @employee_template, notice: "Employee template was successfully created." }
        format.json { render :show, status: :created, location: @employee_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_templates/1 or /employee_templates/1.json
  def update
    respond_to do |format|
      if @employee_template.update(employee_template_params)
        format.html { redirect_to @employee_template, notice: "Employee template was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_templates/1 or /employee_templates/1.json
  def destroy
    @employee_template.destroy
    respond_to do |format|
      format.html { redirect_to employee_templates_url, status: :see_other, notice: "Employee template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee_template
    @employee_template = EmployeeTemplate.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @employee_template
  rescue ActiveRecord::RecordNotFound
    redirect_to employee_templates_path
  end

  # Only allow a list of trusted parameters through.
  def employee_template_params
    params.require(:employee_template).permit(:account_id, :title, employee_attributes_attributes: [:name, :data_type, :required, :_destroy])

    # Uncomment to use Pundit permitted attributes
    # params.require(:employee_template).permit(policy(@employee_template).permitted_attributes)
  end
end
