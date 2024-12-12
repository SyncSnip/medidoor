const router = require('express').Router();
const {
  getAllProducts,
  addProduct,
  getAllProductsByUserId,
  getProductById,
  submitReview,
} = require("../controller/productController.js");

router.get('/all-products', getAllProducts);
router.get('/all-products/:userId', getAllProductsByUserId);
router.get('/product/:prodId', getProductById);

router.post('/add-product', addProduct);
router.post('/review', submitReview);

module.exports = router;