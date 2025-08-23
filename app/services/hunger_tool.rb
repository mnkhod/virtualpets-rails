class HungerTool < RubyLLM::Tool
  description "When asked about hunger you must return how hungry this pet is from options (full,hungry,starving)"
  # param :hunger, desc: "Pet hunger"

  def initialize(pet)
    @pet = pet
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    puts "INITIALIZED"
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  end

  def execute
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    puts "HUNGER RAN"
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    @pet.hunger
  end
end
