import config from "./config.js";

const { ref, reactive } = Vue;
const App = {
  setup() {
    // const cors = "https://cors-anywhere.herokuapp.com/";
    const cors = "http://localhost:8080/";
    const url1 = "http://api.every8d.com/API21/HTTP/sendSMS.ashx";
    const url2 = "https://oms.every8d.com/API21/HTTP/sendSMS.ashx";
    const model = reactive({
      UID: config.username,
      PWD: config.password,
      // 簡訊主旨
      // SB: "",
      MSG: "",
      DEST: "0908443977",
      // 簡訊預定發送時間 YYYYMMDDhhmnss
      // ST: ""
    });

    // method
    const sendSms = () => {
      console.log(model);
      const params = new URLSearchParams();
      params.append("UID", model.UID);
      params.append("PWD", model.PWD);
      params.append("MSG", model.MSG);
      params.append("DEST", model.DEST);
      console.log(params.toString());

      axios
        .post(cors + url2, params)
        .then((res) => {
          console.log(res);
          params.delete("UID");
          params.delete("PWD");
          params.delete("SB");
          params.delete("MSG");
          console.log(params.toString());
        })
        .catch((err) => {
          console.log(err);
        });
    };

    return { model, sendSms };
  },
};

Vue.createApp(App).mount("#app");
