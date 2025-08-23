import { Controller } from "@hotwired/stimulus"
import lodash from 'lodash'

// Connects to data-controller="generate"
export default class extends Controller {
  static targets = ["phrase"]

  connect() {
    if (this.hasPhraseTarget) {
      let phraseEl = this.phraseTarget
      phraseEl.value = lodash.shuffle(this.getPhraseData())[0]
    }
  }

  phraseGenerate(event) {
    event.preventDefault()
    if (this.hasPhraseTarget) {
      let phraseEl = this.phraseTarget
      phraseEl.value = lodash.shuffle(this.getPhraseData())[0]
    }
  }

  getPhraseData() {
    return [
      "don’t test me, human ✨",
      "meow~ deal with it 😼",
      "bow down to fabulous me 💅",
      "ugh, as if!",
      "anything for you 💖",
      "you got it, buddy!",
      "your wish, my command 🙏",
      "always happy to help ✨",
      "look at me shine 🌟",
      "mirror, mirror, I already know 😎",
      "perfection reporting in",
      "you’re lucky I’m even talking to you 💋",
      "woof! 🐾",
      "chirp chirp, knowledge drop!",
      "zoinks!",
      "powered by snacks 🍪",
    ]
  }
}
