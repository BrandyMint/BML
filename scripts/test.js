var page = require('webpage').create();
page.open('http://3000.vkontraste.ru', function() {
  page.render('public/4.png');
  phantom.exit();
});
