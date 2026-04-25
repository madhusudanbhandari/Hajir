const express=require('express');
const router=express.Router();

const{getMyNotification,markAsRead}=require('../controllers/notificationController');
const auth=require('../middleware/authMiddleware');

router.get('/',auth,getMyNotification);
router.put('/:id/read',auth,markAsRead);

module.exports=router;