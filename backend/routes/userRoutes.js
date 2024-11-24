const router = require('express').Router();
const {
  getAllUsers,
  createUser,
} = require("../controller/userController.js");

router.get('/all-users', getAllUsers);
router.post('/signup', createUser);

module.exports = router;