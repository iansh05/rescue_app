const jwt = require("jsonwebtoken");
const User = require("../models/User");
const Authority = require("../models/Authority");

// JWT token generate karo
const generateToken = (payload) => {
  return jwt.sign(payload, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN || "7d",
  });
};

// OTP store (demo ke liye memory mein)
const otpStore = new Map();

// ─────────────────────────────────────────
// CITIZEN AUTH
// ─────────────────────────────────────────

// POST /api/auth/citizen/send-otp
const sendOTP = async (req, res) => {
  try {
    const { phoneNumber, name } = req.body;

    if (!phoneNumber) {
      return res.status(400).json({
        success: false,
        message: "Phone number is required.",
      });
    }

    // Demo OTP - frontend ke saath match karta hai (123456)
    const otp = "123456";

    // 5 minute expiry ke saath store karo
    otpStore.set(phoneNumber, {
      otp,
      name: name || "Citizen",
      expiresAt: Date.now() + 5 * 60 * 1000,
    });

    console.log(`OTP for ${phoneNumber}: ${otp}`);

    res.status(200).json({
      success: true,
      message: "OTP sent successfully.",
      demoOtp: otp,
    });
  } catch (error) {
    console.error("Send OTP error:", error);
    res.status(500).json({
      success: false,
      message: "Failed to send OTP.",
    });
  }
};

// POST /api/auth/citizen/verify-otp
const verifyOTP = async (req, res) => {
  try {
    const { phoneNumber, otp, name } = req.body;

    if (!phoneNumber || !otp) {
      return res.status(400).json({
        success: false,
        message: "Phone number and OTP are required.",
      });
    }

    const stored = otpStore.get(phoneNumber);

    if (!stored) {
      return res.status(400).json({
        success: false,
        message: "OTP not found. Please request a new one.",
      });
    }

    if (Date.now() > stored.expiresAt) {
      otpStore.delete(phoneNumber);
      return res.status(400).json({
        success: false,
        message: "OTP expired. Please request a new one.",
      });
    }

    if (stored.otp !== otp) {
      return res.status(400).json({
        success: false,
        message: "Invalid OTP.",
      });
    }

    // OTP sahi hai - store se hata do
    otpStore.delete(phoneNumber);

    // Citizen find karo ya naya banao
    let user = await User.findOne({ phoneNumber });

    if (!user) {
      user = await User.create({
        phoneNumber,
        name: name || stored.name || "Citizen User",
        isVerified: true,
      });
    } else {
      user.isVerified = true;
      if (name) user.name = name;
      await user.save();
    }

    // JWT generate karo
    const token = generateToken({
      id: user._id,
      type: "citizen",
      role: "citizen",
      phoneNumber: user.phoneNumber,
      name: user.name,
    });

    res.status(200).json({
      success: true,
      message: "Login successful.",
      token,
      user: {
        id: user._id,
        name: user.name,
        phoneNumber: user.phoneNumber,
        role: user.role,
      },
    });
  } catch (error) {
    console.error("Verify OTP error:", error);
    res.status(500).json({
      success: false,
      message: "OTP verification failed.",
    });
  }
};

// ─────────────────────────────────────────
// AUTHORITY AUTH
// ─────────────────────────────────────────

// POST /api/auth/authority/login
const authorityLogin = async (req, res) => {
  try {
    const { authorityId, password, role } = req.body;

    if (!authorityId || !password) {
      return res.status(400).json({
        success: false,
        message: "Authority ID and password are required.",
      });
    }

    const authority = await Authority.findOne({ authorityId });

    if (!authority) {
      return res.status(401).json({
        success: false,
        message: "Invalid Authority ID or password.",
      });
    }

    if (!authority.isActive) {
      return res.status(403).json({
        success: false,
        message: "Account deactivated. Contact admin.",
      });
    }

    const isMatch = await authority.comparePassword(password);

    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: "Invalid Authority ID or password.",
      });
    }

    const token = generateToken({
      id: authority._id,
      type: "authority",
      role: authority.role,
      authorityId: authority.authorityId,
      name: authority.name,
    });

    res.status(200).json({
      success: true,
      message: "Authority login successful.",
      token,
      authority: {
        id: authority._id,
        authorityId: authority.authorityId,
        name: authority.name,
        role: authority.role,
      },
    });
  } catch (error) {
    console.error("Authority login error:", error);
    res.status(500).json({
      success: false,
      message: "Login failed.",
    });
  }
};

// POST /api/auth/authority/register
const registerAuthority = async (req, res) => {
  try {
    const { authorityId, password, name, role } = req.body;

    if (!authorityId || !password || !name || !role) {
      return res.status(400).json({
        success: false,
        message: "All fields required: authorityId, password, name, role.",
      });
    }

    const existing = await Authority.findOne({ authorityId });

    if (existing) {
      return res.status(409).json({
        success: false,
        message: "Authority ID already exists.",
      });
    }

    const authority = await Authority.create({
      authorityId,
      password,
      name,
      role,
    });

    res.status(201).json({
      success: true,
      message: "Authority registered successfully.",
      authority: {
        id: authority._id,
        authorityId: authority.authorityId,
        name: authority.name,
        role: authority.role,
      },
    });
  } catch (error) {
    console.error("Register authority error:", error);
    res.status(500).json({
      success: false,
      message: "Registration failed.",
    });
  }
};

// GET /api/auth/me
const getMe = async (req, res) => {
  res.status(200).json({
    success: true,
    user: req.user,
  });
};

module.exports = {
  sendOTP,
  verifyOTP,
  authorityLogin,
  registerAuthority,
  getMe,
};