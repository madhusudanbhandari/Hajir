const attendence=require('../models/attendence');
const Student=require('../models/student');
const { sendNotification } = require('./notificationService');

exports.markAttendenceService=async({classId, teacherId, date, attendence})=>{
    await attendence.deleteMany({classId,date});
    
    const records=[];

    for (const item of attendence){
            const record=await attendence.create({
                studentId:item.studentId,
                classId,
                teacherId,
                date,
                status:item.status
            });
        const student=await Student.findById(item.studentId);

          if (student?.parentId && (item.status === 'absent' || item.status === 'late')) {
            await sendNotification(
                student.parentId,
                `Your child was marked ${item.status} today`
            );
        }
        records.push(record);
    }
    return records;
};

exports.getAttendenceByClassService=async(classId, date)=>{
    return await attendence.find({classId, date})
    .populate('studentId','name');
};

exports.getAttendenceByStudentService=async(StudentId)=>{
    return await attendence.find({studentId})
    .sort({date:-1});
};

exports.getMonthlyAttendenceService=async(studentId,month)=>{
    return await attendence.find({
        studentId,
        date:{$regex:`${month}`}
    })
}