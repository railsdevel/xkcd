class ComicsController < ApplicationController
  def index
    @comics = Comic.last
  end

  def show
    @comics = Comic.find(params[:id])
    render 'index'
  end
end
