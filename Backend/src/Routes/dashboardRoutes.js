const express=require('express');
const router=express.Router();

const{
    parentDashboard,
    teacherDashboard,
    adminDashboard
}=require('../controllers/dashboardController');

const auth=require('../middleware/authMiddleware');

router.get('/parent',auth,parentDashboard);
router.get('/teacher',auth,teacherDashboard);
router.get('/admin',auth,adminDashboard);

module.exports=router;
