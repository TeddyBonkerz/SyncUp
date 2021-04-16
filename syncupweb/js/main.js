const firebase = require("firebase/app");
require("firebase/firestore");

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
var firebaseConfig = {
    apiKey: "AIzaSyAb0PE7nlKlJNQ9uDD34Sxs8CzDTAGs3Ts",
    authDomain: "syncup-4cda3.firebaseapp.com",
    databaseURL: "https://syncup-4cda3-default-rtdb.firebaseio.com",
    projectId: "syncup-4cda3",
    storageBucket: "syncup-4cda3.appspot.com",
    messagingSenderId: "565678383112",
    appId: "1:565678383112:web:ce7afc4a6490ffab00f1bd",
    measurementId: "G-7MLP9K6VRL"
};

firebase.initializeApp(firebaseConfig);
const database = firebase.firestore();


const organizerId = document.getElementById("organizer-id").value;
const meetingId = document.getElementById("meeting-id").value;
const email = document.getElementById("email").value;

//For Testing
// const organizerId = "4iOHIovYTBaglQW0bnYnMSC3vm02";
// const meetingId = "HPs2ADDsNHEXIuc236wS";
// const email = "rtihdfh@gmail.com";

const meetingRef = database.collection("users").doc(organizerId).collection("meeting").doc(meetingId);

function checkAttendee() {
    meetingRef.onSnapshot((doc) => {
        if (!doc.exists) return;
        var length = doc.data()['attendeeList'].length
        for (var i = 0; i < length; i++) {
            var attendee = doc.data()['attendeeList'][i]['email'];
            if (attendee == email) {
                console.log(doc.data()['attendeeList'][i]['email']);
                //location.href = "attendee_response.html"
            }
        }
    });
}

function setResponse() {
    meetingRef.where()
        .update({ attendeeList: [{ email: email, response: true }] })
        .then(() => {
            console.log("Document updated"); // Document updated
        })
        .catch((error) => {
            console.error("Error updating doc", error);
        });

}

//checkAttendee();
setResponse();