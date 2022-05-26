// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Casino {
  uint256 private constant PRICE = 100000000000000;
  uint256 private constant KEY = 123;

  struct PayData {
    address wallet;
    uint256 time;
    int256 coins;
  }

  mapping(string => PayData[]) private payDatas;

  function getPrice() public pure returns (uint256) {
    return PRICE;
  }

  function getAllByUid(string memory _uid) public view returns (PayData[] memory) {
    PayData[] memory result = new PayData[](payDatas[_uid].length);

    for (uint256 i = 0; i < payDatas[_uid].length; i++) {
      result[i] = payDatas[_uid][i];
    }

    return result;
  }

  function buyCoins(string memory _uid) public payable {
    payDatas[_uid].push(PayData(msg.sender, block.timestamp, int256(msg.value / PRICE)));
  }

  function withdrawCoins(uint256 _amount, uint256 _key) public payable {
    require(_key == KEY, 'Invalid key');
    payable(msg.sender).transfer(_amount * PRICE);
  }
}
