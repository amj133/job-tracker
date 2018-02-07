require 'rails_helper'

describe "user sees all jobs for a given location" do
  context "user visits /jobs page" do
    it "user can filter jobs by location" do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "ABC")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Developer",
                                   level_of_interest: 60,
                                   city: "Denver",
                                   category_id: category.id,
                                   company_id: company_1.id)
      job_2 = Job.create!(title: "Manager",
                                   level_of_interest: 70,
                                   city: "Denver",
                                   category_id: category.id,
                                   company_id: company_1.id)
      job_3 = Job.create!(title: "Designer",
                                   level_of_interest: 80,
                                   city: "Richmond",
                                   category_id: category.id,
                                   company_id: company_2.id)

      visit '/jobs?sort=location'

      expect(page).to have_content("Developer - Denver")
      expect(page).to have_content("Manager - Denver")
      expect(page).to have_content("Designer - Richmond")
    end
  end
end
