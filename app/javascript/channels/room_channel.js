import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log("Hi there its room channel")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
     console.log(data)
    var node = document.createElement("P"); 

    var textnode = document.createTextNode(data.content.message); 

    node.appendChild(textnode); 

    document.getElementById("new_message").appendChild(node);
    document.getElementById('chat_message').value= ''
    // Called when there's incoming data on the websocket for this channel
  }
});
