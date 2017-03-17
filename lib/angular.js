var page = require('webpage').create(),
    system = require('system'),
    address;
 
if (system.args.length === 1) {
    console.log('usage: angular.js url');
    phantom.exit(1);
}
 
page.settings.loadImages = false;
address = system.args[1];
 
page.open(address, function (status) {
  if (status !== 'success') {
    console.log('ERROR: cant load ', address);
    phantom.exit();
  } else {
    setTimeout(function () {
      var angularVersion;
      angularVersion = page.evaluate(function () {
        return (typeof angular === 'function') ? angular.version.full : undefined;
      });
      if (angularVersion) {
        console.log('angular', angularVersion);
      } else {
        console.log('no angular');
      }
      phantom.exit();
    }, 2000);
  }
});
