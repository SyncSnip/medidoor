
const asyncHandler = require('express-async-handler');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const prisma = require('../utility/database_connect.js');
const sendEmail = require('../utility/send_mail.js');
const {
  verifyEmailBody,
  verifyEmailSubject,
  forgetOtpSubject,
  forgetOtpMailBody,
  verificationDoneBody,
  verificationDoneSubject,
} = require('../config/messageConfig.js');
const { otpGenerator } = require('../config/otp_generator.js');

const createUser = asyncHandler(async (req, res) => {
  try {
    const { name, password, email } = req.body;

    const findUser = await prisma.user.findUnique({
      where: { email },
    });

    if (findUser) return res.json({ status: 400, message: "User  already exists" });

    const hashedPassword = await bcrypt.hash(password, Number(process.env.PASS_SALT));

    // * generate otp
    const otp = Math.floor(100000 + Math.random() * 900000);

    await sendEmail(email, verifyEmailSubject(), verifyEmailBody(otp, name));

    const newUser = await prisma.user.create({
      data: { name, password: hashedPassword, email, otp: String(otp), isVerified: false },
    });

    // Remove the password field from the response
    const { password: _, ...userWithoutPassword } = newUser;

    const token = jwt.sign(
      { id: newUser.id, email: newUser.email }, process.env.JWT_SECRET, { expiresIn: '1h' });

    return res.status(201).json({
      status: 201,
      message: "New User has been created successfully",
      token,
      data: userWithoutPassword,
    });
  } catch (err) {
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

    if (user.isVerified) {
      return res.json({ status: 401, message: "User is already verified" });
    }

    if (!user) {
      return res.status(404).json({ status: 404, message: "User not found" });
    }

    if (user.otp !== otp) {
      return res.status(403).json({ status: 400, message: "Invalid OTP" });
    }

    const currentDate = new Date();
    const verifiedUser = await prisma.user.update({
      where: { email },
      data: {
        otp: "000000",
        isVerified: true,
        updated_at: currentDate,
      },
    });

    // const { password: _, ...userWithoutPassword } = user;
    await sendEmail(email, verificationDoneSubject(), verificationDoneBody(user.name));

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

    console.log(user);

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

const forgetPassword = asyncHandler(async (req, res) => {
  try {
    const { email } = req.body;
    const user = await prisma.user.findUnique({ where: { email } });

    if (!user) {
      return res.json({ status: 404, message: "User not found" });
    }

    if (!user.isVerified) {
      return res.json({ status: 400, message: "User is not verified" });
    }

    const otp = otpGenerator();
    const currentDate = new Date();

    console.log("otp generated");

    const otpAdded = await prisma.user.update({
      where: { email },
      data: { otp, updated_at: currentDate }
    });

    await sendEmail(email, forgetOtpSubject(), forgetOtpMailBody(otp, user.name));

    return res.status(201).json({ status: "success", message: "OTP has been sent to your email" });
  } catch (err) {
    return res.status(500).json({ status: 500, data: "Internal server error", message: err.message });
  }
});

const forgetPasswordOtpVerify = asyncHandler(async (req, res) => {
  try {
    const { otp, email } = req.body;

    const user = await prisma.user.findUnique({ where: { email } });

    if (!user) {
      return res.status(404).json({ status: 404, message: "User not found" });
    }

    if (otp !== user.otp) {
      return res.status(400).json({ status: 400, message: "Invalid OTP" });
    }

    return res.status(200).json({ status: "success", message: "OTP verified successfully" });
  } catch (err) {
    return res.json({ status: 500, data: "Internal server error", message: err });
  }
});

const forgetPasswordUpdate = asyncHandler(async (req, res) => {
  try {
    const { email, password, otp } = req.body;

    const user = await prisma.user.findUnique({ where: { email } });

    if (!user) {
      return res.status(404).json({ status: 404, message: "User not found" });
    }

    if (otp !== user.otp) {
      return res.status(400).json({ status: 400, message: "Invalid OTP" });
    }
    const hashedPassword = await bcrypt.hash(password, Number(process.env.PASS_SALT));

    const updatePassword = await prisma.user.update({
      where: { email },
      data: { password: hashedPassword, otp: "000000", updated_at: new Date() }
    })

    return res.status(201).json({ status: "success", message: "Password has been updated" });
  } catch (err) {
    return res.status(500).json({ status: 500, data: "Internal server error", message: err.message });
  }
});

module.exports = {
  getAllUsers,
  createUser,
  updateUser,
  deleteUser,
  signIn,
  verifyUser,
  forgetPassword,
  forgetPasswordUpdate,
  forgetPasswordOtpVerify,
};