
/*
   Oraclize computationç
   Currently working
*/


pragma solidity ^0.4.2;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract ComputationJson is usingOraclize {
    
    string public lastCallback;
    
    event newCallBackTest(string _result);
    
    function ComputationJson() {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS); 
        callingDocker();
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastCallback = result;
       newCallBackTest(lastCallback);
    }
    
    function  callingDocker() payable {

        oraclize_query("computation",["json(Qmb7E5ZyaQzhUcqNVTQKJjWQzVGTm6zWQ7FPQuJYMBjCA6).[http-status,response-time]"]);
    }
    
    
}
