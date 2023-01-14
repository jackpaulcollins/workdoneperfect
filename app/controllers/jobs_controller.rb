# frozen_string_literal: true

class JobsController < ApplicationController
  include Jobs::StaffingConcern

  before_action :set_job, only: %i[show edit update destroy staff add_employees]
  before_action :authenticate_user!
  # handles logic for changing job state depending on appropriate staffing changes
  before_action :process_staffing_changes, only: :add_employees

  helper_method :job_required_staff_list, :job_not_required_staff_list

  def index
    @pagy, @jobs = pagy(Job.sort_by_params(params[:sort], sort_direction))
  end

  def show
  end

  def new
    @job = if JobTemplate.default_template.present? && job_params.blank?
      Job.new(job_template: JobTemplate.default_template)
    elsif job_params.present?
      Job.new(job_template_id: job_params[:job_template_id])
    else
      Job.new
    end

    @job
  end

  def edit
  end

  def staff
  end

  def add_employees
    respond_to do |format|
      if @job.update(job_params)
        @job.staff! unless @job.staffed?
        format.html { redirect_to @job, notice: "Job was successfully staffed." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        @job.schedule unless params[:draft].present?

        format.html { redirect_to @job, notice: "Job was successfully created." }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
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

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, status: :see_other, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to jobs_path
  end

  def job_required_staff_list
    Employee.joins(:employee_template).where(employee_templates: {title: @job.job_template.required_resources})
  end

  def job_not_required_staff_list
    Employee.joins(:employee_template).where.not(employee_templates: {title: @job.job_template.required_resources})
  end

  def job_params
    params.fetch(:job, {}).permit(
      :job_template_id,
      :account_id,
      :customer_id,
      :date_and_time,
      :estimated_hours,
      :total_hours,
      :revenue,
      :state,
      job_attribute_answers_attributes: %i[id job_attribute_id answer _destroy],
      company_resource_ids: [],
      employee_ids: []
    )
  end
end
