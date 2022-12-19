// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library ArrayUtils {
    // internal functions can be used in internal library functions because they will be part of the same code context

    /**
     * @notice internal functions can be used in internal lib fns because they will be part of the same code context
     * @param self is the array to map
     * @param f interanal function to call
     */
    function map(
        uint256[] memory self,
        function(uint256) pure returns (uint256) f
    ) internal pure returns (uint256[] memory r) {
        r = new uint256[](self.length);

        for (uint256 i = 0; i < self.length; i++) {
            r[i] = f(self[i]);
        }
    }

    function reduce(
        uint256[] memory self,
        function(uint256, uint256) pure returns (uint256) f
    ) internal pure returns (uint256 r) {
        r = self[0];

        for (uint256 i = 0; i < self.length; i++) {
            r = f(r, self[i]);
        }
    }

    function range(uint256 length) internal pure returns (uint256[] memory r) {
        r = new uint256[](length);

        for (uint256 i = 0; i < r.length; i++) {
            r[i] = i;
        }
    }
}
