const Participated = require('../models/Participated.js')

const getAll = async (req,res) => {
    try{
        const events = await Participated.find({})
        res.status(200).json({events})
    }catch(err){
        res.status(500).json({msg: err})
    }
    
}
const deleteOne = async (req,res) => {
    try{
        const {id : eventID} = req.params;
        const event = await Participated.findOneAndDelete({_id: eventID})
        res.status(203).json({event})
    }catch(err){
        res.status(500).json({msg: err})
    }
}
const addOne = async (req,res) => {
    try{
        const event = await Participated.create(req.body)
        res.status(201).json({ event })
    }catch (err){
        res.status(500).json({msg: err})
    }
}


module.exports = {
    getAll,
    deleteOne,
    addOne,
}