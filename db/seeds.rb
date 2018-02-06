Company.destroy_all
Job.destroy_all

COMPANIES = ["ESPN", "Aetna", "United Airlines", "Denver Public Schools", "Shopify", "Starbucks", "Pivotal Labs", "Captain U"]
JOBS = ["Engineering", "Development", "Dev Ops", "Quality Assurance", "Teacher", "Product Manager", "Consultant", "Community Manager"]
CITIES = ["Seattle", "Denver", "Portland", "Indianapolis", "Madison", "Orlando", "San Diego", "Austin", "Las Vegas", "Little Rock", "Boise", "Eugene", "Oakland"]
CATEGORIES = ["Management", "Education", "Finance", "Technical Development", "Testing"]

category_1 = Category.create!(title: "Management")
puts " Created #{category_1.title}"
category_2 = Category.create!(title: "Education")
puts " Created #{category_2.title}"
category_3 = Category.create!(title: "Finance")
puts " Created #{category_3.title}"
category_4 = Category.create!(title: "Technical Development")
puts " Created #{category_4.title}"
category_5 = Category.create!(title: "Testing")
puts " Created #{category_5.title}"

COMPANIES.each do |name|
  company = Company.create!(name: name)
  puts "Created #{company.name}"
  10.times do |num|
    company.jobs.create!(title: JOBS.sample,
                         description: "What a great position!",
                         level_of_interest: num + rand(100),
                         city: CITIES.sample,
                         category_id: rand(1..5))
    puts "  Created #{company.jobs[num].title}"
  end
end
