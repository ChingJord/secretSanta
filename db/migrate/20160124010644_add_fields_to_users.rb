class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :partner, null: false, default: ""
      t.string :last_assigned
    end
  end
end
