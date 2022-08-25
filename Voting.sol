//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract BallotBox{



    struct Voter{
        address Voter;
        string Name;
        bytes32 FingerPrint;
    }

    struct winnerDetails{
        address _addr;
        uint  vote;
    }
    winnerDetails[] public winners;

    struct Candidate{
        address Candidate;
        string Name;
        uint count;
    }  

    mapping(address => Voter) votes;
    mapping(address => Candidate) candidates;
    mapping(address => bool) hasVote;

    function RegisterVoter(address _voter, string memory _Name, string memory _FingerPrint ) public returns(bytes32){
        Voter storage v = votes[_voter];
        v.Name = _Name;
        v.FingerPrint = keccak256(abi.encodePacked(_FingerPrint));
        return v.FingerPrint;

    }

    function RegisterCandidate(address _candidate, string memory _Name) public{
        Candidate storage c = candidates[_candidate];
        c.Name = _Name;

    }

    function Vote(address _vote, bytes32 _fingerprint, address _candidate) public{
        require(hasVote[_vote] == false, "you've voted");
        Voter storage v = votes[_vote];
        require(_fingerprint == v.FingerPrint);
        Candidate storage c = candidates[_candidate];
        c.count ++;
        hasVote[_vote]== true;
    }

    function getVote(address _candidate) external returns(uint) {
        Candidate storage c = candidates[_candidate];
        uint totalvote = c.count;
        winnerDetails memory res = winnerDetails(_candidate, totalvote);
        winners.push(res);

        return totalvote;

    }
    function getTotalVote() external returns(winnerDetails[] memory){
        return winners;

    }





}