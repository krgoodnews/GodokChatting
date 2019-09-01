"use strict";

const S3Controller = require("./S3Controller");
const DynamoDBController = require("./DynamoDBController");
const RekognitionController = require("./RekognitionController");
const rekognitionController = new RekognitionController();
const dynamoDBController = new DynamoDBController();
const s3Controller = new S3Controller();

exports.handler = async (event, context, callback) => {
  const filename = event.Records[0].s3.object.key;
  const splitFile = filename.split("/");
  let directory;

  if (splitFile.length === 1) {
    directory = "/";
  } else {
    splitFile.pop();
    directory = splitFile.join("/");
  }

  // 정보 구하기
  const result = await rekognitionController.getDetectObjects(filename);
  // 중복 확인
  const isDuplicate = await dynamoDBController.checkDuplicateImage(result, directory);

  if (isDuplicate) {
    await s3Controller.deleteItem(filename); // s3 삭제
  } else {
    await dynamoDBController.putItem(JSON.stringify(result), directory);
  }

  const response = isDuplicate;
  console.log(response);
  callback(null, response);
};
