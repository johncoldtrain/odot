require 'spec_helper'

describe "Editing todo items" do 

	######### FACTORY GIRL FACTORIES #########
	# let(:user) { create(:user) } # not used
	let(:user) { todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	before { sign_in user, password: 'password' }
	##########################################

	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }


	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link list.title
		end
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link todo_item.content
		end
		fill_in "Content", with: "Lots of Milk"
		click_button "Save"
		expect(page).to have_content("Saved todo list item.")
		todo_item.reload
		expect(todo_item.content).to eq("Lots of Milk")
	end


	it "is unsuccessful with no content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link todo_item.content
		end
		fill_in "Content", with: ""
		click_button "Save"
		expect(page).to have_content(/can't be blank/i)
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

	it "is unsuccessful with no long enough content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link todo_item.content
		end
		fill_in "Content", with: "1"
		click_button "Save"
		expect(page).to have_content(/is too short/i)
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end


end




