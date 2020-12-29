pragma solidity ^0.5.3;

contract LotteryWinner{
    address public contractOwner;
    
    address payable [] public players;
    
    address payable public winner;
    
    constructor() public{
        contractOwner = msg.sender;
    }
    
    modifier ownerOnly{
        if(contractOwner == msg.sender){
            _;
            
        }
    }
    
    function Deposit() public payable{
        require(msg.value >= 1 ether);
        players.push(msg.sender);
    }
    
    function RandomGenerator() private view returns(uint){
        return uint(keccak256(abi.encodePacked(now,block.difficulty,players.length)));
    }
    
    function PickWinner() ownerOnly public{
        uint random = RandomGenerator();
        uint index = random % players.length;
        
        winner = players[index];
        
        winner.transfer(address(this).balance);
        
        players =new address payable [] (0);
    }
    
    
}