import config from "./conf.js";

const { reactive, watch, onMounted } = Vue;
const App = {
  setup() {
    const replyData =
      "3\r\n\t+886908443977\tsend sms from vue3*3\t2021/09/10 14:52:20\n\t+886908443977\tsend sms from phone *2\t2021/09/10 14:56:35\n\t+886908443977\tsend sms from phone *3\t2021/09/10 14:56:35\n";
    // const cors = `http://${config.host}:${config.corsPort}/`;
    const cors = "https://cors-anywhere-thomas.herokuapp.com/";
    const url = "http://api.every8d.com/API21/HTTP";
    const myurl = `http://${config.host}:${config.webPort}/replier/${config.taxId}`;
    const sendModel = reactive({
      // SB: "", 簡訊主旨
      // ST: "", 簡訊預定發送時間 YYYYMMDDhhmnss
      UID: config.username,
      PWD: config.password,
      MSG: "",
      DEST: "0908443977",
      RES: { CREDIT: "", SENDED: "", COST: "", UNSEND: "", BATCH_ID: "" },
    });
    const replyModel = reactive({
      // PNO: "", 分頁 (一頁 10 筆資料)
      UID: sendModel.UID,
      PWD: sendModel.PWD,
      BID: "",
      RES: "",
    });
    const replierModel = reactive({
      RES: {
        BatchID: "",
        ReceiverMobile: "",
        ReplyTime: "",
        Stauts: "",
        Content: "",
        MsgRecordNo: "",
        UserAccount: "",
      },
    });

    // 1. 傳送簡訊
    const sendSms = () => {
      console.log(sendModel);
      let params = new URLSearchParams();
      params.append("UID", sendModel.UID);
      params.append("PWD", sendModel.PWD);
      params.append("MSG", sendModel.MSG);
      params.append("DEST", sendModel.DEST);
      console.log(params.toString());

      axios
        .post(cors + url + "/sendSMS.ashx", params)
        .then((res) => {
          // 回傳值
          let temp = [];
          temp = res.data.split(",");
          sendModel.RES.CREDIT = temp[0];
          sendModel.RES.SENDED = temp[1];
          sendModel.RES.COST = temp[2];
          sendModel.RES.UNSEND = temp[3];
          sendModel.RES.BATCH_ID = temp[4];
          console.log(sendModel.RES);
          // 清除參數
          params.delete("UID");
          params.delete("PWD");
          params.delete("MSG");
          params.delete("DEST");
        })
        .catch((err) => {
          console.log(err);
        });

      getReplier();
    };

    /*
    // 2. 發送狀態查詢
    const getReplyMessage = (BID) => {
      let params = new URLSearchParams();
      let sendReq = () => {
        setInterval(() => {
          axios
            .post(cors + url + "/getReplyMessage.ashx", params)
            .then((res) => {
              replyModel.RES = res.data;
              console.log(res.data);
            })
            .catch((err) => console.log(err));
        }, 3000);
      };
      let stopReq = () => {
        clearInterval(sendReq);
        console.log("STOP");
      };

      params.append("UID", replyModel.UID);
      params.append("PWD", replyModel.PWD);
      params.append("BID", BID);
      console.log(params.toString());
      sendReq();
      setTimeout(stopReq, 10000);
    };
    // 監控傳送後回覆資料
    watch(sendModel.RES, () => getReplyMessage(sendModel.RES.BATCH_ID));
    */

    // 3. 發送狀態主動通知
    const getReplier = () => {
      let sendReq = () => {
        setInterval(() => {
          axios
            .get(myurl)
            .then((res) => {
              if (res.data.result === undefined) return;
              replierModel.RES.BatchID = res.data.result.BatchID;
              replierModel.RES.Content = res.data.result.Content;
              replierModel.RES.MsgRecordNo = res.data.result.MsgRecordNo;
              replierModel.RES.ReceiverMobile = res.data.result.ReceiverMobile;
              replierModel.RES.ReplyTime = res.data.result.ReplyTime;
              replierModel.RES.Stauts = res.data.result.Stauts;
              replierModel.RES.UserAccount = res.data.result.UserAccount;
              console.log(replierModel.RES);
            })
            .catch((err) => {
              console.log(err);
            });
        }, 5000);
      };

      sendReq();
    };

    onMounted(() => {
      console.log(config);
    });

    return {
      sendModel,
      replyModel,
      replierModel,
      sendSms,
      // getReplyMessage,
      getReplier,
    };
  },
};

Vue.createApp(App).mount("#app");
