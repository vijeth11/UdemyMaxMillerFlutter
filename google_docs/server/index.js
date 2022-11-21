require('dotenv').config();
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require('body-parser');
const cors = require('cors');
const http = require('http');
const authRouter = require('./routes/auth');
const docRouter = require('./routes/document');
const DocumentModel = require('./models/document');

const PORT = process.env.PORT || 3001;
const app = express();
var server = http.createServer(app);
var io = require('socket.io')(server);

mongoose.connect(process.env.DB).then((data)=>{
console.log("Connection successful");
}).catch((err)=>{
    console.log(err);
});

app.use(cors());
app.use(bodyParser.json());
app.use(authRouter);
app.use(docRouter);

io.on('connection',(socket) => {
    console.log("connected"+socket.id);
    socket.on('join',(documentId) => {
        socket.join(documentId);
        console.log('joined');
    });
    socket.on('typing',(data) => {
        socket.broadcast.to(data.room).emit('changes',data);
    })
    socket.on('save',(data) => {
        saveData(data);
    })
})


const saveData = async (data) => {
    let document = await DocumentModel.findById(data.docId);
    document.content = data.delta;
    document = await document.save();
}

server.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connected at PORT ${PORT}`)
});