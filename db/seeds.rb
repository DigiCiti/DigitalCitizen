# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'uri'
require 'net/http'

# SEEDING USERS
max_users = 15
users_needed = max_users - User.count

users_needed.times do
  person = {}
  person[:username] = Faker::Internet.user_name(5..8)
  person[:email] = Faker::Internet.safe_email
  person[:password] = Faker::Internet.password(5, 10)

  url = URI("https://randomuser.me/api/")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request["cache-control"] = 'no-cache'
  request["postman-token"] = '8c2b29ca-04f5-6c84-1828-d437e372d707'
  response = http.request(request)
  json_user = JSON.parse(response.read_body)
  parsed_photo = json_user["results"][0]["picture"]["large"]

  person[:avatar] = parsed_photo

  user = User.create(person)

end

User.create(username: "MikeT", email: "m@m.com", password: "pass", avatar: "https://github.com/MikeTarkington/mike_tarkington_site/blob/master/square_profile_img_hr.png?raw=true")

# SEEDING BASE QUIZ
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

# SEEDING QUIZ RESPONSES
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

# SEEDING FRIENDSHIPS
max_friendships = 100
friendships_needed = max_friendships - Friendship.count

friendships_needed.times do
  friendship_info = {}
  friendship_info[:user_id] = rand(1..15)
  friendship_info[:status] = ["approved", "unanswered"].sample
  request_recipient = rand(1..15)
  until request_recipient != friendship_info[:user_id]
    request_recipient = rand(1..15)
  end
  friendship_info[:friended_user] = request_recipient

  friendship = Friendship.create(friendship_info)
  # note this seeded data allows for possible duplicate frienships

end

15.times do
  Friendship.create(user_id: 16, friended_user:rand(1..15), status: ["approved", "unanswered"].sample)
end

15.times do
  Friendship.create(user_id: rand(1..15), friended_user: 16, status: ["approved", "unanswered"].sample)
end

# SEEDING ENTRIES
max_entries = 50
entries_needed = max_entries - Entry.count

entries_needed.times do
  entry_data = {}
  entry_data[:user_id] = rand(1..15)
  entry_data[:title] = Faker::StarWars.planet
  entry_data[:body] = Faker::ChuckNorris.fact
  entry_data[:entry_type] = ["profile_post", "memo", "group_page"].sample

  Entry.create(entry_data)
end


30.times do
  Entry.create(user_id: 16, title: Faker::GameOfThrones.character, body: Faker::ChuckNorris.fact, entry_type: ["profile_post", "memo", "group_page"].sample)
end

# SEEDING COMMENTS
max_comments = 50
comments_needed = max_comments - Comment.count

comments_needed.times do
  comment_data = {}
  comment_data[:user_id] = rand(1..16)
  comment_data[:body] = Faker::StarWars.quote
  comment_data[:commentable_id] = rand(1..15)
  comment_data[:commentable_type] = "Entry"

  Comment.create(comment_data)
end

mikes_posts = Entry.where("user_id = '16' and entry_type = 'profile_post'")
mikes_posts.each do |post|
  comment_data = {}
  rand(1..5).times do
    comment_data[:user_id] = rand(1..16)
    comment_data[:body] = Faker::StarWars.quote
    comment_data[:commentable_id] = post.id
    comment_data[:commentable_type] = "Entry"

    Comment.create(comment_data)
  end
end
