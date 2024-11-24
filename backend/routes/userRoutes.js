const router = require('express').Router();
const {
  getAllUsers,
} = require("../controller/userController.js");

router.get('/all-users', getAllUsers);

module.exports = router;