const username = "0952260525";
const password = "Jasslin13091876";
const taxId = "13091876";
const corsPort = 4000;
const webPort = 3000;
let isDev = false;
let host = "";

if (isDev === true) host = "localhost";
if (isDev === false) host = "60.251.157.49";

export default {
  username,
  password,
  taxId,
  host,
  corsPort,
  webPort,
};
