var express = require('express');
var router = express.Router();
const app = express();

app.use(express.static(__dirname + '../public'));

// /* GET home page. */
 router.get('/', function(req, res) {
   res.render('index', { title: 'Express' });
 });

 module.exports = router;



// router.listen(process.env.PORT || 3000, function(){
//   console.log('all systems go')
// })
