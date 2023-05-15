class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :player_one, null: false, foreign_key: true, foreign_key: { to_table: :players }
      t.references :player_two, null: false, foreign_key: true, foreign_key: { to_table: :players }
      t.references :winner, null: true, foreign_key: true, default: nil, foreign_key: { to_table: :players }
      t.integer :status, null: false, default: 1
      t.integer :game_type, null: false, default: 1
      t.timestamps
    end
  end
end
