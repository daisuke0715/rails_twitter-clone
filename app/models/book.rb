class Book < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, null: false
    validates :body, presence: true, null: false
    validates :body, length: { maximum: 200 }
end
