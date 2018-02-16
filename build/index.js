'use strict';

require('./template.html');

var Elm = require('../elm-app/Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);

document.addEventListener("keyup", function(e) {
  app.ports.keyPressed.send(e.keyCode);
});
