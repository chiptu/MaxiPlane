class CreateRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :registrations do |t|
      t.string :classe
      t.integer :nbPlace
      t.string :codeConfirmation

      t.timestamps
    end
  end
end
