const mongoose=require('mongoose');

const attendenceSchema= new mongoose.Schema({
    student: {
        type:mongoose.Schema.Types.ObjectId,
        ref:'Student',
        required:true
    },
    classId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Class',
        required:'true'
    },
    teacherId:{
        type:mongoose.Types.ObjectId,
        ref:'User',
        required:'true'
    },
    date:{
        type:String,
        required:true
    },
    status:{
        type:String,
        enum:['present','absent','failure'],
        required:true
        
    }

},{timestamp:true});

attendenceSchema.index({studentId:1, date:1},{unique:true});
module.exports=mongoose.model('Attendence',attendenceSchema);