require('dotenv').config();
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require('body-parser');
const cors = require('cors');
const authRouter = require('./routes/auth');
const docRouter = require('./routes/document');

const PORT = process.env.PORT || 3001;
const app = express();

mongoose.connect(process.env.DB).then((data)=>{
console.log("Connection successful");
}).catch((err)=>{
    console.log(err);
});

app.use(cors());
app.use(bodyParser.json());
app.use(authRouter);
app.use(docRouter);
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connected at PORT ${PORT}`)
});