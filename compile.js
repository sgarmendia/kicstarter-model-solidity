const path = require("path")
const fs = require("fs")
const solc = require("solc")

const filePath = path.resolve(__dirname, "contracts", "kickstart.sol")
const source = fs.readFileSync(filePath, "utf-8")

module.exports = solc.compile(source, 1).contracts[":Kickstart"]