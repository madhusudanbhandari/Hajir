const mongoose=require('mongoose');

const leaveSchema= new mongoose.Schema({
    studentId:{
        type:mongoose.Types.ObjectId,
        ref:'Student',
        required:true
    },
    parentId:{
        type:mongoose.Types.ObjectId,
        ref:'User',
        required:'true'
    },
    fromDate:String,
    toDate:String,
    reason:String,
    status:{
        type:String,
        enum:['pending','approved','rejected'],
        default:'pending'
    }
},{timestamps:true});


module.exports =
  mongoose.models.Leave ||
  mongoose.model('Leave', leaveSchema);