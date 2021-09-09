<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Document</title>
  <link rel="stylesheet" href="./css/style.css">
</head>

<body>
  <div id="app">
    <div class="left">
      <h1>SMS 發送</h1>
      <div class="row">
        <div class="col">
          帳號：<input type="text" v-model="model.UID" disabled />
        </div>
        <div class="col">
          密碼：<input type="password" v-model="model.PWD" disabled />
        </div>
        <div class="col">
          門號： <input type="text" v-model="model.DEST" />
        </div>
        <div class="col">訊息內容：</div>
        <textarea v-model="model.MSG" cols="30" rows="10"></textarea>
      </div>
      <input type="button" value="送出" @click="sendSms" />
    </div>

    <div class="right">
      <h1>SMS 回覆</h1>
      <div class="row">
        <div class="col">
          帳號：<input type="text" v-model="model.UID" disabled />
        </div>
        <div class="col">
          密碼：<input type="password" v-model="model.PWD" disabled />
        </div>
        <div class="col">
          門號： <input type="text" v-model="model.DEST" />
        </div>
        <div class="col">訊息內容：</div>
        <textarea v-model="model.MSG" cols="30" rows="10"></textarea>
      </div>
      <input type="button" value="送出" @click="sendSms" />
    </div>
  </div>

  <script src="./js/vue.global.prod.js"></script>
  <script src="./js/axios.js"></script>
  <script src="./js/main.js" type="module"></script>
</body>

</html>