class Comment < ActiveRecord::Base
  belongs_to :article
  validates :body, presence: true
  validates_presence_of :article
  validates_presence_of :name
  validates_associated :article
end
