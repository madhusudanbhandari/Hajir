const notification=require('../models/notification');

exports.getMyNotification=async(req,res)=>{
    try{
        const userId=req.user.id;

        const notifications=await Notification.find({userId})
        .sort({createadAr:-1});

        res.json(notification);
    }catch(err){
        res.status(500).json({error:err.message});
    }
};
exports.markAsRead = async (req, res) => {
  try {
    const { id } = req.params;

    await Notification.findByIdAndUpdate(id, { isRead: true });

    res.json({ msg: "Marked as read" });

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};