
// Store local and remote peers
let localPeer = null;
let remotePeer = null;

// Handle incoming WebSocket messages
chatSocket.onmessage = function(e) {
    const data = JSON.parse(e.data);
    const messageType = data.type;
    const message = data.message;

    switch (messageType) {
        case 'offer':
            handleOffer(message);
            break;
        case 'answer':
            handleAnswer(message);
            break;
        case 'ice_candidate':
            handleIceCandidate(message);
            break;
    }
};

// Function to handle WebRTC offer
function handleOffer(offer) {
    // Create a new RTCPeerConnection
    remotePeer = new RTCPeerConnection();

    // Set the remote description with the received offer
    remotePeer.setRemoteDescription(new RTCSessionDescription(offer));

    // Create an answer and send it back to the server
    remotePeer.createAnswer()
        .then(answer => {
            return remotePeer.setLocalDescription(answer);
        })
        .then(() => {
            sendSignal('answer', remotePeer.localDescription);
        });

    // Handle ICE candidates
    remotePeer.onicecandidate = function(event) {
        if (event.candidate) {
            sendSignal('ice_candidate', event.candidate);
        }
    };

    // Handle incoming media stream
    remotePeer.ontrack = function(event) {
        const remoteVideo = document.getElementById('remoteVideo');
        remoteVideo.srcObject = event.streams[0];
    };
}

// Function to handle WebRTC answer
function handleAnswer(answer) {
    if (localPeer) {
        localPeer.setRemoteDescription(new RTCSessionDescription(answer));
    }
}

// Function to handle ICE candidates
function handleIceCandidate(candidate) {
    if (localPeer) {
        localPeer.addIceCandidate(new RTCIceCandidate(candidate));
    }
}

// Function to send WebRTC signaling data to the server
function sendSignal(type, message) {
    chatSocket.send(JSON.stringify({
        type: type,
        message: message
    }));
}

// Function to start the video call
function startCall() {
    // Create a new RTCPeerConnection
    localPeer = new RTCPeerConnection();

    // Get the user's media stream
    navigator.mediaDevices.getUserMedia({ video: true, audio: true })
        .then(stream => {
            const localVideo = document.getElementById('localVideo');
            localVideo.srcObject = stream;

            // Add the media stream tracks to the peer connection
            stream.getTracks().forEach(track => {
                localPeer.addTrack(track, stream);
            });

            // Create an offer and send it to the server
            localPeer.createOffer()
                .then(offer => {
                    return localPeer.setLocalDescription(offer);
                })
                .then(() => {
                    sendSignal('offer', localPeer.localDescription);
                });

            // Handle ICE candidates
            localPeer.onicecandidate = function(event) {
                if (event.candidate) {
                    sendSignal('ice_candidate', event.candidate);
                }
            };
        });
}

// Attach event listener to the start call button
document.getElementById('startCall').addEventListener('click', startCall);
