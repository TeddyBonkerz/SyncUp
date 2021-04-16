const form = document.querySelector('#authorize-form');
const yesButton = document.querySelector('.yes');
const noButton = document.querySelector('.no');

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
    } else {
        alert('Cannot find the email');

    }
}

yesButton.addEventListener('click', (e) => {
    e.preventDefault();
    let organizerId = form.organizerId.value;
    let meetingId = form.meetingId.value;
    let email = form.email.value;

    console.log(form.organizerId.value);
    console.log(form.meetingId.value);
    console.log(form.email.value);
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
});


noButton.addEventListener('click', (e) => {
    e.preventDefault();
    let organizerId = form.organizerId.value;
    let meetingId = form.meetingId.value;
    let email = form.email.value;

    console.log(form.organizerId.value);
    console.log(form.meetingId.value);
    console.log(form.email.value);
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



// form.addEventListener('submit', (e) => {
//     e.preventDefault();

//     let organizerId = form.organizerId.value;
//     let meetingId = form.meetingId.value;
//     let email = form.email.value;

//     console.log(form.organizerId.value);
//     console.log(form.meetingId.value);
//     console.log(form.email.value);

//     db.collection('users').doc(organizerId).collection('meeting').doc(meetingId).get().then((doc) => {
//         if (doc.exists) {
//             console.log("Document data:", doc.data().attendeeList);
//         } else {
//             // doc.data() will be undefined in this case
//             console.log("No such document!");
//         }
//     }).catch((error) => {
//         console.log("Error getting document:", error);
//     });

//     // console.log(meeting);
//     // form.organizerId.value = '';
//     // form.meetingId.value = '';
//     // form.email.value ='';
// });