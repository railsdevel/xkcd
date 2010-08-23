class Comic < ActiveRecord::Base

  def last?
    self == Comic.last
  end

  def first?
    self == Comic.first
  end
end
