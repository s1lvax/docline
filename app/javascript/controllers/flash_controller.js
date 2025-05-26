import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message"];

  connect() {
    this.timeout = setTimeout(() => this.close(), 5000);
  }

  close() {
    this.messageTargets.forEach((el) => el.remove());
  }
}
