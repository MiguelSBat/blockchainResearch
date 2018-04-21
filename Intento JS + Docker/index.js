const request = require("request");
const url =
  "https://maps.googleapis.com/maps/api/geocode/json?address=Florence";

var before = Date.now();

request.get(url, (error, response, body) => {
  let json = JSON.parse(body);
  var after = Date.now();
  var time = after - before;

  console.log(
    `Status: ${json.status} | Time: ${time}`
  );
});

