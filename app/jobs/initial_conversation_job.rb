class InitialConversationJob < ApplicationJob
  queue_as :default

  def perform(pet)
    # llm = RubyLLM.chat
    llm = Chat.create model_id: "gpt-5-nano", pet: pet

    llm.with_instructions pet.instruction
    llm.ask "How are you?"
  end
end
