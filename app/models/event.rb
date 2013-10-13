class Event < ActiveRecord::Base
  has_many :talks, dependent: :destroy

  validates :title, presence: true
end
