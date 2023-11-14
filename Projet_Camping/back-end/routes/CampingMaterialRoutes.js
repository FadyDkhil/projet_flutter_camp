const express = require('express');
//const { model } = require('mongoose');
const { getAllcampingMaterials, addOnecampingMaterial, editOnecampingMaterial, deleteOnecampingMaterial, deleteAllcampingMaterials } = require('../controller/CampingMaterialController.js')
const router = express.Router();

router.route('/')
.get(getAllcampingMaterials)
.post(addOnecampingMaterial)
.delete(deleteAllcampingMaterials)

router.route('/:id')
.patch(editOnecampingMaterial)
.delete(deleteOnecampingMaterial)

module.exports = router