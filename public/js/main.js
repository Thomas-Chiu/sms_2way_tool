import config from "./conf.js";

const { ref, reactive, watch, onMounted } = Vue;
const App = {
  setup() {
    const replyData =
      "3\r\n\t+886908443977\tsend sms from vue3*3\t2021/09/10 14:52:20\n\t+886908443977\tsend sms from phone *2\t2021/09/10 14:56:35\n\t+886908443977\tsend sms from phone *3\t2021/09/10 14:56:35\n";
    const cors = `http://${config.host}:${config.corsPort}/`;
    // const cors = "https://cors-anywhere-thomas.herokuapp.com/";
    const url = "http://api.every8d.com/API21/HTTP";
    const myurl = `http://${config.host}:${config.webPort}/replier/${config.taxId}`;
    const isShow = ref(false);
    const sendModel = reactive({
      // SB: "", 簡訊主旨
      // ST: "", 簡訊預定發送時間 YYYYMMDDhhmnss
      UID: config.username,
      PWD: config.password,
      MSG: "",
      DEST: "",
      RES: { CREDIT: "", SENDED: "", COST: "", UNSEND: "", BATCH_ID: "" },
    });

    const replyModel = reactive({
      // PNO: "", 分頁 (一頁 10 筆資料)
      UID: config.username,
      PWD: config.password,
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

    const toggleShow = () => {
      isShow.value = !isShow.value;
    };

    // 1. 傳送簡訊
    const sendSms = () => {
      let params = new URLSearchParams();
      params.append("UID", sendModel.UID);
      params.append("PWD", sendModel.PWD);
      params.append("MSG", sendModel.MSG);
      params.append("DEST", sendModel.DEST);
      console.log("sendModel:", sendModel);

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
          console.log("sendModelRespond:", sendModel.RES);
          // 清除參數
          params.delete("UID");
          params.delete("PWD");
          params.delete("MSG");
          params.delete("DEST");
          // 視窗提示
          if (sendModel.RES.CREDIT === "-24") {
            alert(`請輸入訊息內容`);
            return;
          }
          if (sendModel.RES.CREDIT === "-99") {
            alert(`主機端發生不明錯誤，請與廠商窗口聯繫`);
            return;
          }
          if (sendModel.RES.COST === "0") {
            alert("發送失敗，請確認手機門號是否正確");
            return;
          }

          alert(`
              剩餘點數：${sendModel.RES.CREDIT}
              發送通數：${sendModel.RES.SENDED}
              扣除點數：${sendModel.RES.COST}
              未發送數：${sendModel.RES.UNSEND}
              識別代碼：${sendModel.RES.BATCH_ID}
              `);
          getReplyMessage(sendModel.RES.BATCH_ID);
          getReplier();
        })
        .catch((err) => {
          console.log(err);
        });
    };

    // 2. 發送狀態查詢
    const getReplyMessage = (BID) => {
      let params = new URLSearchParams();
      replyModel.BID = BID;
      params.append("UID", replyModel.UID);
      params.append("PWD", replyModel.PWD);
      params.append("BID", replyModel.BID);
      console.log("replyModel:", replyModel);

      setInterval(() => {
        axios
          .post(cors + url + "/getReplyMessage.ashx", params)
          .then((res) => {
            if (res.data === 0) return;

            replyModel.RES = res.data;
            console.log("replyModelRespond:", replierModel.RES);
          })
          .catch((err) => console.log(err));
      }, 5000);
    };

    /* 監控傳送後回覆資料
    watch(sendModel.RES, () => getReplyMessage(sendModel.RES.BATCH_ID)); */

    // 3. 發送狀態主動通知
    const getReplier = () => {
      setInterval(() => {
        axios
          .get(cors + myurl)
          .then((res) => {
            if (res.data.result === undefined) return;
            // 0 成功送達電信端、100 成功送達手機、999 為回覆簡訊
            if (
              // res.data.result.Stauts === "0" ||
              // res.data.result.Stauts === "100" ||
              res.data.result.Stauts === "999"
            ) {
              replierModel.RES.BatchID = res.data.result.BatchID;
              replierModel.RES.Content = res.data.result.Content;
              replierModel.RES.MsgRecordNo = res.data.result.MsgRecordNo;
              replierModel.RES.ReceiverMobile = res.data.result.ReceiverMobile;
              replierModel.RES.ReplyTime = res.data.result.ReplyTime;
              replierModel.RES.Stauts = res.data.result.Stauts;
              replierModel.RES.UserAccount = res.data.result.UserAccount;
              console.log("replierModelRespond:", replierModel.RES);
            } else alert("電信端回覆異常，該訊息無法送達，請參考狀態代碼表");
          })
          .catch((err) => {
            console.log(err);
          });
      }, 5000);
    };

    onMounted(() => {
      // console.log(config);
    });

    return {
      isShow,
      sendModel,
      replyModel,
      replierModel,
      toggleShow,
      sendSms,
      getReplyMessage,
      getReplier,
    };
  },
};

Vue.createApp(App).mount("#app");
