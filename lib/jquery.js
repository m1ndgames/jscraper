var page = require('webpage').create(),
    system = require('system'),
    address;
 
if (system.args.length === 1) {
    console.log('usage: jquery.js url');
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
      var jQueryVersion;
      jQueryVersion = page.evaluate(function () {
        return (typeof jQuery === 'function') ? jQuery.fn.jquery : undefined;
      });
      if (jQueryVersion) {
        console.log('jQuery', jQueryVersion);
      } else {
        console.log('no jQuery');
      }
      phantom.exit();
    }, 2000);
  }
});
