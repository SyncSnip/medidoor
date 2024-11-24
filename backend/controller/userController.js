const asyncHandler = require('express-async-handler');
const prisma = require('../database_connect.js');

const createUser = asyncHandler(async (req, res) => {
  try {
    console.log(req.body);
    const {
      name,
      password,
      email,
    } = req.body;

    const findUser = await prisma.user.findUnique({
      where: {
        email: email
      }
    });

    if (findUser) return res.json({ status: 400, message: "user already exists" });

    const newUser = await prisma.user.create({
      data: {
        name,
        password,
        email,
      }
    });

    return res.send("there is no users in the database");
  } catch (err) {
    return res.json({
      status: 500,
      data: "Internal server error",
      message: err.message
    });
  }
});

const getAllUsers = asyncHandler(async (req, res) => {
  try {
    return res.send("there is no users in the database");
  } catch (err) {
    return res.json({
      status: 500,
      data: "Internal server error",
      message: err.message
    });
  }
});

module.exports = {
  getAllUsers,
  createUser,
}