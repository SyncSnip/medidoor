const verifyEmailBody = (otp, name) => {
  return `
Hi ${name},

Thank you for signing up with MediDoor!! To complete your registration, please verify your email by entering the One-Time Password (OTP) below:

Your OTP: ${otp}

This OTP is valid for the next 10 minutes. If you didn’t request this, please ignore this email or contact our support team immediately.

We’re excited to have you on board and can’t wait for you to explore the seamless experience of MediDoor.

If you have any questions, feel free to reach out at  medidoor@outlook.com.

Warm regards,
Team MediDoor`;
}

const verifyEmailSubject = () => {
  return "Verify Your Registration - Your OTP is Here!";
}

module.exports = {
  verifyEmailBody,
  verifyEmailSubject,
};