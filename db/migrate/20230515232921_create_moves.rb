class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.references :player, null: false, foreign_key: true, foreign_key: { to_table: :players }
      t.references :game, null: false, foreign_key: true, foreign_key: { to_table: :games }
      t.integer :position, null: false
      t.timestamps
    end
  end
end
