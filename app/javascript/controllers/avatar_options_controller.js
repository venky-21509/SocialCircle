import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.setupEventListeners()
  }

  setupEventListeners() {
    const avatarOverlay = document.getElementById("avatar-overlay")
    const cameraBtn = document.getElementById("camera-btn")
    const fileUploadBtn = document.getElementById("file-upload-btn")
    const modalCloseBtn = document.getElementById("modal-close-btn")
    const avatarModal = document.getElementById("avatarOptionsModal")
    const cameraInput = document.getElementById("hidden-camera-input")
    const fileInput = document.getElementById("hidden-file-input")

    // Open modal when clicking on avatar
    if (avatarOverlay) {
      avatarOverlay.addEventListener("click", () => this.openModal())
    }

    if (cameraBtn) {
      cameraBtn.addEventListener("click", () => this.openCamera())
    }

    if (fileUploadBtn) {
      fileUploadBtn.addEventListener("click", () => this.openFileUpload())
    }

    if (modalCloseBtn) {
      modalCloseBtn.addEventListener("click", () => this.closeModal())
    }

    // Close modal when clicking outside
    if (avatarModal) {
      avatarModal.addEventListener("click", (e) => {
        if (e.target === avatarModal) {
          this.closeModal()
        }
      })
    }

    if (cameraInput) {
      cameraInput.addEventListener("change", (e) => this.handleCameraCapture(e))
    }

    if (fileInput) {
      fileInput.addEventListener("change", (e) => this.handleFileUpload(e))
    }
  }

  openModal() {
    const avatarModal = document.getElementById("avatarOptionsModal")
    if (avatarModal) {
      avatarModal.style.display = "block"
    }
  }

  closeModal() {
    const avatarModal = document.getElementById("avatarOptionsModal")
    if (avatarModal) {
      avatarModal.style.display = "none"
    }
  }

  openCamera() {
    this.closeModal()
    const cameraInput = document.getElementById("hidden-camera-input")
    if (cameraInput) {
      cameraInput.setAttribute("capture", "environment")
      cameraInput.click()
    }
  }

  openFileUpload() {
    this.closeModal()
    const fileInput = document.getElementById("hidden-file-input")
    if (fileInput) {
      fileInput.removeAttribute("capture")
      fileInput.click()
    }
  }

  handleCameraCapture(event) {
    const file = event.target.files[0]
    if (file) {
      this.redirectToEditAndUpload(file)
    }
  }

  handleFileUpload(event) {
    const file = event.target.files[0]
    if (file) {
      this.redirectToEditAndUpload(file)
    }
  }

  redirectToEditAndUpload(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      // Store file data in sessionStorage
      sessionStorage.setItem("pendingAvatarFile", e.target.result)
      sessionStorage.setItem("pendingAvatarFileName", file.name)
      
      // Redirect to edit profile page
      window.location.href = "/users/edit"
    }
    reader.readAsDataURL(file)
  }
}
