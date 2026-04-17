const Student=require('./models/Student');

exports.getParentDashboard=async(parentId)=>{
    const students=await Student.find({parent:parentId});

    const result=[];

    for (let student of students){
        const attendence=await attendence.find({student:student._id});

        result.push({
            student,
            attendence
        });
       
      }
      return result;
};