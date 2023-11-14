const express = require('express');
//const { model } = require('mongoose');
const { getAllEvents, addOneEvent, editOneEvent, deleteOneEvent, deleteAllEvents } = require('../controller/EventsController.js')
const router = express.Router();

router.route('/')
.get(getAllEvents)
.post(addOneEvent)
.delete(deleteAllEvents)

router.route('/:id')
.patch(editOneEvent)
.delete(deleteOneEvent)

module.exports = router