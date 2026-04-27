const mongoose=require('mongoose');
 
const schoolSchema=new mongoose.Schema({
    name:{
        type:String,
        required:true,
    },
    address:{
        type:String
    },
    contact:{
        type:Number,
    },
    adminId:{
        type:mongoose.SchemaType.ObjectId,
        ref:"User"
    }
},{timestamps:true});
module.exports=mongoose.model('school',schoolSchema)