const SOS = require("../models/SOS");

// Create SOS
const createSOS = async (req, res) => {
  try {
    const sos = await SOS.create(req.body);

    res.status(201).json({
      success: true,
      data: sos,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Get All SOS
const getAllSOS = async (req, res) => {
  try {
    const filter = {};

    if (req.query.status) {
      filter.status = req.query.status;
    }

    const sosList = await SOS.find(filter).sort({
      createdAt: -1,
    });

    res.status(200).json({
      success: true,
      count: sosList.length,
      data: sosList,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Get SOS By ID
const getSOSById = async (req, res) => {
  try {
    const sos = await SOS.findById(req.params.id);

    if (!sos) {
      return res.status(404).json({
        success: false,
        message: "SOS not found",
      });
    }

    res.status(200).json({
      success: true,
      data: sos,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Accept SOS
const acceptSOS = async (req, res) => {
  try {
    const sos = await SOS.findById(req.params.id);

    if (!sos) {
      return res.status(404).json({
        success: false,
        message: "SOS not found",
      });
    }

    sos.status = "ACCEPTED";
    sos.assignedAuthority =
      req.body.assignedAuthority || "Authority";
    sos.acceptedAt = new Date();

    await sos.save();

    res.status(200).json({
      success: true,
      message: "SOS accepted successfully",
      data: sos,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

// Resolve SOS
const resolveSOS = async (req, res) => {
  try {
    const sos = await SOS.findById(req.params.id);

    if (!sos) {
      return res.status(404).json({
        success: false,
        message: "SOS not found",
      });
    }

    sos.status = "RESOLVED";
    sos.resolvedAt = new Date();

    await sos.save();

    res.status(200).json({
      success: true,
      message: "SOS resolved successfully",
      data: sos,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};
const getSOSStats = async (req, res) => {
  try {
    const pending = await SOS.countDocuments({
      status: "PENDING",
    });

    const accepted = await SOS.countDocuments({
      status: "ACCEPTED",
    });

    const resolved = await SOS.countDocuments({
      status: "RESOLVED",
    });

    res.status(200).json({
      success: true,
      data: {
        pending,
        accepted,
        resolved,
      },
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports = {
  createSOS,
  getAllSOS,
  getSOSById,
  acceptSOS,
  resolveSOS,
  getSOSStats,
};