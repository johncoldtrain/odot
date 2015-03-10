require 'spec_helper'

describe User do

  let(:valid_attributes) {
  	{
  	  first_name: "Alex",
  	  last_name: "Romanillos",
  	  email: "alex@email.com",
  	  password: "password",
  	  password_confirmation: "password"
  	}
  }

  context "relationships" do
    it { should have_many(:todo_lists) }
  end

  context "validations" do
  	let(:user) { User.new(valid_attributes)}

  	before do 
  		User.create(valid_attributes)
  	end

  	it "requires an email" do
  		expect(user).to validate_presence_of(:email)
  	end

  	it "requires a unique email" do
  		expect(user).to validate_uniqueness_of(:email)
  	end

  	it "requires the email address to look like an email address" do
  		user.email = "alex"
  		expect(user).to_not be_valid
  	end


  	it "downcases an email before saving" do
  		user = User.new(valid_attributes)
  		user.email = "MIKE@TEAMTREEHOUSE.COM"
  		expect(user.save).to be_truthy
  		expect(user.email).to eq("mike@teamtreehouse.com")
  	end

  end

end
