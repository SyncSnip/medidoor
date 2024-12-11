const asyncHandler = require('express-async-handler');
const prisma = require('../utility/database_connect.js');

const addProductType = asyncHandler(async (req, res) => {
  try {
    const { name, description, typeCode } = req.body;
    console.log(req.body);

    const productType = await prisma.productType.findUnique({
      where: {
        name
      }
    });

    console.log(productType);

    if (productType) {
      return res.status(403).json({ status: 403, message: 'Product type already exists.' });
    }

    const newProdType = await prisma.productType.create({
      data: {
        name,
        description,
        typeCode,
      }
    });

    return res.status(201).json({ status: 201, message: "Successfully added", data: newProdType });
  } catch (err) {
    return res.status(500).json({ status: 500, message: "Internal server error" });
  }
})

module.exports = {
  addProductType
}