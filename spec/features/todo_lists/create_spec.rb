require 'spec_helper'

describe "Creating todo lists" do

	let(:user) { create(:user) }

	before do
		sign_in user, password: "password"
	end
	# USES THE HELPER :sign_in METHOD IN authentication_helpers.rb


	def create_todo_list(options={})
		options[:title] ||= "My todo list"

		visit "/todo_lists"
		click_link "Add Todo List"
		expect(page).to have_content("Add a Todo List")

		fill_in "Title", with: options[:title]
		click_button "Save"
	end

	


	it "redirects to the todo list index page on success" do
		create_todo_list

		expect(page).to have_content("My todo list")
	end


	it "displays an error when the doto list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

	it "displays an error when the doto list has a title of less than 3 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

end