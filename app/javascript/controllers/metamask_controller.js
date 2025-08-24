import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"

// Turbo.visit(window.location.href, { action: "replace" })
// Connects to data-controller="metamask"
export default class extends Controller {
  static targets = ["content", "login", "address", "form"]

  connect() {
    if (!window.ethereum) return;
    if (!window.ethereum.isMetaMask) return;

    let metamask_account = Cookies.get('metamask_account')

    const contentEl = this.contentTarget
    const loginEl = this.loginTarget

    if (metamask_account) {
      if (this.hasAddressTarget) {
        let addressEl = this.addressTarget
        addressEl.textContent = metamask_account
      }

      if (this.hasFormTarget) {
        let formHiddenEl = this.formTarget
        formHiddenEl.value = metamask_account
      }
    } else {
      contentEl.classList.add('hidden')
      loginEl.classList.remove('hidden')
      loginEl.innerHTML = `
        <p>Metamask Login Required</p>
        <button data-action="click->metamask#login">Login</button>
      `
    }

    if (!this.isListening) {
      document.addEventListener("metamask-login", () => this.loginEvent())
      document.addEventListener("metamask-logout", () => this.logoutEvent())
      this.isListening = true
    }
  }

  disconnect() {
    if (this.isListening) {
      document.removeEventListener("metamask-login", () => this.loginEvent())
      document.removeEventListener("metamask-logout", () => this.logoutEvent())
      this.isListening = false
    }
  }

  loginEvent() {
    let contentEl = this.contentTarget

    if (contentEl.classList.contains("hidden")) {
      let loginEl = this.loginTarget
      let account = Cookies.get('metamask_account')

      if (this.hasAddressTarget) {
        let addressEl = this.addressTarget
        addressEl.textContent = account
      }

      if (this.hasFormTarget) {
        let formHiddenEl = this.formTarget
        formHiddenEl.value = account
      }

      contentEl.classList.remove("hidden")
      loginEl.classList.add("hidden")
    }
  }

  logoutEvent() {
    let contentEl = this.contentTarget

    if (!contentEl.classList.contains("hidden")) {
      let loginEl = this.loginTarget

      contentEl.classList.add('hidden')
      loginEl.classList.remove('hidden')
      loginEl.innerHTML = `
        <p>Metamask Login Required</p>
        <button data-action="click->metamask#login">Login</button>
      `

      if (this.hasAddressTarget) {
        let addressEl = this.addressTarget
        addressEl.textContent = ""
      }
    }
  }

  async login() {
    if (!window.ethereum) return;
    if (!window.ethereum.isMetaMask) return;

    const contentEl = this.contentTarget
    const loginEl = this.loginTarget

    await window.ethereum.request({ method: "eth_requestAccounts" })
    let accounts = await window.ethereum.request({ method: "eth_accounts" })
    let account = accounts[0]

    Cookies.set("metamask_account", account, {
      // expire expects days
      expires: 1 / 12, // half a day
      path: "/" // Cookie available site-wide
    })

    if (contentEl.classList.contains("hidden")) {
      if (this.hasAddressTarget) {
        let addressEl = this.addressTarget
        addressEl.textContent = account
      }

      if (this.hasFormTarget) {
        let formHiddenEl = this.formTarget
        formHiddenEl.value = account
      }

      contentEl.classList.remove("hidden")
      loginEl.classList.add("hidden")
    }

    document.dispatchEvent(new CustomEvent("metamask-login"))
  }

  logout() {
    const contentEl = this.contentTarget
    const loginEl = this.loginTarget

    Cookies.remove('metamask_account')

    contentEl.classList.add('hidden')
    loginEl.classList.remove('hidden')
    loginEl.innerHTML = `
      <p>Metamask Login Required</p>
      <button data-action="click->metamask#login">Login</button>
    `

    if (this.hasAddressTarget) {
      let addressEl = this.addressTarget
      addressEl.textContent = ""
    }

    document.dispatchEvent(new CustomEvent("metamask-logout"))
  }
}
