class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.string :date
      t.string :event
      t.string :market
      t.integer :odds1
      t.integer :odds2
      t.decimal :return
      t.string :books1
      t.string :books2

      t.timestamps
    end
  end
end
