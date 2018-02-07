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
    it { should have_many(:comments) }
  end

  describe "class methods" do
    it "#location_sort will sort jobs by location" do
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
                          company_id: company_1.id)
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

      sorted_jobs = Job.location_sort

      expect(sorted_jobs.first.city).to eq("Albany")
      expect(sorted_jobs.first.title).to eq("Manager")
      expect(sorted_jobs.last.city).to eq("Richmond")
      expect(sorted_jobs.last.title).to eq("Designer")
    end

    it "#count_by_interest will count jobs by level of interest" do
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
                          company_id: company_1.id)
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

      job_count_by_interest = Job.count_by_interest

      expect(job_count_by_interest).to eq({80 => 1, 70 => 2, 60 => 1})
    end

    it "#count_by_location returns job count for each location" do
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
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
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

      job_count_by_location = Job.count_by_location

      expect(job_count_by_location).to eq({"Denver" => 3, "Richmond" => 1})
    end

    it "#sort_by_interest returns jobs sorted by level of interst" do
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
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 75,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)

      jobs_by_interest = Job.sort_by_interest

      expect(jobs_by_interest).to eq([job_1, job_4, job_2, job_3])
    end

    it "#find_by_location returns jobs for given location" do
      company_1 = Company.create!(name: "ESPN")
      category = Category.create!(title: "blue")
      job_1 = Job.create!(title: "Designer",
                          level_of_interest: 80,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_2.id)
      job_2 = Job.create!(title: "Manager",
                          level_of_interest: 70,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)
      job_3 = Job.create!(title: "Developer",
                          level_of_interest: 60,
                          city: "Richmond",
                          category_id: category.id,
                          company_id: company_1.id)
      job_4 = Job.create!(title: "Communicator",
                          level_of_interest: 75,
                          city: "Denver",
                          category_id: category.id,
                          company_id: company_1.id)

      denver_jobs = Job.find_by_location("Denver")

      expect(denver_jobs).to eq([job_2, job_4])
    end
  end
end
