pragma solidity ^0.4.24;

contract Counter {
    uint counter;
    
    constructor() public {
        counter = 0;
    }
    
    function incrementCounter() public returns (bool) {
        counter++;
        return true;
    }
    
    function getCounter() public view returns (uint) {
        return counter;
    }
}
