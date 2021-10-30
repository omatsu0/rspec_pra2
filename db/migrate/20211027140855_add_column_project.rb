class AddColumnProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :name, :string
    add_column :projects, :description, :text
    add_column :projects, :due_on, :date
    add_reference :projects, :user, foreign_key: true
  end
end
