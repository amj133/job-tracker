require 'rails_helper'

describe "user can update a category" do
  context "links from category index to edit page" do
    it "can edit existing category" do
      category = Category.create!(title: "red")

      visit categories_path
      click_on('Edit')

      expect(current_path).to eq(edit_category_path(category))

      fill_in('Title', with: "blue")
      click_on('Update Category')

      expect(current_path).to eq(category_path(category))
      expect(page).to have_content("blue")
      expect(page).to_not have_content("red")
    end
  end
end
