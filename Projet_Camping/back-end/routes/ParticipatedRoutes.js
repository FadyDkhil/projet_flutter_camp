const express = require('express');

const {getAll, deleteOne, addOne} = require('../controller/ParticipatedController.js')
const router = express.Router();

router.route('/')
.get(getAll)
.post(addOne)

router.route('/:id')
.delete(deleteOne)

module.exports = router