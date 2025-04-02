const express = require("express");
const cors = require("cors");
const app = express();
const port = 3000;

// Allow both local dev and production frontend URLs
const allowedOrigins = [
  "http://localhost:5173", // browser running on host machine
  "http://frontend:5173", // frontend container in Docker
  "http://206.189.32.244:5173", // public IP of the host machine
];

app.use(
  cors({
    origin: function (origin, callback) {
      // Allow requests with no origin (like curl or postman) or if origin is in the list
      if (!origin || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error("Not allowed by CORS"));
      }
    },
    credentials: true, // if you're sending cookies or auth headers
  })
);

app.get("/api", (req, res) => {
  res.json({
    message:
      "Hello from Express backend! This is terraform working correctly with updated readme",
  });
});

// app.listen(port, () => {
//   console.log(`✅ Backend listening at http://localhost:${port}`);
// });

app.listen(port, "0.0.0.0", () => {
  console.log(`✅ Backend listening at http://0.0.0.0:${port}`);
});
