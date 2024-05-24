class BookmarksController < ApplicationController
  def new
    # first, find the list that you'll be adding to
    @list = List.find(params[:list_id])
    # second, initialize an empty bookmark (ready for the form entry data)
    @bookmark = Bookmark.new
  end

  def create
    # find the list that this create button is connected to - only then can you enter a new bookmark
    @list = List.find(params[:list_id])
    # "initialize" the empty book, passing it the params you get from the form
    @bookmark = Bookmark.new(bookmark_params)

    # once the bookmark is created, find the list that this create button will post to
    @bookmark.list = @list
    # if the bookmark is valid, save it and redirect to the relevant list page
    if @bookmark.save
      redirect_to list_path(@list)
      # if its invalid, render the new page to show an error message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  # make the params private to protect against SQL injection attacks
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
