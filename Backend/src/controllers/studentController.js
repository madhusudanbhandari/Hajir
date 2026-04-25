const Student=require('../models/Student');
const User=require('../models/user');

exports.createStudent=async(req , res)=>{
    try{
      const {name, classId}=req.body;

     if (!name || !classId){
        return res.status(400).json({msg:'All fields required'});

     }
     const student=new Student({
        name,classId
     });
     await student.save();

     res.json(student);
    }catch(err){
        res.status(500).json({error:err.message});
    }
};

exports.linkParent=async(req,res)=>{
    try{
        const {studentId, parentId}=req.body;

        const parent=await User.findById(parentId);

        if (!parent || parent.role !== "parent") {
            return res.status(400).json({ msg: "Invalid parent" });
         }
         const updatedStudent=await Student.findByIdAndUpdate(
            studentId,
            {parentId},
            {new:true}

         );

         res.json(updateStudent);
        }catch(err){
            res.status(500).json({error:err.message});
        }

    }
