class Player < ApplicationRecord
  belongs_to :team
  validates :first_name, :last_name, presence: true
end
