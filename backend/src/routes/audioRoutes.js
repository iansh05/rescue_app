const express = require("express");
const multer = require("multer");
const SOS = require("../models/SOS");

const router = express.Router();

const storage = multer.diskStorage({
  destination(req, file, cb) {
    cb(null, "uploads/audio");
  },
  filename(req, file, cb) {
    cb(
      null,
      Date.now() +
        "-" +
        file.originalname
    );
  },
});

const upload = multer({
  storage,
});

router.post(
  "/:id/audio",
  upload.single("audio"),
  async (req, res) => {
    try {
      const sos =
        await SOS.findById(
          req.params.id,
        );

      if (!sos) {
        return res
            .status(404)
            .json({
          error:
              "SOS not found",
        });
      }

      sos.audioUrl =
          `/uploads/audio/${req.file.filename}`;

      await sos.save();

      res.json({
        success: true,
        audioUrl:
            sos.audioUrl,
      });
    } catch (e) {
      res.status(500).json({
        error: e.message,
      });
    }
  },
);

module.exports = router;