const express = require("express");
const cors = require("cors");
const app = express();
const port = 3000;

// Allow both local dev and production frontend URLs - will be dynamically configured
const allowedOrigins = [
  "http://localhost:5173", // browser running on host machine
  "http://frontend:5173", // frontend container in Docker
  "*", // Allow any origin for now
];

app.use(
  cors({
    origin: function (origin, callback) {
      // Allow requests with no origin (like curl or postman) or if origin is in the list
      if (!origin || allowedOrigins.includes(origin) || allowedOrigins.includes("*")) {
        callback(null, true);
      } else {
        callback(new Error("Not allowed by CORS"));
      }
    },
    credentials: true, // if you're sending cookies or auth headers
  })
);

// Regular API endpoint
app.get("/api", (req, res) => {
  res.json({
    message:
      "Hello from Express backend! This is terraform working correctly with updated readme",
  });
});

// Add health check endpoint
app.get("/api/health", (req, res) => {
  res.json({
    status: "ok",
    timestamp: new Date().toISOString()
  });
});

// Add info endpoint
app.get("/api/info", (req, res) => {
  res.json({
    version: process.env.VERSION || "1.0.0",
    environment: process.env.NODE_ENV || "development",
    uptime: process.uptime()
  });
});

app.listen(port, "0.0.0.0", () => {
  console.log(`✅ Backend listening at http://0.0.0.0:${port}`);
});
