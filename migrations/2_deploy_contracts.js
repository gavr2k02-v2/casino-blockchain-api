const Contacts = artifacts.require('./Casino.sol');

module.exports = function (deployer, network, [account]) {
  deployer.deploy(Contacts, account);
};
