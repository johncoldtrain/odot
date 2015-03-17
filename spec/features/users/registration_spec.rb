require "spec_helper"

describe "Signing up" do
	
	it "allows a user to sing up for the site and creates the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First Name", with: "Alex"
		fill_in "Last Name", with: "Romanillos"
		fill_in "Email", with: "alex@email.com"
		fill_in "Password", with: "password"
		fill_in "Password (again)", with: "password"
		click_button "Sign Up"

		expect(User.count).to eq(1)
	end


	 it "displays a tutorial when the user signs up" do
	  
	  visit "/"
	  expect(page).to have_content("Sign Up")
		click_link "Sign Up"

	  fill_in "First Name", with: "Alex"
		fill_in "Last Name", with: "Romanillos"
		fill_in "Email", with: "alex@email.com"
		fill_in "Password", with: "password"
		fill_in "Password (again)", with: "password"
		click_button "Sign Up"

	   expect(page).to have_content("ODOT Tutorial")
	   click_on "ODOT Tutorial"

	   expect(page.all("li.todo-item").size).to eq(7)
	 end  



end