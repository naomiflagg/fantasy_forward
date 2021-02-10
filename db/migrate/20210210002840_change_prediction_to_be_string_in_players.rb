class ChangePredictionToBeStringInPlayers < ActiveRecord::Migration[6.1]
  def change
    change_column :players, :prediction, :float
  end
end
