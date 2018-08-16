const MALE_COLOR = [0, 128, 255];
const FEMALE_COLOR = [255, 0, 128];

new deck.DeckGL({
  mapboxApiAccessToken: '',
  mapStyle: 'https://free.tilehosting.com/styles/positron/style.json?key=U0iNgiZKlYdwvgs9UPm1',
  longitude: 20,
  latitude: -33.5,
  zoom: 7,
  maxZoom: 16,
  layers: [
    new deck.ScatterplotLayer({
      id: 'scatter-plot',
      data: 'https://raw.githubusercontent.com/ThaboKopane/prototype/master/static/data/data.json',
      radiusScale: 10,
      radiusMinPixels: 2,
      getPosition: d => [d[0], d[1], 0],
      getColor: d => ([255*d[2],253*d[2],51*d[2]])
    })
  ]
});
