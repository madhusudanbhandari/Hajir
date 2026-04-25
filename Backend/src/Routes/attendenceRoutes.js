// routes/attendanceRoutes.js
const express = require('express');
const router = express.Router();

const {
  markAttendance,
  getAttendanceByClass,
  getAttendanceByStudent,
  getMonthlyAttendance
} = require('../controllers/attendanceController');

const auth = require('../middleware/auth');

router.post('/mark', auth, markAttendance);

router.get('/class', auth, getAttendanceByClass);

router.get('/student/:studentId', auth, getAttendanceByStudent);

router.get('/monthly', auth, getMonthlyAttendance);

module.exports = router;