pragma solidity ^0.4.24;

contract Enum {
    enum actionChoices { GoUp, GoDown, GoRight, GoLeft }
    actionChoices choice;
    actionChoices constant defaultChoice = actionChoices.GoUp;
    
    function getChoice() public view returns (string) {
        if(choice == actionChoices.GoUp) {
            return "GoUp";
        }
        if(choice == actionChoices.GoDown) {
            return "GoDown";
        }
        if(choice == actionChoices.GoRight) {
            return "GoRight";
        }
        if(choice == actionChoices.GoLeft) {
            return "GoLeft";
        }
    }
    
    function setChoice(int newChoice) public {
        require(newChoice < 4, "Must be 0, 1, 2 or 3");
        require(newChoice >= 0, "Must be a positive number");
        if(newChoice == 0) {
            choice = actionChoices.GoUp;
        }
        if(newChoice == 1) {
            choice = actionChoices.GoDown;
        }
        if(newChoice == 2) {
            choice = actionChoices.GoRight;
        }
        if(newChoice == 3) {
            choice = actionChoices.GoLeft;
        }
    }
}
