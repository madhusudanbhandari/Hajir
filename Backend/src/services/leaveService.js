const Leave = require('../models/Leave');
const { sendNotification } = require('./notificationService');

exports.requestLeaveService = async (data) => {
  const leave = await Leave.create(data);
  return leave;
};

exports.getPendingLeavesService = async () => {
  return await Leave.find({ status: 'pending' })
    .populate('studentId');
};

exports.updateLeaveStatusService = async (leaveId, status) => {
  const leave = await Leave.findByIdAndUpdate(
    leaveId,
    { status },
    { new: true }
  );

  if (leave) {
    await sendNotification(
      leave.parentId,
      `Your leave request was ${status}`
    );
  }

  return leave;
};