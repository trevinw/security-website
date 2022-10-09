import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="delivery"
export default class extends Controller {
  static targets = [
    'chemicalDeliverySelect',
    'chemicalTypeSelect',
    'destinationSelect',
    'destinationTextField',
    'destinationMessage',
    'chemicalTypeSelect',
    'chemicalTypeTextField',
    'chemicalMessage',
    'contactSelect',
    'contactTextField',
    'contactMessage'
  ]

  connect() {
    const noticeAlert = document.getElementById('notice-alert')

    if (noticeAlert) {
      setTimeout(() => {
        noticeAlert.remove()
      }, 2000)
    }
  }

  disableChemicalTypeSelect() {
    if (this.chemicalDeliverySelectTarget.value === 'true') {
      this.chemicalTypeSelectTarget.disabled = false
    } else if (this.chemicalDeliverySelectTarget.value === 'false') {
      this.chemicalTypeSelectTarget.disabled = true
      this.chemicalTypeSelectTarget.value = 'N/A'
    }
  }

  toggleDestinationTextInput() {
    if (this.destinationSelectTarget.value === 'Other') {
      this.destinationTextFieldTarget.disabled = false
      this.setDestinationMessage('Type a custom Destination below')
    } else {
      this.destinationTextFieldTarget.disabled = true
      this.setDestinationMessage('Select a Destination below, or select Other to type a custom Destination')
    }
  }

  toggleDestinationSelect() {
    if (this.destinationTextFieldTarget.value === '') {
      this.destinationSelectTarget.disabled = false
    } else {
      this.destinationSelectTarget.disabled = true
    }
  }

  toggleChemicalTextInput() {
    if (this.chemicalTypeSelectTarget.value === 'Other') {
      this.chemicalTypeTextFieldTarget.disabled = false
      this.setChemicalMessage('Type a custom Chemical below')
    } else {
      this.chemicalTypeTextFieldTarget.disabled = true
      this.setChemicalMessage('Select a Chemical below, or select Other to type a custom Chemical')
    }
  }

  toggleChemicalSelect() {
    if (this.chemicalTypeTextFieldTarget.value === '') {
      this.chemicalTypeSelectTarget.disabled = false
    } else {
      this.chemicalTypeSelectTarget.disabled = true
    }
  }

  toggleContactTextInput() {
    if (this.contactSelectTarget.value === 'Other') {
      this.contactTextFieldTarget.disabled = false
      this.setContactMessage('Type a custom SEH Contact below')
    } else {
      this.contactTextFieldTarget.disabled = true
      this.setContactMessage('Select an SEH Contact below, or select other to type a custom SEH Contact')
    }
  }

  toggleContactSelect() {
    if (this.contactTextFieldTarget.value === '') {
      this.contactSelectTarget.disabled = false
    } else {
      this.contactSelectTarget.disabled = true
    }
  }

  setDestinationMessage(message) {
    this.destinationMessageTarget.innerText = message
  }

  setChemicalMessage(message) {
    this.chemicalMessageTarget.innerText = message
  }

  setContactMessage(message) {
    this.contactMessageTarget.innerText = message
  }
}
