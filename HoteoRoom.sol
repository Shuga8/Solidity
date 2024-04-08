// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom{

    // Ether Payments
    // Modifiers
    // Visibilities
    // Events
    // Enums

    enum Statuses{
        Vacant, 
        Occupied
    }

    event Occupy(address _occupant, uint _value);

    Statuses currentStatus;

    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently Occupied");
        _;
    }

    modifier onlySufficientEther(uint _ether) {
        require(msg.value >= _ether, "Insufficient ether provided");
        _;
    }

    function book() payable public onlyWhileVacant onlySufficientEther(2 ether){
        
        owner.transfer(msg.value);
        currentStatus = Statuses.Occupied;

        emit Occupy(msg.sender, msg.value);
    }

}
