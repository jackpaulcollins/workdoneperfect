class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /resources
  def index
    @pagy, @resources = pagy(Resource.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @resources
  end

  # GET /resources/1 or /resources/1.json
  def show
  end

  # GET /resources/new
  def new
    @resource = Resource.new

    # Uncomment to authorize with Pundit
    # authorize @resource
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources or /resources.json
  def create
    @resource = Resource.new(resource_params)

    # Uncomment to authorize with Pundit
    # authorize @resource

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: "Resource was successfully created." }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1 or /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: "Resource was successfully updated." }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1 or /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, status: :see_other, notice: "Resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_resource
    @resource = Resource.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @resource
  rescue ActiveRecord::RecordNotFound
    redirect_to resources_path
  end

  # Only allow a list of trusted parameters through.
  def resource_params
    params.require(:resource).permit(:name, :description, :account_id, :count)

    # Uncomment to use Pundit permitted attributes
    # params.require(:resource).permit(policy(@resource).permitted_attributes)
  end
end
