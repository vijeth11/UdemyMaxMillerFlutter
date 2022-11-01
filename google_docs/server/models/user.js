const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name:{
        type: String,
        required: true,
    },
    email:{
        type: String,
        required: true,
    },
    profilePic:{
        type:String,
    },
});

const User = mongoose.model("User", userSchema);

module.exports = User;