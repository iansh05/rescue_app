const SOS = require("../models/SOS");

// Create SOS
const createSOS = async (req, res) => {
  try {
    const {
      citizenId,
      emergencyType,
      latitude,
      longitude,
    } = req.body;

    if (!citizenId) {
      return res.status(400).json({
        success: false,
        message: "Citizen ID is required",
      });
    }

    if (!emergencyType) {
      return res.status(400).json({
        success: false,
        message: "Emergency type is required",
      });
    }

    if (
  latitude === undefined ||
  latitude === null ||
  isNaN(latitude)
) {
  return res.status(400).json({
    success: false,
    message: "Latitude is invalid",
  });
}

if (
  longitude === undefined ||
  longitude === null ||
  isNaN(longitude)
) {
  return res.status(400).json({
    success: false,
    message: "Longitude is invalid",
  });
}

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

if (req.query.citizenId) {
  filter.citizenId =
    req.query.citizenId;
}

    const page =
  parseInt(req.query.page) || 1;

const limit =
  parseInt(req.query.limit) || 20;

const skip =
  (page - 1) * limit;

const total =
  await SOS.countDocuments(filter);

const sosList = await SOS.find(filter)
  .sort({
    createdAt: -1,
  })
  .skip(skip)
  .limit(limit);

res.status(200).json({
  success: true,
  page,
  limit,
  total,
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