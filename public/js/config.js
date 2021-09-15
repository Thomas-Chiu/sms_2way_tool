const isDev = false;
const username = "0952260525";
const password = "Jasslin13091876";
const taxId = "13091876";
const host = "";
const corsPort = 4000;
const webPort = 3000;

isDev = false ? (host = "60.251.157.49") : (host = "localhost");

export default {
  username,
  password,
  taxId,
  host,
  corsPort,
  webPort,
};
