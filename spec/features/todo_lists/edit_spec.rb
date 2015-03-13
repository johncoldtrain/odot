require 'spec_helper'

describe "Editing todo lists" do

	######### FACTORY GIRL FACTORIES #########
	# let(:user) { create(:user) } # not used
	let(:user) { todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	##########################################

	before do
		sign_in todo_list.user, password: "password"
	end
	# USES THE HELPER :sign_in METHOD IN authentication_helpers.rb


	def update_todo_list(options={})
		options[:title] ||= "My todo list"

		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		click_button "Update Todo list"
	end



	it "updates a todo list successfully with correct information" do
		pending "Adding edit link for lists"
		update_todo_list 	todo_list: todo_list, title: "New title"
		
		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
	end



	it "displays an error with no title" do
		pending "Adding edit link for lists"
		update_todo_list todo_list: todo_list, title: ""

		# check that title was not changed after reloading
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)

		# test for error presence 
		expect(page).to have_content("error")
	end


	it "displays an error with too short title" do
		pending "Adding edit link for lists"
		update_todo_list todo_list: todo_list, title: "hi"
		expect(page).to have_content("error")
	end


end






