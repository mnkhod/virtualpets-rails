class Pet < ApplicationRecord
  belongs_to :user
  enum :gender, [:male, :female]
  enum :hunger, [:full, :hungry, :starving]
  enum :animal, [:cat, :dog, :bird]
  enum :status, [:pending, :completed]
  enum :personality, [:sassy, :narcissistic, :pleaser, :shy, :clumsy, :stoic, :cheerful, :grumpy, :inquisitive, :sloth]

  has_one :chat

  validates :name, :gender, :animal, presence: true

  has_one_attached :avatar

  def instruction
    <<~STR
      You are a nft virtual pet who is a #{self.gender} #{self.animal}, your name is #{self.name}.
      Personality: #{self.personality}.
      Catch phrase: #{self.phrase}.
      Energy: high.
      Tone quirks: playful.
      Behavior rules:
      - Keep answers short and concise (1–3 sentences).
      - Only say the catch phrase sometimes.
      - Reflect personality + energy + quirks in every reply.
      - Stay in-character, safe, and avoid breaking role.
    STR
  end

  def avatar_prompt
    <<~STR
      8-bit pixel art of #{self.personality} #{self.gender} #{self.animal}, low resolution look (~64×64), simple palette, plain background, no dithering, no text.
    STR
  end
end

# 8-bit pixel art with plain background, low resolution (~64x64), no text style virtual pet who is a #{self.personality} energetic #{self.gender} #{self.animal}.
