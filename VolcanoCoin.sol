/ SPDX-License-Identifier: None

pragma solidity 0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable{

    uint256 totalSupply = 10000;

    event Increase(
        uint256 indexed amount,
        string message
    );

    event Sent(
        address sender,
        uint256 amount,
        string message,
        address recipient
    );

    struct Payment{
        address sender;
        address recipientAddress;
        uint256 transferAmount;
    }

    mapping (address => uint256) balances;
    mapping (address => Payment[]) payments;

    constructor(){
        balances[owner()] = totalSupply;
    }

    function getBalance() public view returns (uint256){
        return balances[msg.sender];
    }

    function getTotalSupply() public view returns (uint256){
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        balances[owner()] = totalSupply;
        emit Increase(1000, "added to total supply");
    }

    function transfer(uint256 amount, address to) public payable {
        require (amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[to] += amount;
        
        recordPayment(msg.sender, to, amount);

        emit Sent(msg.sender, amount, "sent to", to);

    }

    function recordPayment(address sender, address recipient, uint256 amount) public payable {
        payments[sender].push(Payment({sender: sender, recipientAddress: recipient, transferAmount: amount})); 
    }

    function getPayments(address user) public view returns (Payment[] memory){
        return payments[user];
    }
    
}

