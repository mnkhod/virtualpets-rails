class Pet < ApplicationRecord
  belongs_to :user
  enum :gender, [:male, :female]
  enum :hunger, [:full, :hungry, :starving]
  enum :animal, [:cat, :dog, :bird]
  enum :status, [:pending, :completed]
  enum :personality, [:sassy, :narcissistic, :pleaser, :shy, :clumsy, :stoic, :cheerful, :grumpy, :inquisitive, :sloth]

  validates :name, :gender, :animal, presence: true
end
