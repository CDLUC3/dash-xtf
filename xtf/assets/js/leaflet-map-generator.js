var map;
var markerMap = {};


// Initialize the map using the given coordinates.
function initMap(lat,lng) {
  map = L.map('map');
  // If there aren't any coordinates, use Orange County.
  lat = lat || 33.6409;
  lng = lng || -117.77;
  map.setView([lat, lng], 10);

  // Create the tile layer with correct attribution.
  var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
  var osm = new L.TileLayer(osmUrl, {maxZoom: 16, attribution: osmAttrib, zIndex: 4});
  map.addLayer(osm);
};

// Extend Leaflet's Rectangle class to include a function which moves the 
// current rectangle below frontLayer.
L.Rectangle.prototype.bringBelow = function (frontLayer) {
  if (this._container && frontLayer._container) {
    var root = this._map._pathRoot;
    root.insertBefore(this._container, frontLayer._container);
  }
}