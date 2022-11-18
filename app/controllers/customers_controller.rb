class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /customers
  def index
    @pagy, @customers = pagy(Customer.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @customers
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new

    # Uncomment to authorize with Pundit
    # authorize @customer
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    # Uncomment to authorize with Pundit
    # authorize @customer

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, status: :see_other, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @customer
  rescue ActiveRecord::RecordNotFound
    redirect_to customers_path
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:account_id, :email, :first_name, :last_name, :phone_number)

    # Uncomment to use Pundit permitted attributes
    # params.require(:customer).permit(policy(@customer).permitted_attributes)
  end
end
