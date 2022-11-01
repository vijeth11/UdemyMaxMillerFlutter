const express = require("express");
const User = require("../models/user");
const jwt = require('jsonwebtoken');
const auth = require("../middleware/auth");
const router = express.Router();

router.post('/api/signup', async (req,res)=>{
    try{
        const {name, email, profilePic} = req.body;
        let user = await User.findOne({email: email});
        if(!user){
            user = User({
                email:email,
                name:name,
                profilePic:profilePic
            });
            user = await user.save();
        }
    // "passwordKey" is a key used to sign the token same thing should be used for verifying as well.
    const token = jwt.sign({id:user._id},"passwordKey"); 
    return res.status(200).json({user,token});
    }catch(e){
        return res.status(500).json({error:e.message});
    }
})

router.get('/',auth,async (req,res,next)=>{
    const user = await User.findById(req.userId);
    res.json({user, token: req.token});
})

module.exports = router;