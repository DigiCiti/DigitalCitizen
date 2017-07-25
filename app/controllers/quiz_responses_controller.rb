class QuizResponsesController < ApplicationController
  before_action :authorize
  skip_before_action :verify_authenticity_token

  def new
    @quiz = Quiz.first #will need to change if there are ever more quizes with diff questions
  end

  def create
    params[:response][:user_id] = current_user.id
    # named @resp because ruby/rails has built in variable named response
    @resp = Response.new(response_params)
    if @resp.save
      redirect_to "/quiz_responses/#{@resp.id}"
    else
      @errors = @resp.errors.full_messages
      redirect_to '/quiz_responses/new', flash: { error: 'Your responses were not saved, please try again.' }
    end
  end

  def show
    @resp = Response.find(params[:id])
  end

  private

  def response_params
    params.require(:response).permit(:response_1, :response_2, :response_3, :response_4, :response_5, :user_id, :quiz_id)
  end

end
