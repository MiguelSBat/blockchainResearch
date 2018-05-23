const request = require("request");
const method = process.argv[2];//"POST"; //process.argv[2];
const url = process.argv[3];//"https://api.themoviedb.org/3/movie/299536/rating?api_key=1b54b3280ac14d0f9cc81034c60f5863&guest_session_id=d9f42358983fe2439dcde04284c8df48"; //process.argv[3];
const header = process.argv[4];//"{\"Content-Type\":\"application/json;charset=utf-8\"}"; //process.argv[4];
const params = process.argv[5];//"{\"body\": {\"value\":8.5},\"callBackURI\":\"none\"}";

var options = {
    uri: '',
    method: '',
    time: true
};
options.method =method;
options.uri=url;
if(header!='none'){
    options.headers=JSON.parse(header);
}
if(params!='none'){
  let parsed = JSON.parse(params);
  var body = JSON.stringify(parsed.body);

  if(body!=null){
    options.body=body;
  }

}
console.log(options);

request(options, callback);

function callback(error, response, body){
  let json = JSON.parse(body);

  console.log(`{\"http-status\": ${response.statusCode},\"response-time\": ${response.elapsedTime}}`);
   process.exit(0);
}
