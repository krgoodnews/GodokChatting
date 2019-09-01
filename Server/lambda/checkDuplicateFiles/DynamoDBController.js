"use strict";
const AWS = require("aws-sdk");
AWS.config.update({ region: "ap-northeast-2" });
const dynamoDB = new AWS.DynamoDB({ apiVersion: "2012-08-10" });

class DynamoDBController {
  constructor() {
    this.table = process.env.DB_TABLE_NAME;
  }

  putItem(data, category) {
    console.log("putItem");
    return new Promise(resolve => {
      dynamoDB.putItem(
        {
          TableName: this.table,
          Item: {
            id: { S: new Date().getTime().toString() },
            category: { S: category },
            rekognition_data: { S: data }
          }
        },
        (err, data) => {
          if (err) console.log(err);
          else resolve(data);
        }
      );
    });
  }

  checkDuplicateImage(ImageInfo, category) {
    return new Promise(resolve => {
      const params = {
        TableName: process.env.DB_TABLE_NAME,
        FilterExpression: "category = :category",
        ExpressionAttributeValues: {
          ":category": { S: category }
        }
      };

      dynamoDB.scan(params, (err, data) => {
        if (err) {
          console.log(err);
        } else {
          const result = [];
          // 데이터 수집
          data.Items.forEach(element => {
            result.push(JSON.parse(element.rekognition_data.S));
          });

          // 중복 검사
          let isDuplicate = false;
          loop1: for (let i = 0; i < result.length; i++) {
            for (let label in ImageInfo) {
              if (Number(ImageInfo[label]) - Number(result[i][label]) <= Math.abs(0.001)) {
                continue;
              }

              if (ImageInfo[label] !== result[i][label]) {
                continue loop1;
              }
            }
            isDuplicate = true;
            break;
          }

          resolve(isDuplicate);
        }
      });
    });
  }
}

module.exports = DynamoDBController;
