require 'rails_helper'

describe "user sees analytics on dashboard" do
  context "user visits dashboard" do
    it "displays a count of jobs by level of interest" do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "ABC")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Designer",
                          level_of_interest: 80,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_2.id)
      job_2 = Job.create!(title: "Manager",
                          level_of_interest: 70,
                          city: "Albany",
                          category_id: category.id,
                          company_id: company_1.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 70,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)

      visit '/dashboard'

      expect(page).to have_content("Level of Interest : Number of Jobs")
      expect(page).to have_content("80 : 1")
      expect(page).to have_content("70 : 2")
      expect(page).to have_content("60 : 1")
    end

    it "displays top 3 companies by avg level of interest" do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "ABC")
      company_3 = Company.create!(name: "CBS")
      company_4 = Company.create!(name: "NBC")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Designer",
                          level_of_interest: 80,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_1.id)
      job_2 = Job.create!(title: "Manager",
                          level_of_interest: 50,
                          city: "Albany",
                          category_id: category.id,
                          company_id: company_2.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_3.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 70,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_4.id)

      visit '/dashboard'

      expect(page).to have_content("Top 3 Companies by Average Level of Interest")
      expect(page).to have_content("ESPN : 80")
      expect(page).to have_content("NBC : 70")
      expect(page).to have_content("CBS : 60")
    end

    it "displays count of jobs by location" do
      company_1 = Company.create!(name: "ESPN")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Designer",
                          level_of_interest: 80,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_1.id)
      job_2 = Job.create!(title: "Manager",
                          level_of_interest: 50,
                          city: "Albany",
                          category_id: category.id,
                          company_id: company_1.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 70,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)

      visit '/dashboard'

      expect(page).to have_content("Job Count by Location")
      expect(page).to have_content("Denver : 2")
      expect(page).to have_content("Richmond : 1")
      expect(page).to have_content("Albany : 1")
    end
  end
end
