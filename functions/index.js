const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const familyChatTopic = "family";
const friendsChatTopic = "friends";
const messageDocsPathAfterTopic = "Messages/{messageId}";

const newChatMessageIconColor = "#9c27b0";
const ringtoneFile = "ringtone.mp3";

exports.notifyAboutNewFamilyMessage = functions.firestore
    .document(familyChatTopic + messageDocsPathAfterTopic)
    .onCreate((snap, _) => {
      const snapData = snap.data();

      return admin.messaging().send({
        notification: {
          title: snapData.creator.username,
          body: snapData.text,
        },
        android: {
          notification: {
            color: newChatMessageIconColor,
            sound: ringtoneFile,
            event_time: snapData.createdAt.toDate().toISOString(),
          },
        },
        topic: familyChatTopic,
      });
    });

exports.notifyAboutNewFriendsMessage = functions.firestore
    .document(friendsChatTopic + messageDocsPathAfterTopic)
    .onCreate((snap, _) => {
      const snapData = snap.data();

      return admin.messaging().send({
        notification: {
          title: snapData.creator.username,
          body: snapData.text,
        },
        android: {
          notification: {
            color: newChatMessageIconColor,
            sound: ringtoneFile,
            event_time: snapData.createdAt.toDate().toISOString(),
          },
        },
        topic: friendsChatTopic,
      });
    });
