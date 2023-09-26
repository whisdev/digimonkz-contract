// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

using SafeMath for uint256;

contract DigiMonkzMinting is ERC721URIStorage, Ownable {

    address public contractOwner;
    uint256 totalMintedNum;
    uint256 mintLimit;

    struct UserInfo {
        uint16[] nftList;
        uint256 createdAt;
        uint256 lastRewardAt;
        uint256 rewardAmount;
    }

    // Total User Infomation
    mapping(address => UserInfo) totalUserInfo;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        mintLimit = 1000;
        totalMintedNum = 0;
    }

    function mintNft( uint256 _amount ) external {
        require(
            totalMintedNum + _amount < mintLimit,
            "Not allowed amount"
        );

        for (uint256 i = 0; i < _amount; i++) {
            totalMintedNum ++;
            _mint(msg.sender ,totalMintedNum);
        }
    }
}

// 0x26431169DD66b6896927bD442E060683B5b74661
// 0x7446E2e63F270C8dc2e86ddbec2bda3846Ff6Fc3