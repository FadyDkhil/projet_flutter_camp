const campingMaterial = require('../models/CampingMaterial.js')


    const getAllcampingMaterials = async (req,res) => {
        try{
            const campingMaterials = await campingMaterial.find({})
            res.status(200).json({campingMaterials})
        }catch(err){
            res.status(500).json({msg: err})
        }
        
    }
    

const addOnecampingMaterial = async (req,res) => {
    try{
        const campingMaterials = await campingMaterial.create(req.body)
        res.status(201).json({ campingMaterials })
    }catch (err){
        res.status(500).json({msg: err})
    }
}


const editOnecampingMaterial = async (req,res) => {
    try{
        const {id:campingMaterialID} = req.params
        const updatedcampingMaterial = await campingMaterial.findOneAndUpdate({_id: campingMaterialID}, req.body,{ new: true, runValidators: true})
        if(!updatedcampingMaterial){
            return res.status(404).json({msg: 'no campingMaterial with the ID: ${campingMaterialID}'})
        }
        res.status(202).json({updatedcampingMaterial})
    }catch(err){
        res.status(500).json({msg: err})
    }
}
const deleteOnecampingMaterial = async (req,res) => {
    try{
        const {id : campingMaterialID} = req.params;
        const deleteCampingMaterial = await campingMaterial.findOneAndDelete({_id: campingMaterialID})
        res.status(203).json({deleteCampingMaterial})
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
const deleteAllcampingMaterials = async (req, res) => {
    try{
        const deletedcampingMaterials = await campingMaterial.deleteMany({})
        res.status(203).json({ deletedcampingMaterials })
    }catch(err)
    {
        res.status(500).json({msg: err})
    }

}
module.exports = { 
getAllcampingMaterials,
addOnecampingMaterial,
editOnecampingMaterial,
deleteAllcampingMaterials,
deleteOnecampingMaterial,
}