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
// firebase.analytics();
const db = firebase.firestore();
db.settings({timestampsInSnapshots: true});

// firebase.initializeApp(firebaseConfig);

// globalThis.organizerId;

const form = document.querySelector('.form');
const yesButton = document.querySelector('.yes');
const noButton = document.querySelector('.no');

let organizerId;
let meetingId;
let email;

function voteYes(meetingList,organizerId,meetingId,email){
    let attendeeArray = meetingList.filter( attendee => attendee.email == email);
    if(attendeeArray.length >= 1){
        let index = meetingList.findIndex((attendee) => attendee.email == email);
        console.log("index is", index);
        let attendee = {
            'email': email,
            'response': true
        }
        meetingList[index] = attendee;
        console.log(meetingList);
        console.log(organizerId);
        console.log(meetingId);

        db.collection('users').doc(organizerId).collection('meeting').doc(meetingId).update({
            attendeeList: meetingList,
        });
        form.organizerId.value = '';
        form.meetingId.value = '';
        form.email.value = '';
        alert('You voted YES');
        showOrHideDivResponse();
    } else {
        alert('Cannot find the email');
    }
}

function voteNo(meetingList,organizerId,meetingId,email){
    let attendeeArray = meetingList.filter( attendee => attendee.email == email);
    if(attendeeArray.length >= 1){
        let index = meetingList.findIndex((attendee) => attendee.email == email);
        console.log("index is", index);
        let attendee = {
            'email': email,
            'response': false
        }
        meetingList[index] = attendee;
        console.log(meetingList);
        console.log(organizerId);
        console.log(meetingId);

        db.collection('users').doc(organizerId).collection('meeting').doc(meetingId).update({
            attendeeList: meetingList,
        });
        form.organizerId.value = '';
        form.meetingId.value = '';
        form.email.value = '';
        alert('You voted NO');
        showOrHideDivResponse();

    } else {
        alert('Cannot find the email');

    }
}

yesButton.addEventListener('click', (e) => {
    e.preventDefault();

    db.collection('users').doc(organizerId).collection('meeting').doc(meetingId).get().then((doc) => {
        if (doc.exists) {
            console.log("Document data:", doc.data().attendeeList);
            voteYes(doc.data().attendeeList,organizerId,meetingId,email);
        } else {
            // doc.data() will be undefined in this case
            // console.log("No such document!");
            alert('Cannot find the meeting information');
        }
    }).catch((error) => {
        console.log("Error getting document:", error);
    });
})

noButton.addEventListener('click', (e) => {
    e.preventDefault();

    db.collection('users').doc(organizerId).collection('meeting').doc(meetingId).get().then((doc) => {
        if (doc.exists) {
            console.log("Document data:", doc.data().attendeeList);
            voteNo(doc.data().attendeeList,organizerId,meetingId,email);

        } else {
            // doc.data() will be undefined in this case
            // console.log("No such document!");
            alert('Cannot find the meeting information');

        }
    }).catch((error) => {
        console.log("Error getting document:", error);
    });
});


// function checkAttendee() {
//     database = firebase.firestore();
//     organizerId = document.getElementById("organizer-id").value;
//     meetingId = document.getElementById("meeting-id").value;
//     email = document.getElementById("email").value;

//     meetingRef = database.doc(`users/${organizerId}/meeting/${meetingId}`);


//     //console.log("organ" + organizerId)
//     meetingRef.onSnapshot((doc) => {
//         if (!doc.exists) console.log("Aint here chief");
//         var length = doc.data()['attendeeList'].length
//         for (var i = 0; i < length; i++) {
//             var attendee = doc.data()['attendeeList'][i]['email'];
//             if (attendee == email) {
//                 console.log(doc.data()['attendeeList'][i]['email']);
//                 loadResults()
//             }
//         }
//     });
// }

form.addEventListener('submit', (e) => {
    e.preventDefault();
    organizerId = form.organizerId.value;
    meetingId = form.meetingId.value;
    email = form.email.value;

    console.log(organizerId);
    console.log(meetingId);
    console.log(email);

    db.collection('users').doc(organizerId).collection('meeting').doc(meetingId).get().then((doc) => {
        if (doc.exists) {
            // console.log("Document data:", doc.data().attendeeList);
            // voteYes(doc.data().attendeeList,organizerId,meetingId,email);
            let meetingList = doc.data().attendeeList
            let attendeeArray = meetingList.filter( attendee => attendee.email == email);
            if(attendeeArray.length >= 1){
                loadResults();
            } else {
                alert('Cannot find the email');
            }
        } else {
            // doc.data() will be undefined in this case
            // console.log("No such document!");
            alert('Cannot find the meeting information');
        }
    }).catch((error) => {
        console.log("Error getting document:", error);
    });
    // database = firebase.firestore();
    // organizerId = document.getElementById("organizer-id").value;
    // meetingId = document.getElementById("meeting-id").value;
    // email = document.getElementById("email").value;

    // meetingRef = database.doc(`users/${organizerId}/meeting/${meetingId}`);


    // //console.log("organ" + organizerId)
    // meetingRef.onSnapshot((doc) => {
    //     if (!doc.exists) console.log("Aint here chief");
    //     var length = doc.data()['attendeeList'].length
    //     for (var i = 0; i < length; i++) {
    //         var attendee = doc.data()['attendeeList'][i]['email'];
    //         if (attendee == email) {
    //             console.log(doc.data()['attendeeList'][i]['email']);
    //             loadResults()
    //         }
    //     }
    // });
})

function loadResults() {
    // database = firebase.firestore();
    // organizerId = "4iOHIovYTBaglQW0bnYnMSC3vm02";
    // meetingId = "HPs2ADDsNHEXIuc236wS";
    // email = "rtihdfh@gmail.com";
    showOrHideDiv()

    meetingRef = db.doc(`users/${organizerId}/meeting/${meetingId}`);

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
//     meetingRef
//         .update({ attendeeList: [{ email: email, response: true }] })
//         .then(() => {
//             console.log("Document updated"); // Document updated
//         })
//         .catch((error) => {
//             console.error("Error updating doc", error);
//         });

// }

function showOrHideDiv() {
    var x = document.getElementsByClassName("container")[0].style.display = "none";
    var y = document.getElementsByClassName("resp-container")[0].style.display = "block";;
}

function showOrHideDivResponse() {
    var x = document.getElementsByClassName("container")[0].style.display = "block";
    var y = document.getElementsByClassName("resp-container")[0].style.display = "none";;
}


