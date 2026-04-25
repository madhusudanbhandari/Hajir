const express = require('express');
const router = express.Router();

const {
  requestLeave,
  getPendingLeaves,
  updateLeaveStatus
} = require('../controllers/leaveController');

const auth = require('../middleware/authMiddleware');

router.post('/request', auth, requestLeave);

router.get('/pending', auth, getPendingLeaves);

router.put('/:id/status', auth, updateLeaveStatus);

module.exports = router;