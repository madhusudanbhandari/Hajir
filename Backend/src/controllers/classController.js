const Class=require('../models/class');
const User=require('../models/user');


exports.createClass=async(req,res)=>{
 try{
    const{name,schoolId}=req.body;

    const newClass=new Class({
        name,
        schoolId
    });
    await newClass.save();

    res.json(newClass);
 }catch(err){
    res.status(500).json({error:err.message});
 }
}

exports.assignTeacher=async(req,res)=>{
    try{
        const {classId,teacherId}=req.body;

        const teacher=await User.findById(teacherId);

         if (!teacher || teacher.role !== "teacher") {
            return res.status(400).json({ msg: "Invalid teacher" });
        }
        const updatedClass=await Class.findByIdAndUpdate(
            classId,
            {teacherId},
            {new:true}
        );
        res.json(updatedClass);
    }catch(err){
        res.json(500).json({error:err.message});
    }
};