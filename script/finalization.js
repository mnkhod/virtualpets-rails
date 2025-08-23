const { ethers } = require("ethers")

main()

// node script/mint.js 0x8800B49924c830a71C0077FD8cBA97df46a64604
async function main() {
  const args = process.argv.slice(2) // remove 'node' and script name
  const hash = args[0]
  if (!hash) throw ("HASH ARGUMENT MISSING")

  let provider = new ethers.JsonRpcProvider("https://sepolia.shape.network")

  let interface = new ethers.Interface([
    "event Transfer(address indexed from, address indexed to, uint256 indexed tokenId)",
    "event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId)",
  ])

  let receipt = await provider.waitForTransaction(hash)
  let parsedLog = interface.parseLog(receipt.logs[0])
  let id = Number(parsedLog.args.tokenId)
  console.log(id)
}
