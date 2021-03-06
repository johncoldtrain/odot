require 'spec_helper'

describe "Deleting todo items" do 

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

	it "is successful" do
		visit_todo_list(todo_list)
		click_on todo_item.content
		click_link "Delete"
		
		expect(page).to have_content("Todo list item was deleted.")
		expect(TodoItem.count).to eq(0)
	end

end
