class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :user_name
      t.boolean :is_bot
      t.timestamps
    end
  end
end
