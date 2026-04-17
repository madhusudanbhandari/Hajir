const mongoose=require('mongoose');

const attendenceSchema= new mongoose.Schema({
    student: {
        type:mongoose.Schema.Types.ObjectId,
        ref:'Student',
        required:true
    },
    date:{
        type:Date,
        default:Date.now,
    },
    status:{
        type:String,
        enum:['present','absent','failure'],
        required:true
        
    }

},{timestamp:true});

module.exports=mongoose.model('Attendence',attendenceSchema)