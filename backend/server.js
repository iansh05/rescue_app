const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");

const connectDB =
  require("./src/config/db");

dotenv.config();

connectDB();
const sosRoutes = require("./src/routes/sosRoutes");

const app = express();

app.use(cors());
app.use(express.json());
app.use("/api/sos", sosRoutes);

app.get("/", (req, res) => {
  res.send("Sentinel Backend Running");
});

const PORT =
  process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(
    `Server running on port ${PORT}`
  );
});
