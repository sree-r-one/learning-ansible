const express = require("express");
const cors = require("cors");
const app = express();
const port = 3000;

// Allow both local dev and production frontend URLs
const allowedOrigins = [
  "http://localhost:5173", // ✅ Local dev (from Docker/Vite)
  "https://vite-container-frontend.azurewebsites.net", // ✅ Azure deployed frontend
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
    message: "Hello from Express backend! This is terraform working correctly",
  });
});

app.listen(port, () => {
  console.log(`✅ Backend listening at http://localhost:${port}`);
});
