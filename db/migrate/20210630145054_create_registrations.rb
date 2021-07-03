class CreateRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :registrations do |t|
      t.string :classe
      t.integer :nbPlace
      t.string :codeConfirmation
      t.belongs_to :vol
      t.belongs_to :user

      t.timestamps
    end
  end
end
