const Class=require('../models/classModel');

exports.createClass=async(req,res)=>{
 try{
    const{name,schoolId}=req.body;

    const newClass=new Class({
        name,
        schoolId
    });
    await newClass.save();

    res.json(newClass);
 }catch(err){
    res.status(500).json({error:err.message});
 }
}