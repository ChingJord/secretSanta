class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :partner
      t.string :last_assigned
      t.timestamps
    end
  end
end
