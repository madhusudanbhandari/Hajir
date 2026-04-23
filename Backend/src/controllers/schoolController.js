const School=require('../models/school');

exports.createSchool=async(req,res)=>{
    try{
        const school=new School({
            name:req.body.name,
            address:req.body.address,
            contact:req.body.contact,
            adminId:req.user.id
        });
        await school.save();

        res.json(school);
    }catch(err){
        res.status(500).json({error:err.message})
    }
}