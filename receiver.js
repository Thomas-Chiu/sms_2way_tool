const receiver = () => {
  // const bodyParser = require("body-parser");
  const express = require("express");
  const app = express();
  const port = 3000;
  const replyItem = {};
  const replyArr = [];
  const taxId = "13091876";

  // 處理 HTTP request
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));

  // 前端靜態資源
  app.use("/", express.static("public"));

  // 後端處理邏輯
  app.get("/receiver", (req, res) => {
    if (Object.keys(req.body).length === 0) {
      res.status(403).send({ success: false, message: "無權限" });
      return;
    }
    res.status(200).send({ success: true, message: "OK" });
    replyItem["BatchID"] = req.body.BatchID;
    replyItem["ReceiverMobile"] = decodeURIComponent(req.body.RM);
    replyItem["ReplyTime"] = req.body.RT;
    replyItem["Stauts"] = req.body.STATUS;
    replyItem["Content"] = decodeURIComponent(req.body.SM);
    replyItem["MsgRecordNo"] = req.body.MR;
    replyItem["UserAccount"] = req.body.USERID;
    replyArr.push(replyItem);
    // console.log(replyArr);
  });

  app.get("/replier/:taxId", (req, res) => {
    if (req.params.taxId !== taxId) {
      res.status(403).send({ success: false, message: "無權限" });
      return;
    }
    // 送出後從陣列移除
    res.status(200).send({ success: true, result: replyArr[0] });
    replyArr.shift();
    // console.log(replyArr);
  });

  app.listen(port, () => {
    console.log(`web 伺服器 localhost:${port}`);
    // console.log(encodeURIComponent("+886952260525"));
    // console.log(encodeURIComponent("$AS+VERSION=JAS208S_20210914"));
  });
};

module.exports = receiver;
