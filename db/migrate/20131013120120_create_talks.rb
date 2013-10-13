class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title, :null => false
      t.string :description

      t.timestamps
    end
  end
end
