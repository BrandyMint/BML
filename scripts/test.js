var page = require('webpage').create();
page.open('http://test.3008.vkontraste.ru/?version_id=1', function() {
  page.render('public/4.png');
  phantom.exit();
});
