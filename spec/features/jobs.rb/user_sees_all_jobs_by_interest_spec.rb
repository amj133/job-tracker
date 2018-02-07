require 'rails_helper'

describe "user sees all jobs by interest" do
  context "user visits job index with param sort=interest" do
    it "displays all jobs sorted by interest" do
      company_1 = Company.create!(name: "ESPN")
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
                          company_id: company_1.id)
      job_4 = Job.create!(title: "Designer!!!",
                          level_of_interest: 72,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_1.id)

      visit '/jobs?sort=interest'

      expect(page).to have_content("Designer: 80")
      expect(page).to have_content("Designer!!!: 72")
      expect(page).to have_content("Manager: 70")
      expect(page).to have_content("Developer: 60")
    end
  end
end
