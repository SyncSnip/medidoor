const asyncHandler = require('express-async-handler');

const getAllUsers = asyncHandler(async (req, res) => {
  try {
    return res.send("there is no users in the database")
  } catch (err) {
    return res.json({
      status: 500,
      data: "Internal server error",
      message: err.message
    });
  }
});

module.exports = {
  getAllUsers,
}