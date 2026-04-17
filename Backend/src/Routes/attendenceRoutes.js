const express=require('express');
const router=express.Router();

const auth=require('../middleware/authMiddleware');
const {allowRoles}=require('../middleware/roleMiddleware');

const {markAttendence}=require('../controllers/attendenceController');

router.post('/mark',auth, allowRoles('teacher'),markAttendence);

module.exports=router;