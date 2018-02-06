require 'rails_helper'

describe "user can create new contact" do
  context "visits company show page" do
    it "can create new contact from company page" do
      company = Company.create!(name: "Walden")
      category = Category.create!(title: "blue")
      company.contacts.create!(full_name: "Sally Blue",
                               position: "Manager",
                               email: "sallyblue@gmail.com")
      company.jobs.create!(title: "Developer",
                           level_of_interest: 70,
                           city: "Denver",
                           category_id: category.id)

      visit company_path(company)
      fill_in('contact[full_name]', with: "Johnny Moneymaker")
      fill_in('contact[position]', with: "BAMF")
      fill_in('contact[email]', with: "ilikefrogs@gmail.com")
      click_on('Create Contact')
      
      expect(current_path).to eq(company_jobs_path(company))
      expect(page).to have_content("Contacts:")
      expect(page).to have_content("Sally Blue - Manager")
      expect(page).to have_content("Johnny Moneymaker - BAMF")
    end
  end
end
