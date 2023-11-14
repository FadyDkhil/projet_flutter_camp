const mongoose = require('mongoose');

const CampingMaterialSchema = new mongoose.Schema({
    name:{
        type: String,
        required:[true, 'Must provide a task name!'],
        trim: true
    },
    
    description:{
        type: String
    },
    price:{
        type: String
    },
    addDate:{
        type: String
    },
    userID:{
        type: String
    },
    
})

module.exports = mongoose.model('campingMaterial', CampingMaterialSchema)