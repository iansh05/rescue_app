const jwt = require("jsonwebtoken");

// Koi bhi valid JWT verify karo (citizen ya authority)
const protect = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({
        success: false,
        message: "Access denied. No token provided.",
      });
    }

    const token = authHeader.split(" ")[1];

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // User info request mein attach karo
    req.user = decoded;

    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: "Invalid or expired token.",
    });
  }
};

// Sirf authority allow karo (Police, Fire, Medical)
const authorityOnly = (req, res, next) => {
  if (!req.user || req.user.type !== "authority") {
    return res.status(403).json({
      success: false,
      message: "Access denied. Authority only.",
    });
  }
  next();
};

// Sirf citizens allow karo
const citizenOnly = (req, res, next) => {
  if (!req.user || req.user.type !== "citizen") {
    return res.status(403).json({
      success: false,
      message: "Access denied. Citizens only.",
    });
  }
  next();
};

module.exports = { protect, authorityOnly, citizenOnly };