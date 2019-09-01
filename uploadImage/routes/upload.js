var express = require('express');
var router = express.Router()
var upload = require('../config/multer');

router.post('/upload', upload.single('imageData'), (req, res, next) => {
    console.log(req.file);
    const statusJson = {
        status : 200,
        data : req.file.location
    }
    res.status(200).send(statusJson);
});


module.exports = router;
