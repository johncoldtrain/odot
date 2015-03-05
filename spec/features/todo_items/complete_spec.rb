require 'spec_helper'

describe "Completing todo items" do 

	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }

	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end


	it "is successful when marking a single item complete" do
		expect(todo_item.completed_at).to be_nil
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Mark Complete"
		end
		todo_item.reload
		expect(todo_item.completed_at).to_not be_nil
	end



end


