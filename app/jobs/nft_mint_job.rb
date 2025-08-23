class NftMintJob < ApplicationJob
  queue_as :default

  def perform(user, pet, address)
    mint_result = mint_tx address
    # has bullshit dot/env log
    hash = mint_result.split(" ")[-1]

    tx = user.transactions.create tx: hash

    puts "HASH LOG==========================================="
    puts hash
    puts "=============================================="

    final_result = finalize_tx hash

    puts "TOKEN ID==========================================="
    puts final_result
    puts "=============================================="

    nft_id = final_result.to_i
    pet.update(nft_id: nft_id, status: :completed)

    Turbo::StreamsChannel.broadcast_update_to("pets", target: "pets_counter", html: "#{user.pets.completed.size}")
    Turbo::StreamsChannel.broadcast_update_to("pets", target: "pets_pending_counter", html: "#{user.pets.pending.size}")

    tx.completed!
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

  def finalize_tx(hash)
    timeout = 30
    result = Timeout.timeout(timeout) do
      `node #{Rails.root}/script/finalization.js #{hash} 2>&1`
    end

    raise "Node.js script failed: #{result}" if $?.exitstatus != 0
    result
  rescue Timeout::Error
    raise "Smart contract operation timed out"
  end
end
