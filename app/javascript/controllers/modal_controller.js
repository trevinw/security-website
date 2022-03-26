import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap";

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"];

  connect() {
    document.addEventListener('turbo:submit-end', this.handleSubmit);
  }

  disconnect() {
    document.removeEventListener('turbo:submit-end', this.handleSubmit);
  }

  show() {
    this.modal = new Modal(this.modalTarget);
    this.modal.show();
  }

  hide() {
    this.modal.hide();
    this.modal.dispose();
  }

  handleSubmit = (event) => {
    // Add toast handling here? So it doesn't show up when the button is clicked regardless
    if (event.detail.success) {
      this.hide();
    }
  }
}
