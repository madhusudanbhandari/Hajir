const express = require('express');
const router = express.Router();
const auth = require('../middleware/authMiddleware');
const { markAttendenceService, getAttendenceByClassService, getAttendenceByStudentService, getMonthlyAttendenceService } = require('../services/attendenceService');

router.post('/mark', auth, markAttendenceService);

router.get('/class', auth, getAttendenceByClassService);

router.get('/student/:studentId', auth, getAttendenceByStudentService);

router.get('/monthly', auth, getMonthlyAttendenceService);

module.exports = router;