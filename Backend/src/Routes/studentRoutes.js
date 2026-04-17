const express=require('express');
const router=express.Router();

const auth=require('../middleware/authMiddleware');
const {allowRoles}=require('../middleware/roleMiddleware');

const{addStudent,getMyStudents}=require('../controllers/studentController');

router.post('/add',auth, allowRoles('teacher','admin'),addStudent);

router.get('/my',auth, allowRoles('parent'),getMyStudents);

module.exports=router;