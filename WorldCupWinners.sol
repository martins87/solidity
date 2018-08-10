pragma solidity ^0.4.24;

contract WorldCupWinners{
    
    struct team {
        string name;
        int titles;
    }
    
    team[] teams;
    int numberOfChampions;
    
    function addWorldCupWinner(string _team) public returns (bool) {
        require(bytes(_team).length > 0, "Invalid team name");
        bool newChampion = true;
        
        // team already won before
        for (uint i = 0; i < teams.length; i++) {
            if(stringsEqual(teams[i].name, _team)) {
                teams[i].titles++;
                newChampion = false;
            }
        }
        // new champion
        if (newChampion) {
            teams.push(team(_team, 1));
            numberOfChampions++;
        }
        return true;
    }
    
    function getTitles(uint i) public view returns (int) {
        require(i < teams.length, "Invalid index");
        return teams[i].titles;
    }
    
    function getNumberOfChampions() public view returns (int) {
        return numberOfChampions;
    }
    
    function getGreatestWinner() public view returns (string) {
        require(numberOfChampions > 0, "No champions yet");
        int titles = 0;
        uint p;
        for(uint i = 0; i < teams.length; i++) {
            if (teams[i].titles > titles) {
                titles = teams[i].titles;
                p = i;
            }
        }
        return teams[p].name;
    }
    
    function getTeam(uint i) public view returns (string) {
        require(i < teams.length, "Invalid index");
        return (teams[i].name);
    }
    
    function stringsEqual(string storage _a, string memory _b) internal pure returns(bool) {
        bytes storage a = bytes(_a);
        bytes memory b = bytes(_b);

        // Compare two strings using SHA3
        if (keccak256(a) != keccak256(b)) {
            return false;
        }
        return true;
    }
}
