// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

using SafeMath for uint256;

contract DigiMonkzMinting is ERC721URIStorage, Ownable {
    address public contractOwner;
    uint256 totalMintedNum;
    uint256 mintLimit;

    mapping(address => uint256[]) totalUserNftList;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        contractOwner = msg.sender;
        mintLimit = 1000;
        totalMintedNum = 0;
    }

    function mintNft(uint256 _amount) external {
        require(totalMintedNum + _amount < mintLimit, "Not allowed amount");

        for (uint256 i = 0; i < _amount; i++) {
            totalMintedNum++;
            _mint(msg.sender, totalMintedNum);
            totalUserNftList[msg.sender].push(totalMintedNum);

            // string memory tokenUri = string(
            //     abi.encodePacked(
            //         "example.com/",
            //         totalMintedNum.toString(),
            //         ".json"
            //     )
            // );
            // _setTokenURI(newItemId, tokenUri);
        }
    }

    function userNftList() external view returns ( uint256[] memory) {
        uint256[] memory perUserNftList = totalUserNftList[msg.sender];
        return perUserNftList;
    }
}

// 0x18Ed8e3De1eae49438fe9bceE570982c98aB09e0
// 0x7F0eF5632d91A26cD7B67FB2b3aDCEdDFb5868D7
