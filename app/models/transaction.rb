class Transaction < ApplicationRecord
  belongs_to :user
  enum :status, [:pending, :completed]

  after_create_commit -> { broadcast_created }
  after_update_commit -> { broadcast_update }

  private

  def broadcast_created
    broadcast_append_to(
      :pending_transactions,
      partial: "fragments/pending_tx",
      locals: { transaction: self },
      target: "pending_transactions_container",
    )
  end

  def broadcast_update
    if self.completed?
      broadcast_remove_to(
        :pending_transactions,
        target: "transaction_#{self.id}",
      )

      broadcast_append_to(
        :user_pets,
        partial: "pets/pet",
        locals: { pet: self.user.pets.last },
        target: "pets_user_#{self.user.id}",
      )
    end
  end
end
