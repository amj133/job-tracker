require 'rails_helper'

describe "user can delete a job" do
  scenario "they visit job show page" do
    company = Company.create!(name: "Lockheed")
    category = Category.create!(title: "blue")
    job_1 = company.jobs.create!(title: "developer",
                                 level_of_interest: 85,
                                 city: "Denver",
                                 category_id: category.id)
    job_2 = company.jobs.create!(title: "monkey trainer",
                                 level_of_interest: 99,
                                 city: "Boston",
                                 category_id: category.id)

    visit company_job_path(company, job_1)
    click_on('Delete')

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to_not have_content('developer')
    expect(page).to have_content("monkey trainer")
    expect(company.jobs.count).to eq(1)
  end

  scenario "they visit company jobs page" do
    company = Company.create!(name: "Lockheed")
    category = Category.create!(title: "blue")
    job_1 = company.jobs.create!(title: "developer",
                                 level_of_interest: 85,
                                 city: "Denver",
                                 category_id: category.id)
    job_2 = company.jobs.create!(title: "monkey trainer",
                                 level_of_interest: 99,
                                 city: "Boston",
                                 category_id: category.id)

    visit company_jobs_path(company)
    click_on('Delete', match: :first)

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to_not have_content('developer')
    expect(page).to have_content("monkey trainer")
    expect(company.jobs.count).to eq(1)
  end
end
