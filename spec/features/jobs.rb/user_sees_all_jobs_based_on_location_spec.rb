require 'rails_helper'

describe "user sees all jobs based on location" do
  context "user visits /jobs page" do
    it "user can sort jobs by location" do
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

    it "user can see jobs specific to one location" do
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

      visit '/dashboard'
      click_on('Denver')

      expect(page).to have_content("Developer: ESPN")
      expect(page).to have_content("Manager: ESPN")
      expect(page).to_not have_content("Designer")
    end
  end
end
