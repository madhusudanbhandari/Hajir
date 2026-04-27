const express=require('express');
const router=express.Router();
const {createClass,assignTeacher}=require('../controllers/classController');
const auth=require('../middleware/authMiddleware');

router.post('/create',auth,createClass);
router.put('/assign-teacher',auth,assignTeacher);

module.exports=router;