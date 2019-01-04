contract owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyowner(){
        if (msg.sender == owner) {
            _;
        }
    }
}

contract mortal is owned {
    function kill() public onlyowner {
        selfdestruct(owner);
    } 
}
