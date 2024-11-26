const router = require('express').Router();
const {
  getAllUsers,
  createUser,
  updateUser,
  signIn,
  deleteUser,
} = require("../controller/userController.js");

router.get('/all-users', getAllUsers);

router.post('/signup', createUser);
router.post('/signin', signIn);

router.put('/:id', updateUser);

router.delete('/:id', deleteUser);

module.exports = router;