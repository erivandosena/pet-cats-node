const express = require('express');
const axios = require('axios');
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const indexPage = `
    <h1>Hello from a Node.js Application running</h1>
    <p>What would you like to see?</p>
    <ul>
        <li>Random cats? <a href="/cat">Click here</a></li>
    </ul>
`;

app.get('/', (req, res) => res.send(indexPage));

app.get('/healthcheck', (req, res) => {
  try {
    res.sendStatus(204);
  } catch (error) {
    res.sendStatus(500);
  }
});

app.get('/cat', async (req, res) => {
  try {
    const response = await axios.get('https://cataas.com/cat');
    const catImage = response.request.res.responseUrl;
    const page = `<div style="text-align: center; margin: 20px;">
        <a href="/cat">Next Cat</a>
    </div>
    <div style="text-align: center;">
        <img src="${catImage}" alt="random cat" style="max-width: 500px" />
    </div>
    <div style="text-align: center; margin: 20px;">
        <a href="/">Let's Home</a>
    </div>`;
    res.send(page);
  } catch (error) {
    console.error(JSON.stringify(error));
    res.status(500);
    res.send(error.message);
  }
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});