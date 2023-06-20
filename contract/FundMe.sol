//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 constant public MINIMUM_USD = 50 * 1e18;
    address public owner;
    AggregatorV3Interface private dataFeed;

    mapping(address => uint256) accountToMoney;

    constructor() {
        owner = msg.sender;
        dataFeed = AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
    }

    function fund() public payable {
        require(getConversionPrice(msg.value) >= MINIMUM_USD, "Didn't send enough");
        accountToMoney[msg.sender] += msg.value;
    }

    function getPrice() internal view returns(uint256) {
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();

        return uint256(answer * 1e10);
    }

    function getConversionPrice(uint256 ethAmount) internal view returns(uint256) {
        return getPrice() * ethAmount / 1e18; 
    }
}