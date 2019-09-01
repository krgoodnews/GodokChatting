"use strict";
const AWS = require("aws-sdk");
AWS.config.update({ region: "ap-northeast-2" });
const s3 = new AWS.S3({ apiVersion: "2006-03-01" });

class S3Controller {
  constructor() {
    this.params = {
      Bucket: process.env.BUCKET_NAME,
      Marker: "",
      Prefix: ""
    };
  }

  getAllObjects(key) {
    this.params.Prefix = key;
    return new Promise(resolve => {
      s3.listObjects(this.params, (err, data) => {
        if (err) console.log(err);
        else {
          const list = [];
          data.Contents.forEach(item => {
            list.push(process.env.URL + item.Key);
          });
          resolve(list);
        }
      });
    });
  }
}

module.exports = S3Controller;
