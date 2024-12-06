const jwt = require('jsonwebtoken');
const asyncHandler = require('express-async-handler');
const prisma = require('../utility/database_connect.js');

const authMiddleware = asyncHandler(async (req, res, next) => {
  let token;
  if (req?.headers?.authorization?.startsWith("Bearer")) {
    token = req.headers.authorization.split(" ")[1];
    try {
      if (token) {
        console.log(token);
        const decoded = jwt.verify(String(token), process.env.JWT_SECRET);
        console.log(decoded);
        const { email, id } = decoded;

        const user = await prisma.user.findUnique({ where: { id } });
        req.user = user;
        console.log(`pass the token: ${user.email}`);
        next();
      }
    } catch (err) {
      return res.status(401).json({ status: "failure", message: "Invalid token", data: err });
    }
  } else {
    throw new Error("Authorized token is not provided");
  }
});

const isVerifiedUser = asyncHandler(async (req, res, next) => {
  const { email } = req.body;
  const existingUser = await prisma.user.findUnique({ where: { email } });

  if (!existingUser || !existingUser.isVerified) {
    return res.status(403).json({ status: 403, message: "You are not verified user" });
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