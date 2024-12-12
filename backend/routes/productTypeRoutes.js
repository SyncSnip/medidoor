const router = require('express').Router();
const {
  addProductType
} = require('../controller/productTypeController.js');

router.post('/add-product-type', addProductType);

module.exports = router