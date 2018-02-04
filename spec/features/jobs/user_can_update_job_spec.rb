require 'rails_helper'

describe "User can update a job" do
  scenario "they are linked from job index to edit page" do
    company = Company.create!(name: "Lockheed")
    job = company.jobs.create!(title: "developer", level_of_interest: 85, city: "Denver")

    visit company_jobs_path(company)
    click_link('Edit')
    fill_in('Title', with: 'Manager')
    fill_in('Level of interest', with: 94)
    click_on('Update Job')

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to have_content('Manager')
  end
end
