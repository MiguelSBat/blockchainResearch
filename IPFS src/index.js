const request = require("request");
const url =
  "https://maps.googleapis.com/maps/api/geocode/json?address=Florence";

request.get(url,{time:true}, (error, response, body) => {
  let json = JSON.parse(body);

  console.log(
    `Status: ${json.status} | Time: ${response.elapsedTime}`
  );
   process.exit(0);
  // With this line we can get more details about the request
 // console.log(request.timingPhases);
});
