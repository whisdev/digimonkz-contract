// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

using SafeMath for uint256;

contract DigiMonkzMinting is ERC721URIStorage, Ownable {
    IERC721 firstCollection;
    IERC721 secondCollection;

    address public contractOwner;

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
        string memory _symbol,
        IERC721 _collectionAddress1,
        IERC721 _collectionAddress2
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        firstCollection = _collectionAddress1;
        secondCollection = _collectionAddress2;
    }

    function mintNft( uint16[] memory _mintNFTIds) external {
        require(_mintNFTIds.length > 0, "Need to mint at least 1 NFT");
        uint256 userNFTMintNum = _mintNFTIds.length;
        for (uint256 i = 0; i < userNFTMintNum; i++) {
            uint16 temp = _mintNFTIds[i];
            require(
                (firstCollection.ownerOf(temp) == msg.sender || secondCollection.ownerOf(temp) == msg.sender), "Not Owner"
            );
            _mint(msg.sender, temp);
        }
    }
}
