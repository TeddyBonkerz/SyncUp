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
const userId = firebase.auth().organizerId;
const meetingId = document.getElementById("meeting-id").value;
//var email = document.getElementById("email").value;

function checkAttendee() {
    console.log(userId);
    var result = database.collection('users').doc(userId).collection('meeting').doc(organizerId).get();
    window.alert(result.data());
    // .once("value")
    //     .then(function(snapshot) {
    //         const userData = snapshot.val();
    //         console.log("exists!", userData);
    //     });
};