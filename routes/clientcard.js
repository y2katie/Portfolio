var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.render('clientcard', { title: 'that clientcard tho' });
});

module.exports = router;
