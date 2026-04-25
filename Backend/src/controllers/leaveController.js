// controllers/leaveController.js
const {
  requestLeaveService,
  getPendingLeavesService,
  updateLeaveStatusService
} = require('../services/leaveService');

exports.requestLeave = async (req, res) => {
  try {
    const leave = await requestLeaveService({
      ...req.body,
      parentId: req.user.id
    });

    res.json(leave);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


exports.getPendingLeaves = async (req, res) => {
  try {
    const leaves = await getPendingLeavesService();
    res.json(leaves);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


exports.updateLeaveStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const leave = await updateLeaveStatusService(id, status);

    res.json(leave);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};