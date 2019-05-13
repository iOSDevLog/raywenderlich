var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
// Setup log4js
var log4js = require('log4js');
log4js.configure({
  appenders: {
    out: { type: 'stdout' }
  },
  categories: {
    default: { appenders: [ 'out'], level: 'debug' }
  }
});
var logger = log4js.getLogger();

// Import our main route file
var index = require('./routes/index');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'twig');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(log4js.connectLogger(logger, {level: log4js.levels.DEBUG}));

// Register handlers
app.use('/', index(logger));

// Wire in Bootstrap and JS
app.use('/stylesheets', express.static(__dirname + '/node_modules/bootstrap/dist/css')); // redirect bootstrap css
app.use('/javascripts', express.static(__dirname + '/node_modules/jquery/dist')); // redirect jquery
app.use('/javascripts', express.static(__dirname + '/node_modules/bootstrap/dist/js')); // redirect bootstrap
app.use('/javascripts', express.static(__dirname + '/node_modules/popper.js/dist/umd')); // redirect popper
app.use('/stylesheets', express.static(__dirname + '/node_modules/font-awesome/css')); // redirect font-awesome css
app.use('/fonts', express.static(__dirname + '/node_modules/font-awesome/fonts')); // redirect font-awesome fonts

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
