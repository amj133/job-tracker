require 'rails_helper'

describe Contact, type: :model do
  describe "validations" do
    context "invalid attributes" do
      it { should validate_presence_of(:full_name) }
      it { should validate_presence_of(:position) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:company) }
    end
  end

  describe "relationships" do
    it { should belong_to(:company) }
  end
end
