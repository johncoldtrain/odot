require 'spec_helper'

describe "Adding todo items" do 

	
	######### FACTORY GIRL FACTORIES #########
	# let(:user) { create(:user) } # not used
	let(:user) { todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	before { sign_in user, password: 'password' }
	##########################################

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link list.title
		end
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		click_link "Add Todo Item"
		fill_in "Content", with: "Milk"
		click_button "Save"
		expect(page).to have_content("Added todo list item.")
		within(".todo-items") do
			expect(page).to have_content("Milk")
		end
	end

	it "displays and error with no content" do
		visit_todo_list(todo_list)
		click_link "Add Todo Item"
		fill_in "Content", with: ""
		click_button "Save"

		within("div.alert-box") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content(/can't be blank/i)
	end

	it "displays and error with content less than 2 characters long" do
		visit_todo_list(todo_list)
		click_link "Add Todo Item"
		fill_in "Content", with: "1"
		click_button "Save"

		within("div.alert-box") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content(/is too short/i)
	end


end