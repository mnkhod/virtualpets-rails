class PetsController < ApplicationController
  def index
    @pets = Current.user.pets
  end

  def new
    @pet = Current.user.pets.build
  end

  def create
    @pet = Current.user.pets.build pet_params

    if @pet.valid?
      result = mint_tx metamask_params[:address]
      data = result.split(" ")[-1].split(",")
      nft_id = data[0]
      # hash = data[1]
      @pet.nft_id = nft_id

      @pet.save
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

  def mint_tx(address)
    timeout = 30
    result = Timeout.timeout(timeout) do
      `node #{Rails.root}/script/mint.js #{address} 2>&1`
    end

    raise "Node.js script failed: #{result}" if $?.exitstatus != 0
    result
  rescue Timeout::Error
    raise "Smart contract operation timed out"
  end
end
