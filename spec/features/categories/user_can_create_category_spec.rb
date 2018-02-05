require 'rails_helper'

describe "User can create new category" do
  context "visits category new page" do
    it "can create new category" do
      visit new_category_path

      fill_in('Title', with: "High paying")
      click_on('Create Category')

      expect(current_path).to eq(categories_path)
      expect(page).to have_content('High paying')
      expect(Category.all.count).to eq(1)
    end
  end

  context "if category already exists" do
    it "redirects user to new page" do
      Category.create!(title: "blue")

      visit new_category_path

      fill_in('Title', with: "blue")
      click_on('Create Category')

      expect(page).to have_content('Create a new Category here!')
      expect(Category.all.count).to eq(1)
    end
  end
end
