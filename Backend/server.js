import express from "express";
import fetch from "node-fetch";
import dotenv from "dotenv";


dotenv.config();

const app = express();
app.use(express.json());

// Test route
app.get("/", (req, res) => {
  res.send("Backend is working!");
});

// AI content route
app.post("/ai-content", async (req, res) => {
  const { topic } = req.body;

  if (!topic) return res.status(400).json({ error: "Missing topic" });
console.log("OpenAI key loaded:", process.env.OPENAI_KEY ? "yes" : " no");
  try {
    const response = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${process.env.OPENAI_KEY}`
      },
      body: JSON.stringify({
        model: "gpt-4",
        messages: [
          { role: "user", content: `Generate curriculum content for: ${topic}` }
        ],
        max_tokens: 500
      })
    });

    const data = await response.json();
    res.json(data);
  } catch (error) {
    console.error("OpenAI request error:", error);
    res.status(500).json({ error: "Failed to fetch AI content" });
  }
});

// Start server
const PORT = 3000;
app.listen(PORT, () => console.log(`Backend running on http://localhost:${PORT}`));