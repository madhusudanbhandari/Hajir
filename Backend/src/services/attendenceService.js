const attendence=require('../models/attendence');
const Student=require('../models/student');
const { sendNotification } = require('./notificationService');

exports.markAttendenceService=async({student,status})=>{
    const record=await attendence.create({
        student,
        status
    });
    const studentData=await Student.findById(student).populate('parent');

    if(!studentData) {
        throw new Error("Student not found");
    }

    const parentId=studentData.parent?._id;

    if(parentId){
        await sendNotification(parentId, `Your child is ${status} today`);
    }
    return record;


};

exports.getAttendenceByStudent=async(studentId)=>{
    return await attendence.find({student:studentId}).sort({date:-1});
};