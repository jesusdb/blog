import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to NotificationsChannel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from NotificationsChannel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Data received!");
    console.log("Data: ", data);
    // alert(data.message);
    document.getElementById('notifications-icon-container').innerHTML = '<i class="bi bi-app-indicator"></i>';
  }
});
