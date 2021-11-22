const handleDate = () => {
  const date = new Date(+new Date() + 8 * 3600 * 1000);
  const dateTime = JSON.stringify(date).split('"')[1].split("T");
  let fileDate = dateTime.shift();
  return fileDate;
};

const handleTime = () => {
  const date = new Date(+new Date() + 8 * 3600 * 1000);
  const dateTime = JSON.stringify(date).split('"')[1].split("T");
  let fileTime = dateTime.pop().split(".").shift();
  return fileTime;
};

const receiver = () => {
  // const bodyParser = require("body-parser");
  const fs = require("fs");
  const express = require("express");
  const cors = require("cors");
  const app = express();
  const port = 3000;
  const replyItem = {};
  const replyArr = [];
  const taxId = "13091876";

  // 處理 HTTP request
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  app.use(
    cors({
      origin: false,
      allowedHeaders: ["Content-Type', 'Authorization"],
    })
  );

  // 前端靜態資源
  app.use("/", express.static("public"));

  // 接收雙向簡訊
  app.get("/receiver", (req, res) => {
    let writeData = `${handleTime()} ${JSON.stringify(req.query)} \n`;
    // console.log(handleDate());
    // console.log(handleTime());

    if (Object.keys(req.query).length === 0) {
      res.status(403).send({ success: false, message: "無權限" });
      return;
    }
    // 記錄接收 log
    fs.writeFile(
      `./log/${handleDate()}.txt`,
      writeData,
      { flag: "a+" },
      (err) => {
        console.log("系統回報");
        if (err) {
          fs.writeFile(
            `./err/${fileDate}_err.txt`,
            err + "\n",
            { flag: "a+" },
            () => {
              console.log("log 寫檔失敗");
              return;
            }
          );
        } else {
          console.log("log 寫檔成功");
        }
      }
    );

    res.status(200).send({ success: true, message: "OK" });
    replyItem["BatchID"] = req.query.BatchID;
    replyItem["ReceiverMobile"] = decodeURIComponent(req.query.RM);
    replyItem["ReplyTime"] = req.query.RT;
    replyItem["Stauts"] = req.query.STATUS;
    replyItem["Content"] = decodeURIComponent(req.query.SM);
    replyItem["MsgRecordNo"] = req.query.MR;
    replyItem["UserAccount"] = req.query.USERID;
    replyArr.push(replyItem);
  });

  // API 回覆前端
  app.get("/replier/:taxId", (req, res) => {
    if (req.params.taxId !== taxId) {
      res.status(403).send({ success: false, message: "無權限" });
      return;
    }
    if (replyArr.length === 0) {
      res.status(404).send({ success: true, message: "無回覆資料" });
      return;
    }
    // 送出後從陣列移除
    res.status(200).send({ success: true, result: replyArr[0] });
    replyArr.shift();
  });

  app.listen(port, () => {
    console.log(`web 伺服器 http://localhost:${port}`);
  });
};

module.exports = receiver;
