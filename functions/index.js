const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationOnIncident = functions.database
  .ref('/incidents/{incidentId}')
  .onCreate(async (snapshot, context) => {
    const incidentData = snapshot.val();

    const tokensSnapshot = await admin.database().ref('users').once('value');
    const tokens = [];
    tokensSnapshot.forEach(userSnapshot => {
      const token = userSnapshot.child('deviceToken').val();
      if (token) {
        tokens.push(token);
      }
    });

    const payload = {
      notification: {
        title: 'New Incident Reported',
        body: `${incidentData.name} at ${incidentData.location}`,
      },
    };

    return admin.messaging().sendToDevice(tokens, payload);
  });
