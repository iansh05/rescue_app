const express = require("express");

const {
  createSOS,
  getAllSOS,
  getSOSById,
  acceptSOS,
  resolveSOS,
  getSOSStats,
} = require("../controllers/sosController");

const router = express.Router();

// Statistics
router.get("/stats", getSOSStats);

// Create SOS
router.post("/", createSOS);

// Get All SOS
router.get("/", getAllSOS);

// Get Single SOS
router.get("/:id", getSOSById);

// Accept SOS
router.patch("/:id/accept", acceptSOS);

// Resolve SOS
router.patch("/:id/resolve", resolveSOS);

module.exports = router;