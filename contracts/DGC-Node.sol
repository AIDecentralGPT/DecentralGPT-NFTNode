// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";


contract DGCNode is Initializable, ERC721Upgradeable, OwnableUpgradeable  {
    uint256 private _nextTokenId;
    uint256 private TOKEN_CAP;

    struct TokenIdRange {
        uint256 startTokenId;
        uint256 endTokenId;
        uint256 nextTokenId;
    }

    mapping(uint16 => TokenIdRange) public levelNumber2TokenIdRange;

    event mintedToken(address indexed to,uint256 startTokenId, uint256 endTokenId);


    function initialize(address initialOwner) initializer public {
        __ERC721_init("DGC-Node", "DGCN");
        __Ownable_init(initialOwner);
        TOKEN_CAP = 100_000;
        setLevel2TokenIdRange();
    }

    function setLevel2TokenIdRange() internal onlyOwner {
        levelNumber2TokenIdRange[1] = TokenIdRange(1, 40000, 1);
        levelNumber2TokenIdRange[2] = TokenIdRange(40001, 60000, 40001);
        levelNumber2TokenIdRange[3] = TokenIdRange(60001, 73300, 60001);
        levelNumber2TokenIdRange[4] = TokenIdRange(73301, 82420, 73301);
        levelNumber2TokenIdRange[5] = TokenIdRange(82421, 88820, 82421);
        levelNumber2TokenIdRange[6] = TokenIdRange(88821, 93320, 88821);
        levelNumber2TokenIdRange[7] = TokenIdRange(93321, 96320, 93321);
        levelNumber2TokenIdRange[8] = TokenIdRange(96321, 98320, 96321);
        levelNumber2TokenIdRange[9] = TokenIdRange(98321, 100000, 98321);
    }


    function safeBatchMint(address to, uint16 level, uint256 amount) public onlyOwner{
        require(level<=10 && level>=1, "Level should be between 1 and 10");
        TokenIdRange memory levelTokenIdRange = levelNumber2TokenIdRange[level];
        require(levelTokenIdRange.nextTokenId-1 + amount <= levelTokenIdRange.endTokenId, "Token range not available");

        uint256 startTokenId = levelTokenIdRange.nextTokenId;
        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = levelTokenIdRange.nextTokenId++;
            _safeMint(to, tokenId);
        }
        levelNumber2TokenIdRange[level] = levelTokenIdRange;
        uint256 endTokenId = levelTokenIdRange.nextTokenId-1;
        emit mintedToken(to, startTokenId, endTokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://raw.githubusercontent.com/AIDecentralGPT/DecentralGPT-NFTNode/master/resource/DGC-node-metadata/";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        uint16 levelNumber = 1;
        for (uint16 level = 1; level  <= 9; level++){
            TokenIdRange memory levelTokenIdRange = levelNumber2TokenIdRange[level];
            if (levelTokenIdRange.startTokenId <= tokenId && tokenId <= levelTokenIdRange.endTokenId) {
                levelNumber = level;
                break;
            }
        }

        return string(abi.encodePacked(_baseURI(), Strings.toString(levelNumber), ".json"));
    }

    function tier(uint256 tokenId) public pure returns (uint16) {
        if (tokenId >=1 && tokenId <= 40000) {
            return 1;
        } else if (tokenId >= 40001 && tokenId <= 60000) {
            return 2;
        } else if (tokenId >= 60001 && tokenId <= 73300) {
            return 3;
        } else if (tokenId >= 73301 && tokenId <= 82420) {
            return 4;
        } else if (tokenId >= 82421 && tokenId <= 88820) {
            return 5;
        } else if (tokenId >= 88821 && tokenId <= 93320) {
            return 6;
        } else if (tokenId >= 93321 && tokenId <= 96320) {
            return 7;
        } else if (tokenId >= 96321 && tokenId <= 98320) {
            return 8;
        } else if (tokenId >= 98321 && tokenId <= 100000) {
            return 9;
        }
        return 0;
    }

    function version() public pure returns (uint256) {
        return 0;
    }
}