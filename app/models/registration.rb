class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :vol
  validates :nbPlace, presence: true
  validates :classe, presence: true, acceptance: { accept: ['Eco','Premium']}
  validates :vol_id, presence: true
  validates :user_id, presence: true
end
