const attendence=require('../models/attendence');
const Student=require('../models/student');

exports.getParentDashboard=async(studentId, date,month)=>{
    const today=await attendence.findOne({
        studentId,
        date

    });
    const records=await attendence.find({
        studentId,
        date:{$regex:`^${month}`}
    });

let present=0, absent=0, late=0, leave=0;

records.forEach(r=>{
    if(r.status==='present')present++;
    if(r.status==='absent') absent++;
    if(r.status==='late') late++;
    if(r.status==='leave')leave++;
});
return {
    todayStatus: today?.status || "not marked",
    summary: { present, absent, late, leave },
    records
  };
}

exports.getTeacherDashboard=async(classId, date)=>{
    const students=await Student.find({classId});

    const attendence=await attendence.find({classId , date});

    let present=0,absent=0,late=0;

    attendence.forEach(a=>{
        if(a.status==='present') present++;
        if(a.status==='absent') absent++;
        if(a.status==='late') late++;
    });
    return{
        totalStudents:students.length,
        present,
        absent,
        late
    };
};

exports.getAdminDashboard=async(schoolId, date)=>{
    const classes=await Class.find({schoolId});

    const classIds=classed.map(c=>c._id);

    const attendence=await attendence.find({
        classId:{$in:classIds},
        date
    });
    let present=0, absent=0, late=0;

    attendence.forEach(a=>{
        if(a.status==='present')present++;
        if(a.status==='absent')absent++;
        if(a.status==='late')late++;
    });
    return {present, absent, late};
}