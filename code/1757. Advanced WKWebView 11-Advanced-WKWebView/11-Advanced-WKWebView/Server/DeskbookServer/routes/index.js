var express = require('express');
var router = express.Router();
var fs = require('fs');

/**
Declare our main routes, which other than the default, will be
instantiated from the .js files in /controllers.
Note we receive an instance of `logger` coming from the app to 
facilitate logging during startup and for less verbose code.
*/ 
module.exports = function(logger) {

  /* GET home page (just a redirect) */
  router.get('/', function(req, res, next) {
    res.redirect('/staff');
  });

  // Dynamically include routes for Controllers
  fs.readdirSync('./controllers').forEach(function (file) {
    if(file.substr(-3) == '.js') {
        route = require('../controllers/' + file);
        route.controller(router,logger);
    }
  });

  return router;
};
