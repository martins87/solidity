pragma solidity ^0.4.24;

contract SimpleStorage {
    string public name;
    
    constructor() public {
        name = "João";
    }
    
    function set(string x) public {
        name = x;
    }
    
    function get() public view returns(string) {
        return name;
    }
}
