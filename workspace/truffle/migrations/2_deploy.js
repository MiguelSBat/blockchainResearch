var BasicToken = artifacts.require('./BasicToken.sol');
var OraclizeAPI = artifacts.require('./OraclizeAPI.sol');
var YoutubeViews = artifacts.require('./YoutubeViews.sol');

module.exports = function(deployer) {
  // deployer.deploy(BasicToken, 1e15);
  deployer.deploy(OraclizeAPI);
  deployer.deploy(YoutubeViews);
};
