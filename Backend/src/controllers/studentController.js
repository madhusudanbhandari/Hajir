const{createStudent, getStudentsByParent}=require('../services/studentService');

exports.addStudent=async(req,res)=>{
    try{
        const student=await createStudent(req.body);
        res.json(student);
    }catch(err){
        res.status(400).json({error:err.message});
        };
};

exports.getMyStudents=async(req,res)=>{
    try{
        const students=await getStudentsByParent(req.user.id);
        res.json(students);
    }catch(err){
        res.status(500).json({error:err.message})
    }
}