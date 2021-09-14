/* eslint-disable quotes */
const receiver = () => {
  const express = require("express");
  const app = express();
  const port = 3000;

  // 前端靜態
  app.use("/", express.static("public"));
  // 後端接收
  app.get("/receiver", (req, res) => {
    console.log(req.query);
    res.sendStatus(200);
  });

  app.listen(port, () => {
    console.log(`web 伺服器開啟 port:${port}`);
  });
};

module.exports = receiver;
