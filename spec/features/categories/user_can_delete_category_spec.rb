require 'rails_helper'

describe "user can delete a category" do
  context "they visit category index page" do
    it "can delete category index" do
      red = Category.create!(title: "red")
      blue = Category.create!(title: "blue")

      visit categories_path
      click_on('Delete', match: :first)

      expect(current_path).to eq(categories_path)
      expect(page).to have_content("blue")
      expect(page).to_not have_content("red")
      expect(Category.all.count).to eq(1)
    end
  end
end
