const express = require('express');
const auth = require('../middleware/auth');
const e = require('express');
const document = require('../models/document');
const router = express.Router();

router.post('/doc/create', auth, async (req,res,next)=>{
try {
    const {createdAt, } = req.body;
    let document = new document({
        uid: req.user, //added auth middelware
        title: 'Untitled Document',
        createdAt,
    });

    document = await document.save();
    res.json(document);
} catch (error) {
    res.status(500).json({error: e.message});
}
});

router.get('/doc/me',auth,async (req,res,next)=>{
    try {
        let documents = await document.find({uid:req.user});
        res.json(documents);
    } catch (error) {
        res.status(500).json({error: e.message});
    }
})
module.exports = router;