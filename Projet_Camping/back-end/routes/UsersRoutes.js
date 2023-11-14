const express = require('express');
//const { model } = require('mongoose');
const { getAllUsers, addUser, getUserName } = require('../controller/UsersController.js');
const router = express.Router();

router.route('/')
.get(getAllUsers)
.post(addUser)

router.route('/:userId')
    .get(getUserName);

module.exports = router