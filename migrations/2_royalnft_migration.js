const RoyalNft = artifacts.require("RoyalNft");

module.exports = function(deployer) {
  deployer.deploy(RoyalNft);
};