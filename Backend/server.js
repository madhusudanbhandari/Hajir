require('dotenv').config()
const app=require('./src/app');

const PORT=process.env.PORT||5000;

const connectDB=require('./src/config/db');
connectDB();

app.listen(PORT,()=>{
    console.log(`server running on port ${PORT}`);
});

app.use('/api/class', require('./src/routes/classRoutes'));
app.use('/api/student', require('./src/routes/studentRoutes'));
app.use('/api/attendence', require('./src/routes/attendenceRoutes'));
app.use('/api/notifications',require('./src/routes/notificationRoutes'));