const jwt = require('jsonwebtoken');
const asyncHandler = require('express-async-handler');
const prisma = require('../utility/database_connect.js');

const authMiddleware = asyncHandler(async (req, res, next) => {
  let token;
  if (req?.headers?.authorization?.startsWith("Bearer")) {
    token = req.headers.authorization.split(" ")[1];
    try {
      if (token) {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const { email, id } = decoded;
        const user = await prisma.user.findUnique({ where: { id } });
        req.user = user;
        console.log(`pass the tokken: ${user.email}`);
        next();
      }
    } catch (err) {
      throw new Error("Authorized token expired, Please login again");
    }
  } else {
    throw new Error("Authorized token is not provided");
  }
});

const isVerifiedUser = asyncHandler(async (req, res, next) => {
  const { email } = req.body;
  const existingUser = await prisma.user.findUnique({ where: { email } });

  if (!existingUser || !existingUser.isVerified) {
    return res.json({ status: 403, message: "You are not verified user" });
  } else {
    next();
  }
});

const isAdmin = asyncHandler(async (req, res, next) => {
  const { email } = req.user;
  const adminUser = await User.findOne({ email });
  if (adminUser.role !== "admin") {
    throw new Error("You are not an admin");
  } else {
    next();
  }
});

module.exports = { authMiddleware, isAdmin, isVerifiedUser };