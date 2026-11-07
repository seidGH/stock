const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(cors());

// Health check endpoint for Kubernetes probes
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP', timestamp: new Date() });
});

// Sample API route
app.get('/api/stock', (req, res) => {
  res.json({ message: 'Welcome to Seya Stock Mobile Spare Parts API' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Backend server running on port ${PORT}`);
});
