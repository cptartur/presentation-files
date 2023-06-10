pragma solidity >=0.7.3;

contract Voting {
    struct Candidate {
        string name;
        address addr;
        uint256 votesReceived;
    }

    event UserVoted(address addr, address recipient);
    event CandidateRegistered(Candidate candidate);
    event CandidateRemoved(Candidate candidate);

    error CandidateNotFound(address addr);
    error UserAlreadyVoted(address voter);
    error NoCandidatesRegistered();

    mapping(address => bool) public userVoted;
    Candidate[] public candidates;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }


    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function registerCandidate(string calldata name, address addr) public onlyOwner {
        Candidate memory candidate = Candidate(name, addr, 0);
        candidates.push(candidate);
        emit CandidateRegistered(candidate);
    }

    function removeCandidate(address addr) public onlyOwner {
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].addr == addr) {
                emit CandidateRemoved(candidates[i]);

                candidates[i] = candidates[candidates.length - 1];
                candidates.pop();

                return;
            }
        }
    }


    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function vote(address addr) public {
        address from = msg.sender;
        if (didVote(from)) {
            revert UserAlreadyVoted(from);
        }
        userVoted[from] = true;

        Candidate storage candidate = getCandidate(addr);
        candidate.votesReceived++;
        emit UserVoted(from, addr);
    }

    function getWinner() public view returns (Candidate memory) {
        if (candidates.length == 0) {
            revert NoCandidatesRegistered();
        }

        Candidate memory winner = candidates[0];
        for (uint i = 1; i < candidates.length; i++) {
            if (candidates[i].votesReceived > winner.votesReceived) {
                winner = candidates[i];
            }
        }

        return winner;
    }

    function didVote(address addr) private view returns (bool) {
        return userVoted[addr];
    }

    function getCandidate(address addr) private view returns (Candidate storage) {
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].addr == addr) {
                return candidates[i];
            }
        }
        revert CandidateNotFound(addr);
    }
}