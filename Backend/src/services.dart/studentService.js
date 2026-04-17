const Student=require('../models/student');

exports.createStudent=async({name,className,parent})=>{
    const student=await Student.create({
        name,
        className,
        parent
    });
    return student;
};
exports.getStudentsByParent=async(parentId)=>{
    return await Student.find({parent:parentId});
};