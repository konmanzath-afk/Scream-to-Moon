// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ISMOONToken {
    function transfer(address to, uint256 tokens) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

/// @notice Educational BNB Smart Chain Testnet reward demo.
/// @dev Not safe for mainnet: score is supplied by the caller and is not validated.
contract ScreamToMoon {
    ISMOONToken public smoonToken;
    address public owner;

    uint256 public initialReward = 10 ether;
    uint256 public rewardPerPoint = 1 ether;
    uint256 public maxScore = 100;

    mapping(address => bool) public hasClaimedInitial;
    mapping(address => uint256) public totalClaimed;

    event InitialClaim(address indexed player, uint256 amount);
    event RewardClaim(address indexed player, uint256 score, uint256 amount);

    constructor(address _smoonToken) {
        require(_smoonToken != address(0), "Invalid token");
        smoonToken = ISMOONToken(_smoonToken);
        owner = msg.sender;
    }

    function claimInitial() external {
        require(!hasClaimedInitial[msg.sender], "Already claimed");
        hasClaimedInitial[msg.sender] = true;
        require(smoonToken.transfer(msg.sender, initialReward), "Transfer failed");
        emit InitialClaim(msg.sender, initialReward);
    }

    function claimReward(uint256 score) external {
        require(score > 0, "Score must be greater than 0");
        require(score <= maxScore, "Score too high");
        uint256 reward = score * rewardPerPoint;
        require(smoonToken.balanceOf(address(this)) >= reward, "Contract reward balance too low");
        require(smoonToken.transfer(msg.sender, reward), "Reward transfer failed");
        totalClaimed[msg.sender] += reward;
        emit RewardClaim(msg.sender, score, reward);
    }

    function contractBalance() external view returns (uint256) {
        return smoonToken.balanceOf(address(this));
    }
}
