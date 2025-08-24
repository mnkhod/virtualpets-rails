class ChatsController < ApplicationController
  before_action :set_pet, only: %i[ update show ]
  before_action :set_chat, only: %i[ update show ]

  def show
    @messages = @chat.messages
    @conversations_length = @messages.where(role: :user).size
  end

  def update
    @chat.ask chat_params[:question]

    redirect_to pet_chat_path(@pet, @chat), notice: "Created Message"
  end

  private

  def set_pet
    @pet = Pet.find(params.expect(:pet_id))
  end

  def set_chat
    @chat = Chat.find(params.expect(:id))
  end

  def chat_params
    params.expect(chat: [:question])
  end
end
