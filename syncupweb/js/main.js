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

globalThis.organizerId;

function checkAttendee() {
    database = firebase.firestore();
    organizerId = document.getElementById("organizer-id").value;
    meetingId = document.getElementById("meeting-id").value;
    email = document.getElementById("email").value;

    const meetingRef = database.doc(`users/${organizerId}/meeting/${meetingId}`);


    //console.log("organ" + organizerId)
    meetingRef.onSnapshot((doc) => {
        if (!doc.exists) console.log("Aint here chief");
        var length = doc.data()['attendeeList'].length
        for (var i = 0; i < length; i++) {
            var attendee = doc.data()['attendeeList'][i]['email'];
            if (attendee == email) {
                console.log(doc.data()['attendeeList'][i]['email']);

                location.href = "attendee_response.html"
                loadResults()
            }
        }
    });
}

function loadResults() {

    const meetingRef = database.doc(`users/${organizerId}/meeting/${meetingId}`);
    meetingRef.onSnapshot((doc) => {
        if (!doc.exists) console.log("Aint here chief");
        console.log("Document data:", doc.data());
        document.getElementById("title").innerHTML = doc.data()['title']
        document.getElementById("content").innerHTML = doc.data()['content']
        document.getElementById("time").innerHTML = doc.data()['dateTime']
        document.getElementById("location").innerHTML = doc.data()['location']
    });
}

// function setResponse() {
//     meetingRef.where()
//         .update({ attendeeList: [{ email: email, response: true }] })
//         .then(() => {
//             console.log("Document updated"); // Document updated
//         })
//         .catch((error) => {
//             console.error("Error updating doc", error);
//         });

// }

// //checkAttendee();
// setResponse();