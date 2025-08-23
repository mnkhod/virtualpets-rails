class PetAvatarGenerationJob < ApplicationJob
  queue_as :default

  def perform(pet)
    image = RubyLLM.paint(pet.avatar_prompt, size: "1024x1024")

    filename = "#{pet.name}-#{Time.current.to_i}.png"
    image_io = StringIO.new(image.to_blob)

    pet.avatar.attach(
      io: image_io,
      filename: filename,
      content_type: image.mime_type || "image/png", # Use detected MIME type or default
    )
  end
end
