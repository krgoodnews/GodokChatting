var express = require('express');
var router = express.Router();

router.use('/', require('./upload'));

module.exports = router;
