const QBAC = artifacts.require('./QBAC.sol')

module.exports = (deployer, network, accounts) => {
  deployer.deploy(QBAC)
}
