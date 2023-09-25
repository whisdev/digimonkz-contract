// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

using SafeMath for uint256;

contract DigiMonkzStaking is ERC721URIStorage, Ownable {
    IERC721 firstCollection;
    IERC721 secondCollection;

    address public contractOwner;

    struct StakeInfo {
        uint16 NFTId;
        uint256 stakingAt;
        uint256 lastRewardAt;
        uint16 collectionId;
    }

    // Total User Infomation
    mapping(address => StakeInfo[]) totalStakeInfo;
    mapping(address => uint256) userRewardList;

    constructor(
        string memory _name,
        string memory _symbol,
        IERC721 _collectionAddress1,
        IERC721 _collectionAddress2
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        firstCollection = _collectionAddress1;
        secondCollection = _collectionAddress2;
    }

    function getRewards() public returns (uint256) {
        StakeInfo[] storage userStakeInfo = totalStakeInfo[msg.sender];
        // use didn't stake
        require(userStakeInfo.length > 0, "Not Empty Array Allowed");
        uint256 userNftNum = userStakeInfo.length;
        uint256 reward = 0;
        uint256 timer = 600;

        for (uint256 i = 0; i < userNftNum; i++) {
            if (userStakeInfo[i].NFTId < 100) {
                require(
                    block.timestamp > userStakeInfo[i].stakingAt,
                    "Invalid Info"
                );
                reward += block
                    .timestamp
                    .sub(userStakeInfo[i].lastRewardAt)
                    .div(timer);
                userStakeInfo[i].lastRewardAt = block.timestamp;
            } else if (
                100 <= userStakeInfo[i].NFTId && userStakeInfo[i].NFTId < 300
            ) {
                require(
                    block.timestamp > userStakeInfo[i].stakingAt,
                    "Invalid Info"
                );
                reward += block
                    .timestamp
                    .sub(userStakeInfo[i].lastRewardAt)
                    .div(timer)
                    .mul(2);
                userStakeInfo[i].lastRewardAt = block.timestamp;
            }
        }
        userRewardList[msg.sender] += reward;

        return reward;
    }

    function nftStaking(
        uint16[] memory _NFTIds1,
        uint16[] memory _NFTIds2
    ) external {
        StakeInfo[] storage userStakeInfo = totalStakeInfo[msg.sender];

        // staking into collection 1
        for (uint256 i = 0; i < _NFTIds1.length; i++) {
            StakeInfo memory stakeInfo;
            require(
                (firstCollection.ownerOf(_NFTIds1[i]) == msg.sender),
                "Not Owner"
            );

            firstCollection.transferFrom(
                msg.sender,
                address(this),
                _NFTIds1[i]
            );
            stakeInfo.NFTId = _NFTIds1[i];
            stakeInfo.stakingAt = block.timestamp;
            stakeInfo.lastRewardAt = block.timestamp;
            stakeInfo.collectionId = 1;
            userStakeInfo.push(stakeInfo);
        }

        // staing into collection 2
        for (uint256 i = 0; i < _NFTIds2.length; i++) {
            StakeInfo memory stakeInfo;
            require(
                (secondCollection.ownerOf(_NFTIds2[i]) == msg.sender),
                "Not Owner"
            );

            secondCollection.transferFrom(
                msg.sender,
                address(this),
                _NFTIds2[i]
            );
            stakeInfo.NFTId = _NFTIds2[i];
            stakeInfo.stakingAt = block.timestamp;
            stakeInfo.lastRewardAt = block.timestamp;
            stakeInfo.collectionId = 2;
            userStakeInfo.push(stakeInfo);
        }
    }
}
