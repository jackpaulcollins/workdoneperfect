# frozen_string_literal: true

module Jobs
  module StaffingConcern
    extend ActiveSupport::Concern

    def process_staffing_changes
      employee_ids = job_params[:employee_ids]

      # rails multiple entry form fields contain an empty string when there's
      # no value, so we check to see if there's anything other than
      # an empty string to determine if we have any changes to send to the db

      changes = employee_ids.any? { |value| value != '' }

      if changes && @job.staffed?
        update_job
      elsif changes && @job.scheduled?
        @job.staff
        update_job
      elsif !changes && @job.staffed?
        @job.reset_to_scheduled!
        maybe_destroy_employee_jobs
        update_job
      end
    end

    def maybe_destroy_employee_jobs
      @job.employee_jobs.destroy_all if @job.employee_jobs.any?
    end

    def update_job
      respond_to do |format|
        if @job.update(job_params)
          format.html { redirect_to @job, notice: 'Job was successfully unstaffed.' }
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
