const jwt = require('jsonwebtoken');

const auth = async (req,res,next)=>{
    try{
        const token = req.header("x-auth-token");
        if(!token){
            return res.status(401).json({error:'No auth token access denied'});
        }
        const verified = jwt.verify(token,"passwordKey");
        if(!verified){
            return res.status(401).json({error:'Token verification failed try again later'});
        }
        req.userId = verified.id;
        req.token = token;
        return next();
    }catch(e){
        return res.status(500).json({error: e.message});
    }
}

module.exports = auth;