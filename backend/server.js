require('dotenv').config({ path: './.env' });
const bodyParser = require("body-parser");
const PORT = process.env.PORT || 3000;
const express = require("express");
const userRoutes = require("./routes/userRoutes.js");
const app = express();

app.use(bodyParser.json());

app.use('/api/v1/user', userRoutes);

app.get('/', (req, res) => {
  res.send("Welcome to the User API!");
});

app.listen(PORT, () => {
  console.log(`Server is running on port http://localhost:${PORT}`);
});