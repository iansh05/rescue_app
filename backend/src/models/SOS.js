const mongoose = require("mongoose");

const sosSchema = new mongoose.Schema(
  {
    citizenId: {
      type: String,
      required: true,
    },

    citizenName: {
      type: String,
      default: "",
    },

    phoneNumber: {
      type: String,
      default: "",
    },

    emergencyType: {
      type: String,
      required: true,
    },

    description: {
      type: String,
      default: "",
    },

    latitude: {
      type: Number,
      required: true,
    },

    longitude: {
      type: Number,
      required: true,
    },

    status: {
      type: String,
      enum: ["PENDING", "ACCEPTED", "RESOLVED"],
      default: "PENDING",
    },

    assignedAuthority: {
      type: String,
      default: null,
    },

    acceptedAt: {
      type: Date,
      default: null,
    },

    resolvedAt: {
      type: Date,
      default: null,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("SOS", sosSchema);