const functions = require("firebase-functions");
const admin = require('firebase-admin');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
admin.initializeApp();
exports.myFunction = functions.firestore
.document('chat/{message}')
.onCreate((change, context) => { 
  console.log();
  let data = change.data()
  admin.messaging().sendToTopic('chat',{
    notification:{
        title:data.userName,
        body:data.text
    }
});
  return;
});
