const receiver = () => {
  // const bodyParser = require("body-parser");
  const express = require("express");
  const app = express();
  const port = 3000;
  const reply = {};

  // 處理 HTTP request
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  // 前端靜態資源
  app.use("/", express.static("public"));
  // 後端處理邏輯
  app.get("/receiver", (req, res) => {
    res.status(200).send({ success: true });
    reply["BatchID"] = req.body.BatchID;
    reply["ReceiverMobile"] = decodeURIComponent(req.body.RM);
    reply["ReplyTime"] = req.body.RT;
    reply["Content"] = decodeURIComponent(req.body.SM);
    reply["MsgRecordNo"] = req.body.MR;
    reply["UserAccount"] = req.body.USERID;

    console.log(reply);
  });

  app.listen(port, () => {
    console.log(`web 伺服器開啟 port:${port}`);
    // console.log(encodeURIComponent("+886952260525"));
    // console.log(encodeURIComponent("$AS+VERSION=JAS208S_20210914"));
  });
};

module.exports = receiver;
