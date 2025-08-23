class WeatherTool < RubyLLM::Tool
  description "Gets current weather for a location"
  param :city, desc: "City name"

  def execute(city:)
    "The weather in #{city} is sunny and 22°C."
  end
end
