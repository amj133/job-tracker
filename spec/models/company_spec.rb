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
    it "#top_3_by_avg_interest returns top 3 companies" do
      company_1 = Company.create!(name: "ESPN")
      company_2 = Company.create!(name: "ABC")
      company_3 = Company.create!(name: "CBS")
      company_4 = Company.create!(name: "NBC")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Designer",
                          level_of_interest: 80,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_1.id)
      job_2 = Job.create!(title: "Manager",
                          level_of_interest: 50,
                          city: "Albany",
                          category_id: category.id,
                          company_id: company_2.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_3.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 70,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_4.id)

      top_3_companies = Company.top_3_by_avg_interest

      expect(top_3_companies).to eq[company_3, company_4, company_1]
    end
  end
end
