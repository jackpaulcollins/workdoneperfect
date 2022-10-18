class AttributeAnswersController < ApplicationController
  before_action :set_attribute_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user_with_sign_up!

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /attribute_answers
  def index
    @pagy, @attribute_answers = pagy(AttributeAnswer.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @attribute_answers
  end

  # GET /attribute_answers/1 or /attribute_answers/1.json
  def show
  end

  # GET /attribute_answers/new
  def new
    @attribute_answer = AttributeAnswer.new

    # Uncomment to authorize with Pundit
    # authorize @attribute_answer
  end

  # GET /attribute_answers/1/edit
  def edit
  end

  # POST /attribute_answers or /attribute_answers.json
  def create
    @attribute_answer = AttributeAnswer.new(attribute_answer_params)

    # Uncomment to authorize with Pundit
    # authorize @attribute_answer

    respond_to do |format|
      if @attribute_answer.save
        format.html { redirect_to @attribute_answer, notice: "Attribute answer was successfully created." }
        format.json { render :show, status: :created, location: @attribute_answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attribute_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attribute_answers/1 or /attribute_answers/1.json
  def update
    respond_to do |format|
      if @attribute_answer.update(attribute_answer_params)
        format.html { redirect_to @attribute_answer, notice: "Attribute answer was successfully updated." }
        format.json { render :show, status: :ok, location: @attribute_answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attribute_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attribute_answers/1 or /attribute_answers/1.json
  def destroy
    @attribute_answer.destroy
    respond_to do |format|
      format.html { redirect_to attribute_answers_url, status: :see_other, notice: "Attribute answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attribute_answer
    @attribute_answer = AttributeAnswer.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @attribute_answer
  rescue ActiveRecord::RecordNotFound
    redirect_to attribute_answers_path
  end

  # Only allow a list of trusted parameters through.
  def attribute_answer_params
    params.require(:attribute_answer).permit(:employee_attribute_id, :employee_id, :answer)

    # Uncomment to use Pundit permitted attributes
    # params.require(:attribute_answer).permit(policy(@attribute_answer).permitted_attributes)
  end
end
