class Talk < ActiveRecord::Base
  belongs_to :event

  validates :title, presence: true
end
