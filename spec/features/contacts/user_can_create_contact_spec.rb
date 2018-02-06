require 'rails_helper'

describe "user can create new contact" do
  context "visits company show page" do
    it "can create new contact from company page" do
      company = Company.create!(name: "Walden")

      visits company_path(company)
      fill_in('contact[full_name]', with: "Johnny Moneymaker")
      fill_in('contact[position]', with: "BAMF")
      fill_in('contact[email]', with: "ilikefrogs@gmail.com")
      fill_in('contact[company_id]', with: 1)
      click_on('Create Contact')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("Contacts:")
      expect(page).to have_content("Contacts: Johnny Moneymaker - BAMF")
    end
  end
end
