class CommentsController < ApplicationController

  def new
    p '*' * 80
    p "im new"
    p params
    @entry = Entry.find(params[:format])
    render 'comments/new'
  end

  def create
    comment = Comment.new
    comment.commentable_id = params[:commentable_id]
    comment.commentable_type = params[:commentable_type]
    comment.body = params[:body]
    comment.user_id = current_user.id
    if comment.body == ""
      flash[:error] = "Comment body must not be blank."
      redirect_to controller: 'comments', action: 'new', format: params[:commentable_id]
    else
      if comment.save
        flash[:notice] = "Your comment was saved!"
        redirect_to controller: 'users', action: 'show', id: current_user.id
      else
        flash[:error] = comment.errors.full_messages
        redirect_to controller: 'comments', action: 'new', format: params[:commentable_id]
      end
    end
  end

  def edit
    p "*" * 80
    p 'im edit'
  end

  def update
    p '*' * 80
    p 'im update'
  end

  def destroy
    p '*' * 80
    p 'im delete'
  end

end
