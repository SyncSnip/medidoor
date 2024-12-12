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

const addProduct = asyncHandler(async (req, res) => {
  try {
    let {
      name,
      price,
      description,
      userId,
      quantity,
      prodTypeId
    } = req.body;

    // Basic validation
    if (!name || !price || !userId || !quantity || !prodTypeId) {
      return res.status(400).json({
        status: 400,
        message: "All fields are required: name, price, userId, quantity, prodTypeId"
      });
    }

    // Data type conversion & validation
    try {
      userId = parseInt(userId);
      prodTypeId = parseInt(prodTypeId);
      price = parseFloat(price);

      if (isNaN(userId) || isNaN(prodTypeId) || isNaN(price)) {
        throw new Error("Invalid numeric values");
      }
    } catch (error) {
      return res.status(400).json({
        status: 400,
        message: "Invalid data types provided"
      });
    }

    // Check if productType exists
    const existingProductType = await prisma.productType.findUnique({
      where: { prodTypeId }
    });

    if (!existingProductType) {
      return res.status(404).json({
        status: 404,
        message: `ProductType with ID ${prodTypeId} not found`
      });
    }

    // Create the product with raw values
    const product = await prisma.product.create({
      data: {
        name,
        price,
        description: description || "",
        userId,
        quantity: quantity.toString(),
        prodTypeId
      }
    });

    return res.status(201).json({
      status: 201,
      message: "Product successfully added",
      data: product
    });

  } catch (err) {
    console.error("Full error object:", err);

    // Specific error handling
    if (err.code === 'P2002') {
      return res.status(400).json({
        status: 400,
        message: "Unique constraint violation"
      });
    }

    if (err.code === 'P2003') {
      return res.status(400).json({
        status: 400,
        message: "Foreign key constraint violation"
      });
    }

    return res.status(500).json({
      status: 500,
      message: "Internal server error",
      error: err.message
    });
  }
});

const getProductById = asyncHandler(async (req, res) => {
  try {
    const { prodId } = req.params;

    // Product fetch with reviews
    const product = await prisma.product.findUnique({
      where: {
        prodId: parseInt(prodId)
      },
      include: {
        prodType: {
          include: {
            reviews: true
          }
        },
      }
    });

    if (!product) {
      return res.status(404).json({
        status: 404,
        message: "Product not found"
      });
    }

    // Calculate average rating if reviews exist
    // const averageRating = product.reviews.length() > 0
    //   ? product.reviews.reduce((acc, review) => acc + review.rating, 0) / product.reviews.length
    //   : 0;

    // Format final response
    // const formattedProduct = {
    //   ...product,
    //   averageRating: parseFloat(averageRating.toFixed(1)),
    //   totalReviews: product.reviews.length
    // };

    return res.status(200).json({
      status: 200,
      message: "Product found successfully",
      data: product
    });
  } catch (err) {
    console.error("Full error object:", err);

    return res.status(500).json({
      status: 500,
      message: "Internal server error",
      error: err.message
    });
  }
});

const getAllProductsByUserId = asyncHandler(async (req, res) => {
  try {
    const { userId } = req.params;
    const products = await prisma.product.findMany({ where: { userId: parseInt(userId) } });

    if (!products.length) {
      return res.status(404).json({
        status: 404,
        message: "No products found for this user"
      });
    }

    return res.status(200).json({
      status: 200,
      message: "Products fetched successfully",
      data: products
    });
  } catch (err) {
    console.error("Full error object:", err);

    if (err.code === 'P2002') {
      return res.status(400).json({
        status: 400,
        message: "Unique constraint violation"
      });
    }

    if (err.code === 'P2003') {
      return res.status(400).json({
        status: 400,
        message: "Foreign key constraint violation"
      });
    }

    return res.status(500).json({
      status: 500,
      message: "Internal server error",
      error: err.message
    });
  }
});

const submitReview = asyncHandler(async (req, res) => {
  try {
    const { prodId, rating, comment, userId, prodTypeId } = req.body;

    console.log(req.body);

    // Basic validation 
    if (!prodId || !rating || !userId || !prodTypeId) {
      return res.status(400).json({
        status: 400,
        message: "Required fields missing: prodId, rating, userId, prodTypeId"
      });
    }

    // Data type validation
    const parsedRating = parseInt(rating);
    const parsedProdId = parseInt(prodId);
    const parsedUserId = parseInt(userId);
    const parsedProdTypeId = parseInt(prodTypeId);

    if (isNaN(parsedRating) || isNaN(parsedProdId) || isNaN(parsedUserId) || isNaN(parsedProdTypeId)) {
      return res.status(400).json({
        status: 400,
        message: "Invalid data types provided"
      });
    }

    const review = await prisma.review.create({
      data: {
        rating: parsedRating,
        comment,
        prodId: parsedProdId,
        userId: parsedUserId,
        prodTypeId: parsedProdTypeId
      }
    });

    return res.status(201).json({
      status: 201,
      message: "Review submitted successfully",
      data: review
    });

  } catch (err) {
    console.error("Review submission error:", err);

    if (err.code === 'P2002') {
      return res.status(400).json({
        status: 400,
        message: "Unique constraint violation"
      });
    }

    if (err.code === 'P2003') {
      return res.status(400).json({
        status: 400,
        message: "Foreign key constraint violation - Product or User may not exist"
      });
    }

    return res.status(500).json({
      status: 500,
      message: "Internal server error",
      error: err.message
    });
  }
});

module.exports = {
  getAllProducts,
  addProduct,
  getProductById,
  getAllProductsByUserId,
  submitReview
};