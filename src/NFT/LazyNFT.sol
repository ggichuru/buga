// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/utils/cryptography/draft-EIP712.sol";

contract LazyNFT is ERC721, ERC721URIStorage, Ownable, EIP712 {
    string private constant SIGNING_DOMAIN = "Voucher-Domain";
    string private constant SIGNATURE_VERSION = "1";
    address public minter;

    constructor(address _minter)
        ERC721("LAZYNFT", "LNFT")
        EIP712(SIGNING_DOMAIN, SIGNATURE_VERSION)
    {
        minter = _minter;
    }

    // Struct for the NFTVoucher
    struct LazyNFTVoucher {
        uint256 tokenId;
        uint256 price;
        string uri;
        address buyer;
        bytes signature;
    }

    // Check if the voucher is valid and mint the NFT to user
    function recover(LazyNFTVoucher calldata voucher)
        public
        view
        returns (address signer)
    {
        bytes32 digest = _hashTypedDataV4(
            keccak256(
                abi.encode(
                    keccak256(
                        "LazyNFTVoucher(uint256 tokenId, uint256 price, string uri, address buyer)"
                    ),
                    voucher.tokenId,
                    voucher.price,
                    keccak256(bytes(voucher.uri)),
                    voucher.buyer
                )
            )
        );

        signer = ECDSA.recover(digest, voucher.signature);

        signer;
    }

    function safeMint(LazyNFTVoucher calldata voucher) public payable {
        require(minter == recover(voucher), "Wrong signature");
        require(msg.value >= voucher.price, "Not Enough amount sent");

        _safeMint(voucher.buyer, voucher.tokenId);
        _setTokenURI(voucher.tokenId, voucher.uri);
    }

    // these functions are overrides required by solidity
    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
