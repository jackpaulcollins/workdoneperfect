module JobTemplateAnswersConcern
  extend ActiveSupport::Concern

  def build_answers(answers)
    answers.each do |answer|
      attribute_id = answer[0]
      answer = answer[1][:answer][0]
      @job.set_template_answers(attribute_id, answer)
    end
  end
end
