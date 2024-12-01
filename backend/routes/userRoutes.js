const router = require('express').Router();
const {
  getAllUsers,
  createUser,
  updateUser,
  signIn,
  deleteUser,
  verifyUser,
  forgetPassword,
  forgetPasswordUpdate,
  forgetPasswordOtpVerify,
} = require("../controller/userController.js");
const { authMiddleware, isVerifiedUser } = require('../middleware/authMiddleware.js');

router.get('/all-users', getAllUsers);

router.put('/verify-user', authMiddleware, verifyUser);
router.put('/:id', updateUser);

router.post('/signup', createUser);
router.post('/signin', isVerifiedUser, signIn);
router.post('/forget-password', isVerifiedUser, forgetPassword);
router.post('/verify-forget-password', isVerifiedUser, forgetPasswordOtpVerify);
router.post('/update-forget-password', isVerifiedUser, forgetPasswordUpdate);

router.delete('/:id', deleteUser);

module.exports = router;