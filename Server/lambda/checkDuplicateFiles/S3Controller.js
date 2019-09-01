"use strict";
const AWS = require("aws-sdk");
AWS.config.update({ region: "ap-northeast-2" });
const s3 = new AWS.S3({ apiVersion: "2006-03-01" });

class S3Controller {
  constructor() {
    this.params = {
      Bucket: process.env.BUCKET_NAME,
      Key: ""
    };
  }

  deleteItem(key) {
    this.params.Key = key;
    return new Promise(resolve => {
      s3.deleteObject(this.params, (err, data) => {
        if (err) console.log(err);
        else resolve();
      });
    });
  }
}

module.exports = S3Controller;
