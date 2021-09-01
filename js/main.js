// const cors = "https://cors-anywhere.herokuapp.com/";
// const url = "https://api2.kotsms.com.tw/kotsmsapi-1.php";
// const params = new URLSearchParams();

// params.append("username", "josemich0511");
// params.append("password", "dppss89111");
// params.append("dstaddr", "0952260525");
// params.append("smbody", "簡訊王 1111@4:198 api 簡訊測試");

// axios
//   .post(url, params)
//   .then((res) => {
//     console.log(res);
//   })
//   .catch((err) => {
//     console.log(err);
//   });

// fetch(cors + url, {
//   method: "POST",
//   headers: {
//     "Content-Type": "application/x-www-form-urlencoded",
//   },
//   body: encodeURI(
//     JSON.stringify({
//       username: "josemich0511",
//       password: "dppss89111",
//       dstaddr: "0952260525",
//       smbody: "簡訊王 1111@4:198 api 簡訊測試",
//     })
//   ),
// })
//   .then((res) => {
//     console.log(res);
//   })
//   .catch((err) => {
//     console.log(res);
//   });

const { ref, reactive } = Vue;
const App = {
  setup() {
    const url = "https://imsp.emome.net:4443/imsp/sms/servlet/SubmitSM";
    // data
    const model = reactive({
      username: "14523",
      password: "14523Qaz",
      method: "POST",
      phone: null,
      message: "",
    });
    // method
    const sendSms = () => {
      console.log(model);
      const params = new URLSearchParams();
      params.append("account", model.username);
      params.append("password", model.password);
      params.append("to_addr", model.phone);
      params.append("msg", model.message);
      console.log(params.toString());

      axios
        .post(url, params)
        .then((res) => console.log(res))
        .catch((err) => console.log(err));

      params.delete("account");
      params.delete("password");
      params.delete("to_addr");
      params.delete("msg");
      console.log(params.toString());
    };

    return { model, sendSms };
  },
};

Vue.createApp(App).mount("#app");
