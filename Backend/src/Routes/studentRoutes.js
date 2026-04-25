const express=require('express');
const router=express.Router();
const auth=require('../middleware/authMiddleware');
const {createStudent ,linkParent}=require('../controllers/studentController');


router.post('/create',auth,createStudent);
router.put('link-parent',auth,linkParent);

module.exports=router;