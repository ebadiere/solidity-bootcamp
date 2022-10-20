// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {

    address burnAddress = 0x000000000000000000000000000000000000dEaD;
    address deployer;
    uint256 number;

    event caller(string);

    constructor() {
        deployer = msg.sender;
    }


    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }

    function retrieveBurnAddress() external returns (address){
        if(deployer == msg.sender){
            emit caller("burnAddress");
            return burnAddress;
        } else {
            emit caller("deployer");
            return deployer;
        }
    }
}
