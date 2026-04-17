const express =require('express');
const cors=require('cors');
const authRoutes=require('./Routes/authRoutes');
const studentRoutes=require('./Routes/studentRoutes');
const attendenceRoutes=require('./Routes/attendenceRoutes');

const app=express();

app.use(cors());
app.use(express.json());
app.use('/api/auth',authRoutes);
app.use('/api/students',studentRoutes);
app.use('/api/attendence',attendenceRoutes);

app.get('/',(req,res)=>{
    res.send("API running....");
});
module.exports=app;