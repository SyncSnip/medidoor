const asyncHandler = require('express-async-handler');
const prisma = require('../utility/database_connect.js');

const getAllProducts = asyncHandler(async (req, res) => {
  try {
    const products = await prisma.product.findMany();
    if (products.length === 0) {
      return res.status(404).json({ status: 404, message: "No products found" });
    }

    return res.status(200).json({ status: 200, data: products });
  } catch (err) {
    return res.status(500).json({ status: 500, data: "Internal server error", message: err.message });
  }
});

module.exports = {
  getAllProducts,
};