class ComicsController < ApplicationController
  def index
    @comics = Comic.all
  end
end
