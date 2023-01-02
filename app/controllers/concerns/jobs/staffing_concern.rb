module Jobs
  module StaffingConcern
    extend ActiveSupport::Concern

    def process_staffing_changes
      employee_ids = job_params[:employee_ids]

      # the employee_ids parameter will always be >= 1
      # so for exaclty 1 we know the job
      # is being un-staffed
      # in the case the job is 'scheduled'
      # check before resetting to prevent a state error

      case employee_ids.length
      when 1 && @job.scheduled?
        update_job
      when 1
        @job.reset_to_scheduled!
        update_job
      end
    end

    def update_job
      respond_to do |format|
        if @job.update(job_params)
          format.html { redirect_to @job, notice: "Job was successfully unstaffed." }
          format.json { render :show, status: :ok, location: @job }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
