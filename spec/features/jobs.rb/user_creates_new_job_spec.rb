require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "blue")
    visit new_company_job_path(company)

    fill_in("job[title]", with: "Developer")
    fill_in("job[description]", with: "So fun!")
    fill_in("job[level_of_interest]", with: 80)
    fill_in("job[city]", with: "Denver")
    select('blue', :from => 'job[category_id]')
    click_button("Create")

    expect(current_path).to eq("/jobs/#{Job.last.id}")
    expect(page).to have_content("Company: ESPN")
    expect(page).to have_content("Title: Developer")
    expect(page).to have_content("Level of Interest: 80")
    expect(page).to have_content("City: Denver")
    expect(page).to have_content("Category: blue")
  end
end
