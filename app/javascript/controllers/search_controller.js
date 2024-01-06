import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    let timer;
    const waitTime = 100;
    const messageInput = document.getElementById('search-field');


    messageInput.addEventListener('keyup', event => {
      event.preventDefault();
      clearTimeout(timer);

      timer = setTimeout(() => {
        doneTyping(event.target.value);
        sendSearchRequest(event.target.value);
      }, waitTime);
    });

    function doneTyping(value) {
      console.log(`The user is done typing: ${value}`);
    }

    function sendSearchRequest(value) {
      fetch('/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ query: value })
      }).then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html))
    }
  }
}
