// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract MacDonald is IERC20{
    string public constant name = "MacDonaldToken";
    string public constant symbol = "MDERC";
    uint8 public constant decimals = 18;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    uint256 _totalSupply = 10 ether;

    constructor() {
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public view override  returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function approve(address delegate, uint256 amount) public override returns (bool){
        require(amount > 0, "Amount token should be positive");
        allowed[msg.sender][delegate] = amount;
        emit Approval(msg.sender, delegate, amount);
        return true;
    }

    function allowance(address delegate) public view override returns (uint256) {
        return allowed[msg.sender][delegate];
    }

    function transfer(address receiver, uint256 amount) public override  returns (bool) {
        require(amount > 0, "Amount token should be positive");
        require(balances[msg.sender] >= amount, "Balance of the sender is not enough");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function transferFrom(address owner, address receiver, uint256 amount) public override returns (bool) {
        require(amount > 0, "Amount token should be positive");
        require(balances[owner] >= amount, "Balance of the owner is not enough");
        require(allowed[owner][msg.sender] >= amount, "Allowance which sender can withdraw from owner is not enough");

        balances[owner] -= amount;
        balances[receiver] += amount;
        allowed[owner][msg.sender] -= amount;
        emit Transfer(owner, receiver, amount);
        return true;
    }
}
