const Event = require('../models/Events.js')

const getAllEvents = async (req, res) => {
    try {
        let filter = {}; // Default filter to get all events

        // Check if the 'location' or 'name' query parameter is present
        if (req.query.location) {
            filter = { location: req.query.location };
        } else if (req.query.name) {
            filter = { name: { $regex: new RegExp(req.query.name, 'i') } };
        }

        const events = await Event.find(filter);

        res.status(200).json({ events });
    } catch (err) {
        res.status(500).json({ msg: err });
    }
}

// const getAllEvents = async (req,res) => {
//     try{
//         const events = await Event.find({})
//         res.status(200).json({events})
//     }catch(err){
//         res.status(500).json({msg: err})
//     }
    
// }
const addOneEvent = async (req,res) => {
    try{
        const event = await Event.create(req.body)
        res.status(201).json({ event })
    }catch (err){
        res.status(500).json({msg: err})
    }
}


const editOneEvent = async (req,res) => {
    try{
        const {id:eventID} = req.params
        const updatedEvent = await Event.findOneAndUpdate({_id: eventID}, req.body,{ new: true, runValidators: true})
        if(!updatedEvent){
            return res.status(404).json({msg: 'no Event with the ID: ${eventID}'})
        }
        res.status(202).json({updatedTask})
    }catch(err){
        res.status(500).json({msg: err})
    }
}
const deleteOneEvent = async (req,res) => {
    try{
        const {id : eventID} = req.params;
        const event = await Event.findOneAndDelete({_id: eventID})
        res.status(203).json({event})
    }catch(err){
        res.status(500).json({msg: err})
    }
}


// const getOneTask = async (req,res) => {
//     try{
//         const {id:taskID} = req.params
//         const task = await Task.findOne({_id:taskID})
//         if(!task){
//             return res.status(404).json({msg: 'no task with ID: ${taskID}'})
//         }
//         res.status(200).json({task})
//     }catch(err){
//         res.status(500).json({msg: err})
//     }
// }
const deleteAllEvents = async (req, res) => {
    try{
        const deletedEvents = await Event.deleteMany({})
        res.status(203).json({ deletedEvents })
    }catch(err)
    {
        res.status(500).json({msg: err})
    }

}
module.exports = { 
getAllEvents,
addOneEvent,
editOneEvent,
deleteAllEvents,
deleteOneEvent,
}
