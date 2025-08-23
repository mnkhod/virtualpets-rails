import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"

// Turbo.visit(window.location.href, { action: "replace" })
// Connects to data-controller="metamask"
export default class extends Controller {
  static targets = ["content", "login", "address"]

  connect() {
    if (!window.ethereum) return;
    if (!window.ethereum.isMetaMask) return;

    let metamask_account = Cookies.get('metamask_account')

    const contentEl = this.contentTarget
    const loginEl = this.loginTarget
    const addressEl = this.addressTarget

    if (metamask_account) {
      if (addressEl) {
        addressEl.textContent = metamask_account
      }
    } else {
      contentEl.classList.add('hidden')
      loginEl.classList.remove('hidden')
      loginEl.innerHTML = `
        <p>Metamask Login Required</p>
        <button data-action="click->metamask#login">Login</button>
      `
    }
  }

  async login() {
    const contentEl = this.contentTarget
    const loginEl = this.loginTarget
    const addressEl = this.addressTarget

    await window.ethereum.request({ method: "eth_requestAccounts" })
    let accounts = await window.ethereum.request({ method: "eth_accounts" })
    let account = accounts[0]

    Cookies.set("metamask_account", account, {
      // expire expects days
      expires: 1 / 12, // half a day
      path: "/" // Cookie available site-wide
    })

    if (contentEl.classList.contains("hidden")) {
      if (addressEl) {
        addressEl.textContent = account
      }

      contentEl.classList.remove("hidden")
      loginEl.classList.add("hidden")
    }
  }

  logout() {
    const contentEl = this.contentTarget
    const loginEl = this.loginTarget
    const addressEl = this.addressTarget

    Cookies.remove('metamask_account')

    contentEl.classList.add('hidden')
    loginEl.classList.remove('hidden')
    loginEl.innerHTML = `
      <p>Metamask Login Required</p>
      <button data-action="click->metamask#login">Login</button>
    `

    if (addressEl) {
      addressEl.textContent = ""
    }
  }
}
