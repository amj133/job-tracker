require 'rails_helper'

describe "user sees all categories" do
  scenario "user visits categories index" do
    category_1 = Category.create!(title: "blue")
    category_2 = Category.create!(title: "red")

    visit categories_path

    expect(page).to have_content("All Categories")
    expect(page).to have_content("blue")
    expect(page).to have_content("red")
    expect(page).to have_content("Create a New Category")
  end
end
