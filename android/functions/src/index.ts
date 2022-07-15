// source: https://firebasetutorials.com/firebase-cloud-function-notify/#Step_4_8211_Write_Function

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);
exports.sendNotification =
    functions.firestore.document("order/{oid}").onWrite((event)=>{
      const title=event.after.get("firstName");
      const body=event.after.get("secondName");
      const payload={
        notification: {
          title: title,
          body: body,
        },
      };
      const topics = "order";
      return admin.messaging().sendToTopic(topics, payload).then((res)=>{
        console.log("notification sent ");
      }).catch((err)=>{
        console.log("notification sent "+err);
      });
    });
