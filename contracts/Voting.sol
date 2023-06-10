pragma solidity >=0.7.3;

contract Voting {
    struct Candidate {
        string name;
        address addr;
        uint256 votesReceived;
    }

    mapping(address => bool) public userVoted;
    Candidate[] public candidates;

    function registerCandidate(string calldata name, address addr) public {
        Candidate memory candidate = Candidate(name, addr, 0);
        candidates.push(candidate);
    }

    function removeCandidate(address addr) public {
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].addr == addr) {

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
            revert("User already voted");
        }
        userVoted[from] = true;

        Candidate storage candidate = getCandidate(addr);
        candidate.votesReceived++;
    }

    function getWinner() public view returns (Candidate memory) {
        if (candidates.length == 0) {
            revert("No candidates registered");
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
        revert("Candidate not found");
    }
}