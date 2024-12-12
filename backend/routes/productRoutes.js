const router = require('express').Router();
const {
  getAllProducts,
  addProduct,
} = require("../controller/productController.js");

router.get('/all-products', getAllProducts);

router.post('/add-product', addProduct);

module.exports = router;