class Review < ActiveRecord::Base
  acts_as_votable
  belongs_to :property
  has_many :comments, :dependent => :destroy
  validates :review, :presence => true
  
  def score
    return self.get_upvotes.size - self.get_downvotes.size
  end
end