require 'rails_helper'

describe Job, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80,
                      description: "Wahoo",
                      city: "Denver",
                      company_id: 1,
                      category_id: 1)
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer",
                      description: "Wahoo",
                      city: "Denver",
                      company_id: 1,
                      category_id: 1)
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer",
                      description: "Wahoo",
                      level_of_interest: 80,
                      company_id: 1,
                      category_id: 1)
        expect(job).to be_invalid
      end

      it "is invalid without a company" do
        job = Job.new(title: "Developer",
                      description: "Wahoo",
                      city: "Denver",
                      level_of_interest: 80,
                      category_id: 1)
        expect(job).to be_invalid
      end

      it "is invalid without a category" do
        job = Job.new(title: "Developer",
                      description: "Wahoo",
                      city: "Denver",
                      level_of_interest: 80,
                      company_id: 1)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, city, company, and category" do
        category = Category.create!(title: "red")
        company = Company.create!(name: "Turing")
        job = Job.new(title: "Developer",
                      level_of_interest: 40,
                      city: "Denver",
                      company_id: company.id,
                      category_id: category.id)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it { should belong_to(:company) }
    it { should belong_to(:category) }
  end
end
