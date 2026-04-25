const {markAttendenceService,getAttendenceByClassService,getAttendenceByStudentService,getMonthlyAttendenceService}=require('../services/attendenceService');

exports.markAttendenceService=async(req,res)=>{
    try{
        const {classId, date, attendence}=req.body;
        const teacherId=req.user.id;

        if (!classId || !date || !attendance) {
        return res.status(400).json({ msg: "Missing required fields" });
    }
    const result=await markAttendenceService({
        classId,teacherId,date,attendence
    });
    res.json({msg:'Attendence marked successfully',
        data:result
    });
    }catch(err){
        res.status(500).json({error:err.message});
    }
    };
    exports.getAttendenceByClass=async(req,res)=>{
        try{
            const {classId,date}=req.query;

            const data=await getAttendenceByClassService(classId,date);

            res.json(data);
        }catch(err){
            res.status(500).json({error:err.message});
        }
    };



exports.getAttendanceByStudent = async (req, res) => {
  try {
    const { studentId } = req.params;

    const data = await getAttendanceByStudentService(studentId);

    res.json(data);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


exports.getMonthlyAttendance = async (req, res) => {
  try {
    const { studentId, month } = req.query;

    const data = await getMonthlyAttendanceService(studentId, month);

    res.json(data);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};