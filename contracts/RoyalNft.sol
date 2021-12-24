// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;
import "@OpenZeppelin/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import "@OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "@OpenZeppelin/openzeppelin-contracts/contracts/utils/Strings.sol";

struct AllowanceType {
    uint8 tokenId;
    uint16 amount;
}

struct NftType {
    uint16 supply;
    uint16 mint;
}

contract RoyalNft is ERC1155, Ownable {
    uint8[] indexes;
    mapping(address => AllowanceType[]) public Allowance;
    mapping(uint8 => NftType) public Nfts;

    constructor() ERC1155("ipfs://QmZ3fCAwnjGuWkEHCQAam4DKWynJwq1aMGr2oBduWZiBxp/metadata/{id}.json") {
        indexes = [11,12,13,14,15,16,21,22,23,24,25,26,31,32,33,34,35,36,41,42,43,44,45,46,51];
        Nfts[11].supply = 1185;
        Nfts[11].mint = 0;
        
        Nfts[12].supply = 1170;
        Nfts[12].mint = 0;
        
        Nfts[13].supply = 1200;
        Nfts[13].mint = 0;

        Nfts[14].supply = 1185;
        Nfts[14].mint = 0;

        Nfts[15].supply = 1170;
        Nfts[15].mint = 0;

        Nfts[16].supply = 1168;
        Nfts[16].mint = 0;

        Nfts[21].supply = 405;
        Nfts[21].mint = 0;

        Nfts[22].supply = 416;
        Nfts[22].mint = 0;

        Nfts[23].supply = 400;
        Nfts[23].mint = 0;

        Nfts[24].supply = 405;
        Nfts[24].mint = 0;

        Nfts[25].supply = 405;
        Nfts[25].mint = 0;

        Nfts[26].supply = 416;
        Nfts[26].mint = 0;

        Nfts[31].supply = 75;
        Nfts[31].mint = 0;

        Nfts[32].supply = 80;
        Nfts[32].mint = 0;

        Nfts[33].supply = 75;
        Nfts[33].mint = 0;

        Nfts[34].supply = 75;
        Nfts[34].mint = 0;

        Nfts[35].supply = 75;
        Nfts[35].mint = 0;

        Nfts[36].supply = 80;
        Nfts[36].mint = 0;

        Nfts[41].supply = 2;
        Nfts[41].mint = 0;

        Nfts[42].supply = 1;
        Nfts[42].mint = 0;

        Nfts[43].supply = 3;
        Nfts[43].mint = 0;

        Nfts[44].supply = 1;
        Nfts[44].mint = 0;

        Nfts[45].supply = 1;
        Nfts[45].mint = 0;

        Nfts[46].supply = 2;
        Nfts[46].mint = 0;

        Nfts[51].supply = 5;
        Nfts[51].mint = 0;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function addAllowance(address account,uint8 tokenId, uint16 amount) public onlyOwner {
        require( Nfts[tokenId].supply != uint16(0x0), "Token does not exist!");
        require( (Nfts[tokenId].supply - Nfts[tokenId].mint)  >= amount, "There is no available supply!");
        require(amount > 0, "Allowance amount must be greater than zero!");

        AllowanceType memory newone;
        newone.tokenId = tokenId;
        newone.amount = amount;
        Allowance[account].push(newone);
    }

    function getAvailable() public view returns(uint8[] memory,NftType[] memory){
        NftType[] memory ret = new NftType[](indexes.length);
        uint8[] memory tokens = new uint8[](indexes.length);

        for (uint i=0; i < indexes.length; i++) {
            tokens[i] = indexes[i];
            ret[i] = Nfts[indexes[i]];
        }

        return (tokens,ret);
    }

    function getAllowed(address account) public view returns(AllowanceType[] memory){       
        return Allowance[account];
    }

    function mint() public {        
        require(Allowance[msg.sender].length > 0, "There is no any mintable collectible!");

        bool isElement = true;
        while(isElement) {
            if (Allowance[msg.sender].length < 1) {
                break;
            }

            AllowanceType memory current = Allowance[msg.sender][Allowance[msg.sender].length -1];
            _mint(msg.sender, current.tokenId, current.amount, "");
            Nfts[current.tokenId].mint += current.amount;
            Allowance[msg.sender].pop();
        }
    }
}