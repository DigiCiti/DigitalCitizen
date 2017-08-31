class EntriesController < ApplicationController

  def create
    entry = Entry.new
    entry.user_id = current_user.id
    entry.title = params[:title]
    entry.body = params[:body]
    entry.entry_type = params[:entry_type]
    if entry.body == ""
      flash[:error] = "Post body must not be blank."
    else
      if entry.save
        flash[:notice] = "Your post was saved!"
      else
        flash[:error] = entry.errors.full_messages
      end
    end
    redirect_to controller: 'users', action: 'show', id: current_user.id
  end

  def edit
    render 'entries/_edit'
  end

  def update
    entry = Entry.find(params[:id])
    entry.title = params[:title]
    entry.body = params[:body]
    if entry.save
      redirect_to controller: 'users', action: 'show', id: current_user.id
    else
      flash[:error] = entry.errors.full_messages
      redirect_to controller: 'entries', action: 'edit', post: entry.id
    end
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy
    redirect_to controller: 'users', action: 'show', id: current_user.id
  end

end
