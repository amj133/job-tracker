class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.average_level_of_interest
    company_and_avg_interest = {}
    all.map do |company|
      company_and_avg_interest[company] =
        company.jobs.average(:level_of_interest)
    end
    company_and_avg_interest
  end

  def self.top_3_by_avg_interest
    average_level_of_interest.compact.sort_by do |company, avg_interest|
      -(avg_interest)
    end.first(3).to_h
  end
end
