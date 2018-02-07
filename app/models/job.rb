class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :delete_all

  def self.location_sort
    select(:title, :city)
      .order(:city)
  end

  def self.count_by_interest
    select("jobs.*")
      .group(:level_of_interest)
      .order(level_of_interest: :desc)
      .count
  end

  def self.count_by_location
    select("jobs.*")
      .group(:city)
      .count
  end

  def self.sort_by_interest
    select("jobs.*")
      .order(level_of_interest: :desc)
  end
end
