// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hash {
    function createHash(string memory _key) external pure returns (bytes32){
        return keccak256(abi.encodePacked(_key));
    }
}