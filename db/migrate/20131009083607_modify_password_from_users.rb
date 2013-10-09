class ModifyPasswordFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :password, :string
    end
  end
end
