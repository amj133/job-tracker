require 'rails_helper'

describe "user can see all jobs in category" do
  it "lists all relevant jobs on category show page" do
    blue = Category.create!(title: "blue")
    red = Category.create!(title: "red")
    company = Company.create!(name: "ESPN")
    job_1 = blue.jobs.create!(title: "developer",
                              level_of_interest: 85,
                              city: "Denver",
                              company_id: company.id,
                              category_id: blue.id)
    job_2 = blue.jobs.create!(title: "monkey trainer",
                              level_of_interest: 99,
                              city: "Richmond",
                              company_id: company.id,
                              category_id: blue.id)
    job_3 = red.jobs.create!(title: "zynergist",
                              level_of_interest: 56,
                              city: "Minneapolis",
                              company_id: company.id,
                              category_id: red.id)

    visit category_path(blue)

    expect(page).to have_content("developer")
    expect(page).to have_content("monkey trainer")
    expect(page).to_not have_content("zynergist")
  end
end
