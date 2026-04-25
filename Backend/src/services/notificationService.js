const notification=require('../models/notification');

exports.sendNotification=async(userId, message , type='attendence')=>{
    const notification=await Notification.create({
        userId,
        message,
        type
    });
    return notification;
};