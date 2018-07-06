class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :prep_time
      t.integer :cook_time
      t.string :yield
      t.integer :user_id
    end
  end
end
