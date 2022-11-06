const express = require('express');
const auth = require('../middleware/auth');
const DocumentModel = require('../models/document');
const router = express.Router();

router.post('/doc/create', auth, async (req,res,next)=>{
try {
    const {createdAt, } = req.body;
    console.log(req.userId);
    let document = new DocumentModel({
        uid: req.userId, //added auth middelware
        title: 'Untitled Document',
        createdAt,
    });

    document = await document.save();
    res.json(document);
} catch (error) {
    res.status(500).json({error: error.message});
}
});

router.post('/doc/add', auth, async(req,res,next) => {
    const {docId,} = req.body;    
    try {
        let document = await DocumentModel.findById(docId);
        let documents = await DocumentModel.find({uid:req.userId});
        documents = [...documents,document];
        console.log(documents);
        res.json({documents});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

router.post('/doc/title', auth, async (req,res,next)=>{
try {
    const {id, title } = req.body;
    await DocumentModel.findByIdAndUpdate(id, {title});
    let document = await DocumentModel.findById(id);
    console.log(document);
    res.json(document);
} catch (error) {
    res.status(500).json({error: error.message});
}
});

router.get('/doc/me',auth,async (req,res,next)=>{
    try {
        let documents = await DocumentModel.find({uid:req.userId});
        res.json({documents});
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})
module.exports = router;