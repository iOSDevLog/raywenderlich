var fs = require('fs');

module.exports.controller = function(router,logger) {

  //Initialization Time!

  // My data is just a JSON file - we cache it in memory on server start!
  var staffList = [];
  // Load it with a try/catch in case the JSON has issues.
  try {
    staffList = JSON.parse(fs.readFileSync("./models/staff2.json"));
    // Sort the list by name
    staffList = staffList.sort(function(a, b) {  
      return (a["name"] > b["name"]) ? 1 : ((a["name"] < b["name"]) ? -1 : 0);
    });
  } catch(e) {
    logger.fatal('Could not read staff2.json: ' + e);
  }

  /**
  Staff Main API List
  */
  router.get('/api/staff2', function(req, res) {
    // Render with the staff list
    logger.debug('Returning JSON staff2 list with count: ' + staffList.length);
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify(staffList));
  });

  /**
  Staff Home Page (Staff List)
  */
  router.get('/staff2', function(req, res) {
    // Pull items from parameters and/or query string
    let wrapInClass = req.query['wrapInClass'];
    // Render with the staff list
    logger.debug('Rendering staff2 list with count: ' + staffList.length);
    res.render('staff2/index', { title: 'Deskbook Staff2 List', staffList: staffList, wrapInClass: wrapInClass });
  });

  /**
  Staff Member Page
  */
  router.get('/staff2/:id', function(req, res) {
    let lookingForId = req.params['id'];
    let wrapInClass = req.query['wrapInClass'];
    logger.debug('wrapInClass='+wrapInClass);
    // Filter our staffList for ID
    let staffMember = staffList.filter(function(instance,idx){
      return instance.id == lookingForId;
    });
    // TODO: Add logic for NOT FOUND

    // ASSERT: We have a match AND id is unique, so we have only 1
    logger.debug('Rendering Staff Member: ' + staffMember[0].name);
    res.render('staff2/individual', { title: staffMember[0].name, staffMember: staffMember[0], wrapInClass: wrapInClass });
  });
}