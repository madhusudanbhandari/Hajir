const mongoose=require('mongoose');

const studentSchema=new mongoose.Schema({
    name:{
        type:string,
        required:true
    },
    className:String,

    parent:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'User'
    }
},{timestamps:true});

module.exports=mongoose.model('Student',studentSchema)