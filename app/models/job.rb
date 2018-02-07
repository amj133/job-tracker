class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :delete_all


  def self.location_sort
    select(:title, :city).order(:city)
  end
end
