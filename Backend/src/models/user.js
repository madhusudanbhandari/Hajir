const mongoose=require('mongoose');

const userSchema= new mongoose.Schema({
    name:String,
    email:{type:String,unique:true},
    password:String,
    role:{
        type:String,
        enum:['teacher','parent','admin'],
        required:true
    }
},{timestamps:true});

module.exports=mongoose.model('User',userSchema);