const verifyEmailSubject = () => {
  return "Verify Your Registration - Your OTP is Here!";
}

const forgetOtpSubject = () => {
  return "Reset Your Password for Medidoor";
}



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

const forgetOtpMailBody = (otp, name) => {
  return `
Dear ${name},

We received a request to reset your password for your Medidoor account. Use the One-Time Password (OTP) below to proceed with resetting your password:

Your OTP: ${otp}

This OTP is valid for the next 15 minutes. Please do not share this code with anyone for security purposes.

If you did not request a password reset, you can safely ignore this email. Rest assured, your account is secure.

For further assistance, feel free to reach out to us at medidoor@outlook.com.

Thank you,
The Medidoor Team`;
};

module.exports = {
  verifyEmailBody,
  verifyEmailSubject,
  forgetOtpSubject,
  forgetOtpMailBody,
};