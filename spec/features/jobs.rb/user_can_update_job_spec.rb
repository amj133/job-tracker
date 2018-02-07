require 'rails_helper'

describe "User can update a job" do
  it "they are linked from job index to edit page" do
    company = Company.create!(name: "Lockheed")
    red = Category.create!(title: "red")
    blue = Category.create!(title: "blue")
    job = company.jobs.create!(title: "developer",
                               level_of_interest: 85,
                               city: "Denver",
                               company_id: company.id,
                               category_id: red.id)

    visit company_jobs_path(company)
    click_link('Edit')
    fill_in('Title', with: 'Manager')
    fill_in('Level of interest', with: 94)
    select('blue', :from => 'job[category_id]')
    click_on('Update Job')

    expect(current_path).to eq(company_jobs_path(company))
    expect(page).to have_content('Manager')
    expect(company.jobs.first.title).to eq('Manager')
    expect(company.jobs.first.category.title).to eq('blue')
  end
end
