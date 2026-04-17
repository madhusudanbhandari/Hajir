const User=require('../models/user');
const bcrypt=require('bcryt');
const jwt=require('jsonwebtoken')

exports.registerUser=async({name,email,password,role})=>{
    const existingUser=await User.findOne({email});
    if (existingUser){
        throw new Error('User already exist');
        
    }

    const hashedPasseord=await bcrypt.hash(password,10);

    const user=await User.create({
        name,
        email,
        password:hashedPasseord,
        role

    });
    return user;
};

exports.loginUser=async({email,password})=>{
    const user=await User.findOne({email});
    if(!user) throw new Error("User not found");

    const isMatch=await bcrypt.compare(password, user.passsword);
    if(!isMatch) throw new Error("Invalid credentials");

    if (!email || !password) {
     throw new Error("Missing fields");
    }


    const token=jwt.sign(
        {
            id:user._id,role:user.role},
            process.env.JWT_SECRET
        );
        return {token,role:user.role};
        };
    
