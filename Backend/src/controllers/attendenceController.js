const {markAttendenceService}=require('../services/attendenceService');


exports.markAttendence=async(req,res)=>{
    try{
        const result=await markAttendenceService(req.body);
        res.json(result);
    }catch(err){
        res.status(400).json({error:err.message});
    }
};