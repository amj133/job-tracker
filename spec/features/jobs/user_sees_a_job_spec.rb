require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    company = Company.create!(name: "ESPN")
    category = Category.create!(title: "blue")
    job = company.jobs.create!(title: "Developer",
                               level_of_interest: 70,
                               city: "Denver",
                               category_id: category.id)
    comment_1 = job.comments.create!(body: "The HR manager is Mr. Smith, I plan to contact them next tuesday 3/5.")
    comment_2 = job.comments.create!(body: "Contacted Mr. Smith on 3/5, he said they are not actively seeking a developer but will keep my info on file.")

    visit company_job_path(company, job)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end
end
