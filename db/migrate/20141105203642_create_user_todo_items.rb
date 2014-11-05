class CreateUserTodoItems < ActiveRecord::Migration
  def change
  	create_table :user_todo_items do |t|
  		t.string :description
  		t.string :due
  		t.string :user_id
  	end
  end
end
