// MobileMenuController manages the visibility of the mobile menu panel.
// It ensures the menu is hidden on page load and provides methods to open and close it.
//
// @module MobileMenuController
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  /**
   * Defines the targets used by this controller.
   * @type {string[]}
   */
  static targets = ["panel"];

  /**
   * Called automatically when the controller connects to the DOM.
   * Hides the mobile menu panel initially.
   *
   * @return {void}
   */
  connect() {
    this.panelTarget.classList.add("hidden");
  }

  /**
   * Opens the mobile menu by removing the 'hidden' class from the panel.
   *
   * @return {void}
   */
  open() {
    this.panelTarget.classList.remove("hidden");
  }

  /**
   * Closes the mobile menu by adding the 'hidden' class to the panel.
   *
   * @return {void}
   */
  close() {
    this.panelTarget.classList.add("hidden");
  }
}
