const express=require('express');
const router=express.Router();
const {createSchool}=require('../controllers/schoolController')
const auth=require('../middleware/auth');

router.post('/create',auth,createSchool);

module.exports=router;