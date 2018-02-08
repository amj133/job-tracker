require 'rails_helper'

describe "User deletes existing company" do
  scenario "a user can delete a company" do
    company = Company.create(name: "ESPN")

    visit companies_path
    click_link("Delete", match: :first)

    expect(page).to have_content("ESPN was successfully deleted!")
  end
end

# <%= "#{job.title} - #{job.city}" %>
