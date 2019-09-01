"use strict";

const S3Controller = require("./S3Controller");
const s3Controller = new S3Controller();

exports.handler = async (event, context, callback) => {
  const key = event.type;
  const result = await s3Controller.getAllObjects(key);

  const response = { "data": result };

  callback(null, response);
};
