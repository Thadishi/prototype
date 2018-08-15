const data = [
  { pickup: [17.99219,-32.973039], dropoff: [27.955786,-26.010472], tripStartTime: 5, tripEndTime: 0 }
]

const MALE_COLOR = [0, 128, 255];
const FEMALE_COLOR = [255, 0, 128];

//var tData = JSON.parse("data/highRisk.json")

/*var xmlhttp = new XMLHttpRequest();
xmlhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var myObj = JSON.parse(this.responseText);
        alert(myObj.name);
    }
};
xmlhttp.open("GET", "data/highRisk.json", true);
xmlhttp.send();*/ 

mapboxgl.accessToken = 'pk.eyJ1IjoiZXpla2llbGNoZW50bmlrIiwiYSI6ImNqOWZ3b2JpMTJxc2cyd3FtemJlZXUwczYifQ.2hnqN-NsAxJn_td8dWWA2w'

const INITIAL_VIEW_STATE = {
  latitude: 30.5,
  longitude: 23,
  zoom: 3
};

new DeckGL({
  container: document.getElementById("container"),
  // mapbox: false, /* disable map */
  longitude: 20,
  latitude: -33.5,
  zoom: 7,
  pitch: 10,
  layers: []
})