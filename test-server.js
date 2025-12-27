const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World - Server Working');
});

const PORT = 3333;
app.listen(PORT, () => {
  console.log('Server started on port ' + PORT);
});