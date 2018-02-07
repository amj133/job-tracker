require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end

    it { should have_many(:contacts) }
  end

  describe "class methods" do
    it "#average_level_of_interest returns ordered list of each company's average" do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "ABC")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Designer",
                          level_of_interest: 80,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_2.id)
      job_2 = Job.create!(title: "Manager",
                          level_of_interest: 70,
                          city: "Albany",
                          category_id: category.id,
                          company_id: company_2.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 70,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)

      sorted_by_average_interest = Company.avereage_level_of_interest

      expect(sorted_by_average_interest).to eq(company_1 => 65, company_2 => 75)
    end
  end
end
