const router = require('express').Router();
const {
  getAllProducts,
} = require("../controller/productController.js");

router.get('/all-products', getAllProducts);

module.exports = router;