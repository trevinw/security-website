import { Controller } from "@hotwired/stimulus"
import { Toast } from "bootstrap";

// Connects to data-controller="toast"
export default class extends Controller {
  static targets = ["toast"]

  connect() {
    this.toast = new Toast(this.toastTarget, { delay: 2000 });
    this.toastTarget.addEventListener('hidden.bs.toast', () => {
      this.toastTarget.innerText = '';
    });
  }

  show({ params: { message } }) {
    this.toastTarget.innerText = message;
    this.toast.show();
  }
}
