<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Document</title>
  <link rel="stylesheet" href="./css/bootstrap.css">
  <link rel="stylesheet" href="./css/style.css">
</head>

<body class="bg-dark text-light">
  <div id="app">
    <div class="container d-flex">
      <div class="left flex-column">
        <h1 class="col">SMS 發送</h1>
        <div class="col">
          帳號：<input type="text" v-model="sendModel.UID" disabled />
        </div>
        <div class="col">
          密碼：<input type="password" v-model="sendModel.PWD" disabled />
        </div>
        <div class="col">
          門號：<input type="text" v-model="sendModel.DEST" />
        </div>
        <div class="col">訊息內容：</div>
        <textarea class="col" v-model="sendModel.MSG" cols="30" rows="10"></textarea>
        <input class="btn btn-warning col" type="button" value="送出" @click="sendSms" />
      </div>

      <div class="right flex-column">
        <h1 class="col">SMS 回覆</h1>
        <div class="col">
          剩餘點數：<input type="text" v-model="sendModel.RES.CREDIT" disabled />
        </div>
        <div class="col">
          扣除點數：<input type="text" v-model="sendModel.RES.COST" disabled />
        </div>
        <div class="col">
          查詢序號：<input type="text" v-model="sendModel.RES.BATCH_ID" disabled />
        </div>
        <div class="col">回覆內容：</div>
        <textarea class="col" v-model="replyModel.RES" cols="30" rows="10"></textarea>
      </div>
    </div>

  </div>

  <script src="./js/vue.global.prod.js"></script>
  <script src="./js/axios.js"></script>
  <script src="./js/bootstrap.min.js"></script>
  <script src="./js/main.js" type="module"></script>
</body>

</html>