class CommentsController < ApplicationController

  def new
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
        redirect_to controller: 'users', action: 'show', id: params[:entry_user_id]
      else
        flash[:error] = comment.errors.full_messages[0]
        redirect_to controller: 'comments', action: 'new', format: params[:commentable_id]
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @entry = Entry.find(@comment.commentable_id)
    render 'comments/edit'
  end

  def update
    comment = Comment.find(params[:id])
    comment.body = params[:body]
    if comment.save
      redirect_to controller: 'users', action: 'show', id: params[:entry_user_id]
    else
      flash[:error] = comment.errors.full_messages[0]
      redirect_to controller: 'comments', action: 'edit', comment: comment.id
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to controller: 'users', action: 'show', id: params[:entry_user]
  end

end
