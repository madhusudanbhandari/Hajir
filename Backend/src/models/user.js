const mongoose=require('mongoose');

const userSchema= new mongoose.Schema({
    name:String,
    email:{type:String,unique:true},
    password:String,
    role:{
        type:String,
        enum:['teacher','parent','admin','student'],
        required:true
    },
    schoolId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'School'
        }
},{timestamps:true});

module.exports=mongoose.model('User',userSchema);