importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyAOlnxd6SbQiegjFZ7Y238e9PVYKU_eauU",
    authDomain: "teamodafeminina-1a688.firebaseapp.com",
    databaseURL: "https://teamodafeminina-1a688-default-rtdb.firebaseio.com",
    projectId: "teamodafeminina-1a688",
    storageBucket: "teamodafeminina-1a688.appspot.com",
    messagingSenderId: "G-5JD42KGH13",
    appId: "1:394552781816:web:4da93ebd345ba846c3440d",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});