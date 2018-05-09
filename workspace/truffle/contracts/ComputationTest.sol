
/*
   Oraclize computation
https://rinkeby.etherscan.io/address/0x5aed47556404592e5a29a816538e0957de9caeea
*/



pragma solidity ^0.4.2;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract ComputationJson is usingOraclize {
    
    uint public lastCallback;
    uint public maxTimeResponse;
    mapping(uint => string) public SLAViolations;
    
    event newCallBackTest(string _result, uint _blockNumber);
    event newSLAViolation(string _message,uint _responseTime, uint _timeStamp,uint _blockNumber);
    
    function ComputationJson() {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS); 
        maxTimeResponse = 200;
        callingDocker();
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastCallback = parseInt(result);
        newCallBackTest(result, block.number);
        if(lastCallback>maxTimeResponse){
            SLAViolations[block.number] = "Max time response exceeded!";
            newSLAViolation("Max time response exceeded!",lastCallback,now,block.number);
        }
        
    }
    
    function  callingDocker() payable {
        /*
        oraclize_query("computation",["json(Qmb7E5ZyaQzhUcqNVTQKJjWQzVGTm6zWQ7FPQuJYMBjCA6).[http-status,response-time]"]); 
        This query return an array-like string, I dont know how to parse it.        EX: '[200, 429]'
        */
        
        oraclize_query("computation",["json(Qmb7E5ZyaQzhUcqNVTQKJjWQzVGTm6zWQ7FPQuJYMBjCA6).response-time"]);
    }
    
    
}
