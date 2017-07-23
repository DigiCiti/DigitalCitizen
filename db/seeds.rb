# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

max_users = 15
users_needed = max_users - User.count

users_needed.times do
  person = {}
  person[:username] = Faker::Internet.user_name(5..8)
  person[:email] = Faker::Internet.safe_email
  person[:password] = Faker::Internet.password(5, 10)

  user = User.create(person)

end

max_quizzes = 15
quizzes_needed = max_quizzes - Quiz.count

quizzes_needed.times do
  quiz_questions = {}
  quiz_questions[:question_1] = 'Global warming is a man-made problem.'
  quiz_questions[:question_2] = 'Abortions should be legal under certain circumstances.'
  quiz_questions[:question_3] = 'The most successful and wealtheist citizens of a nation are the primary driving force of national success.'
  quiz_questions[:question_4] = 'Government regulations interfere with freedom more than they help protect it.'
  quiz_questions[:question_5] = 'We need a large government in order to handle all large scale issues where the prosperity of the public is at stake.'

  quiz = Quiz.create(quiz_questions)

end

max_responses = 15
responses_needed = max_responses - Response.count

responses_needed.times do
  response_set = {}
  response_set[:response_1] = ["Strongly Disagree", "Disagree", "Somewhat Agree", "Agree", "Strongly Agree"].sample
  response_set[:response_2] = ["Strongly Disagree", "Disagree", "Somewhat Agree", "Agree", "Strongly Agree"].sample
  response_set[:response_3] = ["Strongly Disagree", "Disagree", "Somewhat Agree", "Agree", "Strongly Agree"].sample
  response_set[:response_4] = ["Strongly Disagree", "Disagree", "Somewhat Agree", "Agree", "Strongly Agree"].sample
  response_set[:response_5] = ["Strongly Disagree", "Disagree", "Somewhat Agree", "Agree", "Strongly Agree"].sample
  response_set[:quiz_id] = [1, 2, 3, 4, 5].sample
  response_set[:user_id] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].sample
  response_set[:quiz_result] = ['far left liberal', 'liberal', 'moderate liberal', 'moderate', 'moderate conservative', 'conservative', 'far right conservative'].sample

  response = Response.create(response_set)

end
