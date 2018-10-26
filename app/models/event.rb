class Event < ApplicationRecord
    has_and_belongs_to_many :users
    validates :title, presence: {message: "Please enter event title"}
    validates :desc, presence: {message: "Please enter event desc"}
end
