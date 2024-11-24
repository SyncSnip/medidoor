require("dotenv").config();
const PORT = 3000;
const express = require("express");
const userRoutes = require("./routes/userRoutes.js");
const app = express();

app.use('/api/v1/user', userRoutes);

app.get('/', (req, res) => {
  res.send("Welcome to the User API!");
});

app.listen(PORT, () => {
  console.log(`Server is running on port http://localhost:${PORT}`);
});