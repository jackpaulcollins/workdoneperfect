class CompanyResourcesController < ApplicationController
  before_action :set_company_resource, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:search]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /company_resources
  def index
    @pagy, @company_resources = pagy(CompanyResource.sort_by_params(params[:sort], sort_direction))
    # Uncomment to authorize with Pundit
    # authorize @company_resources
  end

  # GET /company_resources/1 or /company_resources/1.json
  def show
  end

  # GET /company_resources/new
  def new
    @company_resource = CompanyResource.new

    # Uncomment to authorize with Pundit
    # authorize @company_resource
  end

  # GET /company_resources/1/edit
  def edit
  end

  def search
    render json: CompanyResource.search_by_name(params[:name])
  end

  # POST /company_resources or /company_resources.json
  def create
    @company_resource = CompanyResource.new(company_resource_params)

    # Uncomment to authorize with Pundit
    # authorize @company_resource

    respond_to do |format|
      if @company_resource.save
        format.html { redirect_to @company_resource, notice: "Company Resource was successfully created." }
        format.json { render :show, status: :created, location: @company_resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_resources/1 or /company_resources/1.json
  def update
    respond_to do |format|
      if @company_resource.update(company_resource_params)
        format.html { redirect_to @company_resource, notice: "Company Resource was successfully updated." }
        format.json { render :show, status: :ok, location: @company_resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_resources/1 or /company_resources/1.json
  def destroy
    @company_resource.destroy
    respond_to do |format|
      format.html { redirect_to company_resources_url, status: :see_other, notice: "Company Resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company_resource
    @company_resource = CompanyResource.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @company_resource
  rescue ActiveRecord::RecordNotFound
    redirect_to company_resources_path
  end

  # Only allow a list of trusted parameters through.
  def company_resource_params
    params.require(:company_resource).permit(:account_id, :name, :description, :account_id, :count)

    # Uncomment to use Pundit permitted attributes
    # params.require(:company_resource).permit(policy(@company_resource).permitted_attributes)
  end
end
