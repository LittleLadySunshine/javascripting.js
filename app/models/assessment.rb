class Assessment < ActiveRecord::Base

  belongs_to :assessor, class_name: "User", foreign_key: :assessor_id
  belongs_to :user
  belongs_to :rubric

  validates :assessor, presence: true
  validates :user, presence: true
  validates :rubric, presence: true
  validates :date, presence: true
  validates :questions_json, presence: true

  def set_response_json(json)
    responses = []
    rubric.questions.each_with_index do |question, index|
      responses << {
        question: question.title,
        question_type: question.question_type,
        response: question.format_answer(json[index.to_s])
      }
    end
    self.responses_json = responses
  end

end
