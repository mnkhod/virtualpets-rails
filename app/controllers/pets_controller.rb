class PetsController < ApplicationController
  def index
    @pets = Current.user.pets.completed.order("created_at DESC")
    @pending_amount = Current.user.pets.pending.size
  end

  def new
    @pet = Current.user.pets.build
  end

  def create
    @pet = Current.user.pets.build pet_params

    if @pet.valid?
      @pet.save

      NftMintJob.perform_later Current.user, @pet, metamask_params[:address]
      InitialConversationJob.perform_later @pet
      PetAvatarGenerationJob.perform_later @pet

      redirect_to pets_path, notice: "Created Pets"
    else
      render :new, status: :unprocessable_content
    end
  end

  def show
  end

  def edit
  end

  def data
    @pet = Pet.find_by!(nft_id: params.expect(:nft_id).to_i)
    render format: :json, json: {
      name: @pet.name,
      animal: @pet.animal,
      age: @pet.age,
      level: @pet.level,
      hunger: @pet.hunger,
      image: @pet.avatar.attached? ? url_for(@pet.avatar) : "",
      personality: @pet.personality,
      phrase: @pet.phrase,
    }
  end

  private

  def pet_params
    params.expect(pet: [:name, :animal, :gender, :personality, :phrase])
  end

  def metamask_params
    params.expect(metamask: [:address])
  end
end
