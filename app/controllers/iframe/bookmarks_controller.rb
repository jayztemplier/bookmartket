class Iframe::BookmarksController < ApplicationController

  before_filter :find_user

  def index
    if params[:search_term]
      @bookmarks = Bookmark.search( params[:search_term] )
    else
      @bookmarks = $user.bookmarks
    end
    render :json => @bookmarks
  end

  def create
    @bookmark         = Bookmark.new(params[:bookmark])
    @bookmark.user_id = $user.id

    if @bookmark.save
      render :json => @bookmark
    else
      render :status => :conflict, :json => {:errors => @bookmark.errors}
    end
  end
end