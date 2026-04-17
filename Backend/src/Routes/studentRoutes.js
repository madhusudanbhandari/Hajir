const express=require('express');
const router=express.Router();

const auth=require('../middleware/authMiddleware');
const {allowwRoles, allowRoles}=require('../middleware/roleMiddleware');

const{addStudents,getMyStudents}=require('../controllers/studentController');

router.post('/add',auth,allowRoles('teacher','admin'),student);

router.get('/my',auth,allowRoles('parent'),getMyStudents);

module.exports=router;