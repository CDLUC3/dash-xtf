var map;
var ajaxRequest;
//var plotlist;
//var plotlayers=[];
var markerMap = {};
//var defaultMarker = new L.Icon.Default;
/*var highlightMarker = new L.Icon.Default({
  iconUrl: '/assets/marker-icon-highlight.png',
  iconRetinaUrl: '/assets/marker-icon-highlight-2x.png'
});*/


function initMap(lat,lng) {
  map = L.map('map');
  // Initialize the map using the given coordinates.
  // Otherwise, use Orange County.
  lat = lat || 33.6409;
  lng = lng || -117.77;
  map.setView([lat, lng], 10);

  // Create the tile layer with correct attribution.
  var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
  var osm = new L.TileLayer(osmUrl, {maxZoom: 16, attribution: osmAttrib, zIndex: 4});
  map.addLayer(osm);
}
