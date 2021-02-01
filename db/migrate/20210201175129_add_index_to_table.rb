class AddIndexToTable < ActiveRecord::Migration[6.1]
  def change
    add_index :players, :position
  end
end
