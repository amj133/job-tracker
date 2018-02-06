require 'rails_helper'

describe Comment, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe "relationships" do
    it { should belong_to(:job) }
  end
end
