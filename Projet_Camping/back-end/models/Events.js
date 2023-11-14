const mongoose = require('mongoose');

const EventsSchema = new mongoose.Schema({
    name:{
        type: String,
        required:[true, 'Must provide a task name!'],
        trim: true
    },
    location:{
        type: String,
    },
    description:{
        type: String
    },
    startDate:{
        type: String
    },
    endDate:{
        type: String
    },
    maxPeople:{
        type: String
    },
    userID:{
        type: String
    },
})

module.exports = mongoose.model('Event', EventsSchema)