class PetsController < ApplicationController
  def index
    @pets = Current.user.pets.completed
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

      redirect_to pets_path, notice: "Created Pets"
    else
      render :new, status: :unprocessable_content
    end
  end

  def show
  end

  def edit
  end

  private

  def pet_params
    params.expect(pet: [:name, :animal, :gender])
  end

  def metamask_params
    params.expect(metamask: [:address])
  end
end
