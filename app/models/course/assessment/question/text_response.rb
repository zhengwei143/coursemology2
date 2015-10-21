class Course::Assessment::Question::TextResponse < ActiveRecord::Base
  acts_as :question, class_name: Course::Assessment::Question.name, inverse_of: :actable

  has_many :solutions, class_name: Course::Assessment::Question::TextResponseSolution.name,
                       dependent: :destroy, foreign_key: :question_id, inverse_of: :question

  accepts_nested_attributes_for :solutions

  def attempt(submission)
    submission.text_response_answers.build(submission: submission, question: question).answer
  end
end
