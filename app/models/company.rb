class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.top_3_by_avg_interest
    select("companies.*, AVG(level_of_interest) AS avg_interest ")
      .joins(:jobs)
      .group(:id)
      .order("avg_interest")[-3..-1]
  end
end
