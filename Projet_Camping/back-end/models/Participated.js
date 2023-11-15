const mongoose = require('mongoose');

const ParticipatedSchema = new mongoose.Schema({
    name:{
        type: String,
        required:[true, 'Must provide an event name!'],
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

module.exports = mongoose.model('Participated', ParticipatedSchema)