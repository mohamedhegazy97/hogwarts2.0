class Spell < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :short_name, presence: true
  validates :description, presence: true
end
