class ComicsController < ApplicationController
  def index
    @comic = Comic.last
  end

  def show
    @comic = Comic.find_by_id(params[:id])
    if @comic
      render 'index'
    else
      redirect_to :root
    end
  end

end
