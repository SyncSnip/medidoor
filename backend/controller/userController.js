const asyncHandler = require('express-async-handler');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const prisma = require('../database_connect.js');

const createUser = asyncHandler(async (req, res) => {
  try {
    const { name, password, email } = req.body;

    const findUser = await prisma.user.findUnique({
      where: { email: email },
    });

    if (findUser) return res.json({ status: 400, message: "User  already exists" });

    const hashedPassword = await bcrypt.hash(password, Number(process.env.PASS_SALT));

    const newUser = await prisma.user.create({
      data: { name, password: hashedPassword, email },
    });

    const token = jwt.sign({ id: newUser.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    return res.status(201).json({ status: 201, message: "New User has been created successfully", token, data: newUser });
  } catch (err) {
    return res.json({ status: 500, data: "Internal server error", message: err.message });
  }
});


const signIn = asyncHandler(async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      return res.status(400).json({ status: 400, message: "Invalid email or password" });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return res.status(400).json({ status: 400, message: "Invalid email or password" });
    }

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    return res.status(200).json({ status: 200, message: "Sign in successful", token, data: user });
  } catch (err) {
    return res.json({ status: 500, data: "Internal server error", message: err.message });
  }
});

const getAllUsers = asyncHandler(async (req, res) => {
  try {
    const users = await prisma.user.findMany();
    if (users.length === 0) {
      return res.status(404).json({ status: 404, message: "No users found" });
    }
    return res.status(200).json({ status: 200, data: users });
  } catch (err) {
    return res.json({ status: 500, data: "Internal server error", message: err.message });
  }
});

const updateUser = asyncHandler(async (req, res) => {
  try {
    const { id } = req.params;
    const { name, password, email } = req.body;

    const dataToUpdate = { name, email };

    if (password) {
      const hashedPassword = await bcrypt.hash(password, Number(process.env.PASS_SALT));
      dataToUpdate.password = hashedPassword;
    }

    const updatedUser = await prisma.user.update({
      where: { id: Number(id) },
      data: dataToUpdate,
    });

    return res.status(200).json({ status: 200, message: "User  has been updated successfully", data: updatedUser });
  } catch (err) {
    return res.json({ status: 500, data: "Internal server error", message: err.message });
  }
});

const deleteUser = asyncHandler(async (req, res) => {
  try {
    const { id } = req.params;

    await prisma.user.delete({
      where: { id: Number(id) },
    });

    return res.status(200).json({ status: 200, message: "User has been deleted successfully" });
  } catch (err) {
    return res.json({ status: 500, data: "Internal server error", message: err.message });
  }
});

module.exports = {
  getAllUsers,
  createUser,
  updateUser,
  deleteUser,
  signIn,
};