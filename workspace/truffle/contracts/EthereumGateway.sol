
/*
   Ethereum Gateway
   MiguelSBat
*/



pragma solidity ^0.4.2;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";


contract EthereumGateway is usingOraclize {

    uint public lastCallback;
    uint public maxTimeResponse;
    string public IPFSline;
    address private owner;
    mapping(uint => string) public SLAViolations;

    event newCallBackTest(string _result);
    event newIPFSHash(string value);
    event newMaxTimeResponse(uint value);
    event newSLAViolation(string _message,uint _responseTime, uint _timeStamp);

    //Common example: "json(QmbZf6aVYqhGCQmGGydkNxC9m9gmgR3jBep9J7VGA8t1Xf).response-time", 200
    //Second example: "json(QmaJc7XHX8Ckfg4qJMWCnMFRuLuXtwTzEjTVWCgMtMKQKW).response-time", 200
    //Hardcode post example: "json(Qmc33WDvJk4QoAxfyu1q68BHBP84NhyUMSEZwNXXPa3krz).response-time"
    function EthereumGateway(string _IPFSline,uint _maxTimeResponse) {
        oraclize_setProof(proofType_TLSNotary | proofStorage_IPFS);
        maxTimeResponse = _maxTimeResponse;
        owner = msg.sender;
        IPFSline = _IPFSline;

        request("GET","https://maps.googleapis.com/maps/api/geocode/json?address=Florence","none","none");
    }

    function setIPFSline(string _IPFSline){
        if (msg.sender != owner) throw;

        IPFSline = _IPFSline;
        newIPFSHash(_IPFSline);
    }

    function setMaxTimeResponse(string _maxTimeResponse){
        if (msg.sender != owner) throw;

        maxTimeResponse = parseInt(_maxTimeResponse);
        newMaxTimeResponse(maxTimeResponse);
    }

    function __callback(bytes32 myid, string _result, bytes proof) {
        if (msg.sender != oraclize_cbAddress()) throw;
        lastCallback = parseInt(_result);
        newCallBackTest(_result);
        if(lastCallback>maxTimeResponse){
            SLAViolations[block.number] = "Max time response exceeded!";
            newSLAViolation("Max time response exceeded!",lastCallback,now);
        }

    }
    /*
    "GET","https://maps.googleapis.com/maps/api/geocode/json?address=Florence","none","none"

    "POST", "https://api.themoviedb.org/3/movie/299536/rating?api_key=1b54b3280ac14d0f9cc81034c60f5863&guest_session_id=d9f42358983fe2439dcde04284c8df48","{\"Content-Type\":\"application/json;charset=utf-8\"}", "{\"body\": {\"value\":8.5},\"callBackURI\":\"none\"}"

    */
    function  request(string _method,string _url,string _header,string _params) payable {
        /*
        oraclize_query("computation",["json(Qmb7E5ZyaQzhUcqNVTQKJjWQzVGTm6zWQ7FPQuJYMBjCA6).[http-status,response-time]"]);
        This query return an array-like string, I dont know how to parse it.        EX: '[200, 429]'
        */

        oraclize_query("computation",[IPFSline,_method,_url,_header,_params]);
    }


}
