// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "forge-std/console.sol";
import "forge-std/Test.sol";

import "../src/NFT/LazyNFT.sol";

contract LazyNFTTest is Test {
    LazyNFT nft;

    address minter = vm.addr(0x1);
    address wallet2 = vm.addr(0x2);

    function setUp() public {
        nft = new LazyNFT(minter);
    }

    function testNameAndSymbol() public {
        assertEq(nft.name(), "LAZYNFT");
        assertEq(nft.symbol(), "LNFT");
    }
}
