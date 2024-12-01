const asyncHandler = require('express-async-handler');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const prisma = require('../utility/database_connect.js');
const sendEmail = require('../utility/send_mail.js');
const { verifyEmailBody, verifyEmailSubject } = require('../config/messageConfig.js');

const createUser = asyncHandler(async (req, res) => {
  try {
    const { name, password, email } = req.body;

    const findUser = await prisma.user.findUnique({
      where: { email },
    });

    console.log(findUser);

    if (findUser) return res.json({ status: 400, message: "User  already exists" });

    const hashedPassword = await bcrypt.hash(password, Number(process.env.PASS_SALT));

    // * generate otp
    const otp = Math.floor(100000 + Math.random() * 900000);

    await sendEmail(email, verifyEmailSubject(), verifyEmailBody(otp, name));
    console.log("mail sent");
    const newUser = await prisma.user.create({
      data: { name, password: hashedPassword, email, otp: String(otp), isVerified: false },
    });
    console.log("new id created");
    console.log(newUser);

    // Remove the password field from the response
    const { password: _, ...userWithoutPassword } = newUser;

    const token = jwt.sign(
      { id: newUser.id, email: newUser.email }, process.env.JWT_SECRET, { expiresIn: '1h' });
    console.log(`token: ${token}`);

    return res.status(201).json({
      status: 201,
      message: "New User has been created successfully",
      token,
      data: userWithoutPassword,
    });
  } catch (err) {
    throw new Error(err);
    return res.json({ status: 500, data: "Internal server error", message: err.message });
  } finally {
    console.log("finally block executed");
  }
});

const verifyUser = asyncHandler(async (req, res) => {
  try {
    const { otp } = req.body;
    const user = req.user;
    const { email, id } = req.user;

    console.log(`user: ${user.email} is here`);
    if (!user) {
      return res.status(404).json({ status: 404, message: "User not found" });
    }

    if (user.otp !== otp) {
      return res.status(403).json({ status: 400, message: "Invalid OTP" });
    }

    // console.log(new Date());
    // console.log(Date().toISOString());
    const currentDate = new Date();
    console.log(currentDate);
    const verifiedUser = await prisma.user.update({
      where: { email },
      data: {
        otp: "000000",
        isVerified: true,
        updated_at: currentDate,
      },
    });

    const userCheck = await prisma.user.findUnique({ where: { email } });
    console.log(userCheck.toString());
    return res.status(200).json({ status: 200, message: "User verified successfully", data: verifiedUser });
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

    // Remove the password field from the response
    const { password: _, ...userWithoutPassword } = user;

    return res.status(200).json({ status: 200, message: "Sign in successful", token, data: userWithoutPassword });
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
  verifyUser,
};