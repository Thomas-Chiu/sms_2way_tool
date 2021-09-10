import config from "./config.js";

const { ref, reactive, watch } = Vue;
const App = {
  setup() {
    const replyData =
      "3\r\n\t+886908443977\tsend sms from vue3*3\t2021/09/10 14:52:20\n\t+886908443977\tsend sms from phone *2\t2021/09/10 14:56:35\n\t+886908443977\tsend sms from phone *3\t2021/09/10 14:56:35\n";
    const cors = "http://localhost:8080/";
    const url = "http://api.every8d.com/API21/HTTP";
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
    };

    const getReplyMessage = (BID) => {
      let params = new URLSearchParams();
      params.append("UID", replyModel.UID);
      params.append("PWD", replyModel.PWD);
      params.append("BID", BID);
      console.log(params.toString());

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

    // 監控 API 回覆
    watch(sendModel.RES, () => getReplyMessage(sendModel.RES.BATCH_ID));

    return { sendModel, replyModel, sendSms, getReplyMessage };
  },
};

Vue.createApp(App).mount("#app");
