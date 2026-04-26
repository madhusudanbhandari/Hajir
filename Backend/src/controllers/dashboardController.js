const {getParentDashboard,getTeacherDashboard,getAdminDashboard}=require('../services/dashboardservice');

exports.parentDashboard=async(req,res)=>{
    try{
        const {studentId, date,month}=req.query;

        const data=await getParentDashboard(studentId, date, month);

        res.json(data);
    }catch(err){
        res.status(500).json({error:err.message});
    }
};

exports.teacherDashboard=async(req,res)=>{
    try{
        const{classId ,date}=req.query;

        const data=await getTeacherDashboard(classId,date);

        res.json(data);
    }catch(err){
        res.status(500).json({error:err.message});
    }
}

exports.adminDashboard=async(req,res)=>{
    try{
        const {schoolId, date}=req.query;

        const data=await getAdminDashboard(schoolId,date);

        res.json(data);
    }catch(err){
        res.status(500).json({error:err.message});
    }
}