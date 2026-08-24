import { Controller } from "@hotwired/stimulus"

const STEPS = [
  { scene: "idle", caption: "The square, newest first." },
  { scene: "follow", caption: "Lena followed Maya." },
  { scene: "post", caption: "Maya posted to the square." },
  { scene: "like", caption: "Arjun, Theo, and Priya liked it." },
  { scene: "comment", caption: "Arjun replied — live, no page reload." },
  { scene: "message", caption: "Maya messaged Arjun in a direct thread." }
]

export default class extends Controller {
  static targets = ["caption", "stage"]
  static values = { interval: { type: Number, default: 2400 } }

  connect() {
    this.index = 0
    this.apply()
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return
    this.timer = window.setInterval(() => this.next(), this.intervalValue)
  }

  disconnect() {
    if (this.timer) window.clearInterval(this.timer)
  }

  next() {
    this.index = (this.index + 1) % STEPS.length
    this.apply()
  }

  apply() {
    const step = STEPS[this.index]
    this.stageTarget.dataset.scene = step.scene
    this.captionTarget.textContent = step.caption
  }
}
