// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";
// 831,975
// 812,030


error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // 21,415 gaz - constant
    // 23,515 gas - non-constant

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    
    address public immutable i_owner;
    // 21,508 gas - immutable
    // 23,644 gas - non-immutable
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough funds");
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough funds");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // require(owner == msg.sender, "Only owner can withdraw funds");
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset array
        funders = new address[](0);
        //withdraw fund

        // transfer => limit gas + throws error
        payable(msg.sender).transfer(address(this).balance);
        // send => limit gas + returns boolean
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");
        // call => forwards gaz
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner");
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _; // this defines the order when to execute the original function
    }

    // What happens if someone sends this contact ETH without calling the fund function

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

// unchecked {a+1} is gas efficient => use it when you are sure the math operation wil not pass the upper limit
    
}