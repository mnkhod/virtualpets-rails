class PetsController < ApplicationController
  def index
    @pets = Current.user.pets
  end

  def new
    @pet = Current.user.pets.build
  end

  def create
    @pet = Current.user.pets.build pet_params

    if @pet.save
      redirect_to action: :index, notice: "Created Pets"
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
end
