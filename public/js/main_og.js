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
        .catch((err) => {
          // 中華電信 API 無 Access-Control-Allow-Origin 所以寫在 catch
          console.log(err);
          params.delete("account");
          params.delete("password");
          params.delete("to_addr");
          params.delete("msg");
          console.log(params.toString());
        });
    };

    return { model, sendSms };
  },
};

Vue.createApp(App).mount("#app");
