require('dotenv').config({ path: './.env' });
const bodyParser = require("body-parser");
const PORT = process.env.PORT || 3000;
const express = require("express");
const userRoutes = require("./routes/userRoutes.js");
const productRoutes = require("./routes/productRoutes.js");
const prodTypeRoutes = require("./routes/productTypeRoutes.js");
const app = express();

app.use(bodyParser.json());

if (process.env.NODE_ENV === "production") {
  console.log = () => { };
}

app.use('/api/v1/user', userRoutes);
app.use('/api/v1/product', productRoutes);
app.use('/api/v1/product-type', prodTypeRoutes);

app.get('/', (req, res) => {
  return res.send("Welcome to the User API!");
});

app.listen(PORT, () => {
  console.log(`Server is running on port http://localhost:${PORT}`);
});