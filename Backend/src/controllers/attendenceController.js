const {markAttendenceService}=require('../services/attendenceService');
const {getAttendenceByStudent,getParentDashboard}=require('../services/attendenceService')

exports.markAttendence=async(req,res)=>{
    try{
        const result=await markAttendenceService(req.body);
        res.json(result);
    }catch(err){
        res.status(400).json({error:err.message});
    }
};

exports.getStudentAttendence=async(req,res)=>{
    try{
        const data=await getAttendenceByStudent(req.params.id);
        res.json(data);
    }catch(err){
        res.status(500).json({error:err.message});
    }
};

exports.getDashboard=async(req,res)=>{
    try{
        const data=await getParentDashboard(req.user.id);
        res.json(data);
    }catch(err){
        res.status(500).json({error:err.message});
    }
};
