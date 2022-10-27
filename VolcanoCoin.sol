// SPDX-License-Identifier: None

pragma solidity 0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable{

    uint256 totalSupply = 10000;

    event Increase(
        uint256 indexed amount,
        string message
    );

    event Sent(
        uint256 amount,
        string message,
        address recipient
    );

    struct UserBalance{
        address user;
        uint256 balance;
    }

    struct Payment{
        address recipientAddress;
        uint256 transferAmount;
    }
    
    Payment[] userPayments;

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
        totalSupply = totalSupply + 1000;
        balances[owner()] = totalSupply;
        emit Increase(1000, "added to total supply");
    
    }

    function transfer(uint256 amount, address to) public payable {
        require (amount <= balances[msg.sender]);
        recordPayment(msg.sender, to, amount);
    }
    
    function getPayments(address user) public view returns (Payment[] memory){
        return payments[user];
    }

    function recordPayment(address sender, address receiver, uint256 amount) public payable {
        require (amount <= balances[sender]);
        balances[sender] = balances[sender] - amount;
        balances[receiver] += amount;
        
        userPayments.push(Payment({recipientAddress: receiver, transferAmount: amount}));
        
        payments[sender] = userPayments;

        emit Sent(amount, "sent to", sender);


    }
}
