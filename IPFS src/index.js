const request = require("request");
const url =
  "https://maps.googleapis.com/maps/api/geocode/json?address=Florence";
var parsed = 0;

if(!isNaN(parseInt(process.argv[2]))) {
  parsed = parseInt(process.argv[2]);
}

request.get(url,{time:true}, (error, response, body) => {
  let json = JSON.parse(body);

  console.log(`{\"http-status\": ${response.statusCode},\"response-time\": ${response.elapsedTime+parsed}}`);
   process.exit(0);
  // With this line we can get more details about the request
 // console.log(request.timingPhases);
});
