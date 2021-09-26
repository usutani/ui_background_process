import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String,
    interval: Number
  }

  initialize() {
    this.intervalId = 0
  }

  connect() {
    this.startReloading()
  }

  disconnect() {
    this.stopReloading()
  }

  startReloading() {
    if (this.intervalId !== 0) {
      return
    }
    this.intervalId = setInterval(() => {
      if (this.canReload()) {
        this.updateElements()
      } else {
        this.stopReloading()
      }
    }, this.intervalValue);
  }

  updateElements() {
    fetch(this.urlValue, { headers: { 'Accept': 'text/vnd.turbo-stream.html' } })
      .then(response => response.text())
      .then(message => Turbo.renderStreamMessage(message))
      .catch (() => this.stopReloading())
  }

  canReload() {
    const reload = document.getElementById('reload').textContent
    return (reload === 'true')
  }

  stopReloading() {
    if (this.intervalId !== 0) {
      clearInterval(this.intervalId)
      this.intervalId = 0
    }
  }
}
