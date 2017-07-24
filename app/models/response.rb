class Response < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  def initialize(args = {})
    super
    stance_determinator
    set_quiz_result
  end

  def stance_determinator
    # although it may appear easy, this cannot be simply dried up because the questions and answers intentionally do not have a pattern granting points to the left or right based on degree of agreement... rather the answers giving points to left or right are mixed up so that users do not consciously(or subconsiously) abuse a pattern they might have noticed.
      self.left = 0
      self.right = 0
      self.political_stance = 0


    if response_1 == "Strongly Agree"
      self.left += 3
    elsif response_1 == "Strongly Disagree"
      self.right += 3
    elsif response_1 == "Agree"
      self.left += 2
    elsif response_1 == "Disagree"
      self.right += 2
    end

    if response_2 == "Strongly Agree"
      self.left += 3
    elsif response_2 == "Strongly Disagree"
      self.right += 3
    elsif response_2 == "Agree"
      self.left += 2
    elsif response_2 == "Disagree"
      self.right += 2
    end

    if response_3 == "Strongly Agree"
      self.right += 3
    elsif response_3 == "Strongly Disagree"
      self.left += 3
    elsif response_3 == "Agree"
      self.right += 2
    elsif response_3 == "Disagree"
      self.left += 2
    end

    if response_4 == "Strongly Agree"
      self.right += 3
    elsif response_4 == "Strongly Disagree"
      self.left += 3
    elsif response_4 == "Agree"
      self.right += 2
    elsif response_4 == "Disagree"
      self.left += 2
    end

    if response_5 == "Strongly Agree"
      self.left += 3
    elsif response_5 == "Strongly Disagree"
      self.right += 3
    elsif response_5 == "Agree"
      self.left += 2
    elsif response_5 == "Disagree"
      self.right += 2
    end

    if self.left <= 1
      self.political_stance = 7
    elsif self.left >= 2 && self.left <= 4
      self.political_stance = 6
    elsif self.left >= 5 && self.left <= 6
      self.political_stance = 5
    elsif self.left >= 7 && self.left <= 8
      self.political_stance = 4
    elsif self.left >= 9 && self.left <= 10
      self.political_stance = 3
    elsif self.left >= 11 && self.left <= 13
      self.political_stance = 2
    elsif self.left >= 14 && self.left <= 15
      self.political_stance = 1
    end
  end

  def set_quiz_result
    if self.political_stance == 1
      self.quiz_result = "far left liberal"
    elsif self.political_stance == 2
      self.quiz_result = "liberal"
    elsif self.political_stance == 3
      self.quiz_result = "moderate liberal"
    elsif self.political_stance == 4
      self.quiz_result = "moderate"
    elsif self.political_stance == 5
      self.quiz_result = "moderate conservative"
    elsif self.political_stance == 6
      self.quiz_result = "conservative"
    elsif self.political_stance == 7
      self.quiz_result = "far right conservative"
    end
  end

end
