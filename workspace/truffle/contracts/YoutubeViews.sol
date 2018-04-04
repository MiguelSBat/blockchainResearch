/*
   Youtube video views

   This contract keeps in storage a views counter
   for a given Youtube video.
*/


pragma solidity ^0.4.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract YoutubeViewsCallBack is usingOraclize {

    string public viewsCount;
    uint public callbackTime;

    event newOraclizeQuery(string description);
    event newYoutubeViewsCount(string views);

    function YoutubeViewsCallBack() {
        callbackTime=0;
        update();
    }

    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        viewsCount = result;
        newYoutubeViewsCount(viewsCount);
        callbackTime=block.timestamp-callbackTime;
        // do something with viewsCount. like tipping the author if viewsCount > X?
    }

    function update() payable {
        callbackTime = block.timestamp;
        newOraclizeQuery("Oraclize query was sent, standing by for the answer..");
        oraclize_query('URL', 'html(https://www.youtube.com/watch?v=9bZkp7q19f0).xpath(//*[contains(@class, "watch-view-count")]/text())');
    }

}
