class Comic < ActiveRecord::Base

  def last?
    self == Comic.last
  end

  def first?
    self == Comic.first
  end

  def next
    Comic.find(self.id + 1)
  end
  
  def prev
    Comic.find(self.id - 1)
  end
end
