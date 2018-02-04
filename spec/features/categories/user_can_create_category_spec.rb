require 'rails_helper'

describe "User can create new category" do
  context "visits category new page" do
    it "can create new category" do
      visit new_category_path

      fill_in('Title', with: "High paying")
      click_on('submit')

      expect(current_path).to eq(categories_path)
      expect(page).to have_content('High paying')
      expect(Category.all.count).to eq(1)
    end 
  end
end
