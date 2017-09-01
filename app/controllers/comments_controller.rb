class CommentsController < ApplicationController

  def create
    p '*' * 100
    p "im create"
    
  end

  def edit
    p "*" * 100
    p 'im edit'
  end

  def update
    p '*' * 100
    p 'im update'
  end

  def destroy
    p '*' * 100
    p 'im delete'
  end

end
