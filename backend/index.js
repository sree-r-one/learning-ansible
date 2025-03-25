const express = require("express");
const cors = require("cors"); // 🧩 Import CORS
const app = express();
const port = 3000;

// 🌐 Enable CORS for all origins (or restrict to frontend domain if needed)
app.use(
  cors({
    origin: "https://vite-container-frontend.azurewebsites.net", // ✅ safer than '*'
  })
);

app.get("/api", (req, res) => {
  res.json({ message: "Hello from Express backend!" }); // ✅ returns JSON
});

app.listen(port, () => {
  console.log(`Backend listening at http://localhost:${port}`);
});
