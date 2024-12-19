const verifyEmailSubject = () => {
  return "Verify Your Registration - Your OTP is Here!";
}

const forgetOtpSubject = () => {
  return "Reset Your Password for Medidoor";
}

const verificationDoneSubject = () => {
  return "Verified User";
}


const verifyEmailBody = (otp, name) => {
  return `
Hi ${name},

Thank you for signing up with MediDoor!! To complete your registration, please verify your email by entering the One-Time Password (OTP) below:

Your OTP: ${otp}

This OTP is valid for the next 10 minutes. If you didn’t request this, please ignore this email or contact our support team immediately.

We’re excited to have you on board and can’t wait for you to explore the seamless experience of MediDoor.

If you have any questions, feel free to reach out at support@medidoor.com.

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


const verificationDoneBody = (name) => {
  return `
Dear ${name},
We are excited to inform you that your registration process for the Medidoor app has been successfully completed! Thank you for choosing to join our community.

You can now log in to your account and start exploring all the features and benefits that Medidoor has to offer.
If you have any questions or need assistance, please feel free to reach out to our support team at medidoor@outlook.com.
Thank you for being a part of Medidoor!

Best regards,
The Medidoor Team
`;
};

module.exports = {
  verifyEmailBody,
  verifyEmailSubject,
  forgetOtpSubject,
  forgetOtpMailBody,
  verificationDoneBody,
  verificationDoneSubject,
};