const express=require('express');
const router=express.Router();

const auth=require('../middleware/authMiddleware');
const {allowRoles}=require('../middleware/roleMiddleware');

const {markAttendence,getStudentAttendence,getDashboard}=require('../controllers/attendenceController');

router.post('/mark',auth, allowRoles('teacher'),markAttendence);

router.get('/student/:id',auth,getStudentAttendence);

router.get('dashboard',auth,allowRoles('parenet'),getDashboard)

module.exports=router;