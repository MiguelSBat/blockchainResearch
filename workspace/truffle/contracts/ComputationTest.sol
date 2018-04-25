
/*
   Oraclize computation test
*/


pragma solidity ^0.4.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract ComputationTest is usingOraclize {
    
    string public lastCallback;
    
    event newCallBackTest(string _result);
    
    function ComputationTest() {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS); 
        callingDocker();
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastCallback = result;
       newCallBackTest(lastCallback);
    }
    
    function  callingDocker() payable {

        oraclize_query("computation",["QmY151gwvzewRY7G7taWH1PpCbFPJxxUXM9ZVoMXb12rQr"]);
    }
    
    
}
