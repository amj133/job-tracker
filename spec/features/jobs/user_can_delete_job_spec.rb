require 'rails_helper'

describe "user can delete a job" do
  scenario "they visit job show page" do
    company = Company.create!(name: "Lockheed")
    job_1 = company.jobs.create!(title: "developer", level_of_interest: 85, city: "Denver")
    job_2 = company.jobs.create!(title: "monkey trainer", level_of_interest: 99, city: "Boston")

    visit company_job_path(company, job_1)
    click_on('Delete')

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to_not have_content('developer')
    expect(page).to have_content("monkey trainer")
  end

  # add scenario for deleting from jobs index page
end
