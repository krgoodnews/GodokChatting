"use strict";
const AWS = require("aws-sdk");
AWS.config.update({ region: "ap-northeast-2" });
const rekognition = new AWS.Rekognition({ apiVersion: "2016-06-27" });

class RekognitionController {
  constructor() {
    this.params = {
      Image: {
        S3Object: {
          Bucket: "process.env.BUCKET_NAME",
          Name: ""
        }
      },
      MaxLabels: 20,
      MinConfidence: 50
    };
  }

  getDetectObjects(filename) {
    this.setImageName(filename);
    return new Promise(resolve => {
      rekognition.detectLabels(this.params, (err, data) => {
        if (err) console.log(err, err.stack);
        else {
          const result = {};
          const jsonData = data.Labels;
          jsonData.forEach(element => (result[element.Name] = Number(element.Confidence).toFixed(4)));
          console.log(result);
          resolve(result);
        }
      });
    });
  }

  setImageName(name) {
    this.params.Image.S3Object.Name = name;
  }
}

module.exports = RekognitionController;
