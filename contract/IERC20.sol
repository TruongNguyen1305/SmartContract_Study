// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address delegate) external view returns (uint256);

    function transfer(address receiver, uint256 amount) external returns (bool);
    function transferFrom(address owner, address receiver, uint256 amount) external returns (bool);
    function approve(address delegate, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed delegate, uint256 amount);
}