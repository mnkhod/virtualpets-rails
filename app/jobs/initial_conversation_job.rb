class InitialConversationJob < ApplicationJob
  queue_as :default

  def perform(pet)
    # llm = RubyLLM.chat
    llm = Chat.create model_id: "gpt-5-nano", pet: pet
    # hunger_tool = HungerTool.new(pet)

    llm.with_instructions pet.instruction
    # llm.with_tool(hunger_tool)
    # llm.with_tool(WeatherTool)
    llm.ask "How are you?"
  end
end
