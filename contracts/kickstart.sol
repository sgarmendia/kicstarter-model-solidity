pragma solidity >=0.4.22 <0.6.0;

contract kickstarter {

    struct Request {
        string description;
        uint amount;
        address recipient;
        bool complete;
        uint approvalCount;
    }

    struct Approver {
        bool authorized;
    }

    address manager;
    uint minimumContribution;
    mapping(address => Approver) approvers;
    Request[] requests;

    constructor(uint8 _minimumContribution ) public {
        minimumContribution = _minimumContribution;
        manager = msg.sender;
    }

    function contribute() public payable{
        require(msg.value > minimumContribution, "not enough ether");

        Approver memory newApprover = Approver({
            authorized: true
        });
        
        approvers[msg.sender] = newApprover;
    }

    function createRequest(string memory _description, uint _amount, address _recipient) private {
        require(msg.sender == manager, "Not allowed to create proposal");

        Request memory newRequest = Request({
            description: _description,
            amount: _amount,
            complete: false,
            recipient: _recipient,
            approvalCount: 0
        });

        requests.push(newRequest);
    }

    function approveRequest(bool _isApproved) public returns (string memory _confirmation) {
        require(requests[requests.length - 1].complete == false, "Proposal vote is closed");

        if(_isApproved){
            requests[requests.length - 1].approvalCount++;
            _confirmation = "Succesful approved Vote";
        } else {
            _confirmation = "Succesful no approved Vote";
        }

        return _confirmation;
    }

    function finalizeRequest() private view{
        require(msg.sender == manager, "Not allowed");
        require(requests[requests.length - 1].complete == false, "Proposal vote is closed");

        requests[requests.length - 1].complete == true;
    }
}