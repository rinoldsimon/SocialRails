import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  count() {
    const max = this.element.maxLength
    if (!max || max < 0) return
    this.element.dataset.count = `${this.element.value.length}/${max}`
  }
}
