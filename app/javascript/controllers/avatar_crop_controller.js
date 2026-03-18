import { Controller } from "@hotwired/stimulus"
import Cropper from "cropperjs"

export default class extends Controller {
  static targets = ["input", "image", "container"];
  
  cropper = null;

  connect() {
    this.inputTarget.addEventListener("change", this.handleFileSelect.bind(this));
    
    // Check for pending avatar file from modal
    this.loadPendingFile();
  }

  loadPendingFile() {
    const pendingFile = sessionStorage.getItem("pendingAvatarFile");
    const pendingFileName = sessionStorage.getItem("pendingAvatarFileName");
    
    if (pendingFile) {
      // Create a blob from the data URL
      const blob = this.dataURLtoBlob(pendingFile);
      
      // Create a File object
      const file = new File([blob], pendingFileName || "avatar.jpg", { type: blob.type });
      
      // Create a DataTransfer to set the file input
      const dataTransfer = new DataTransfer();
      dataTransfer.items.add(file);
      this.inputTarget.files = dataTransfer.files;
      
      // Simulate file selection
      this.loadCropperWithDataURL(pendingFile);
      
      // Clear session storage
      sessionStorage.removeItem("pendingAvatarFile");
      sessionStorage.removeItem("pendingAvatarFileName");
    }
  }

  dataURLtoBlob(dataURL) {
    const arr = dataURL.split(",");
    const mime = arr[0].match(/:(.*?);/)[1];
    const bstr = atob(arr[1]);
    let n = bstr.length;
    const u8arr = new Uint8Array(n);
    while (n--) {
      u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], { type: mime });
  }

  loadCropperWithDataURL(dataURL) {
    this.imageTarget.src = dataURL;
    this.containerTarget.style.display = "block";
    
    // Destroy existing cropper if any
    if (this.cropper) {
      this.cropper.destroy();
    }
    
    // Initialize cropper
    this.cropper = new Cropper(this.imageTarget, {
      aspectRatio: 1 / 1,
      viewMode: 0,
      autoCropArea: 0.6,
      responsive: true,
      guides: true,
      center: true,
      highlight: true,
      cropBoxMovable: true,
      cropBoxResizable: true,
      toggleDragModeOnDblclick: true,
      modal: true,
      background: true,
      zoomOnWheel: true,
      wheelZoomRatio: 0.1
    });
  }

  handleFileSelect(event) {
    const file = event.target.files[0];
    
    if (file && file.type.startsWith("image/")) {
      const reader = new FileReader();
      
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result;
        this.containerTarget.style.display = "block";
        
        // Destroy existing cropper if any
        if (this.cropper) {
          this.cropper.destroy();
        }
        
        // Initialize cropper
        this.cropper = new Cropper(this.imageTarget, {
          aspectRatio: 1 / 1, // Square aspect ratio for avatar
          viewMode: 0, // Display the full image in container
          autoCropArea: 0.6,
          responsive: true,
          guides: true,
          center: true,
          highlight: true,
          cropBoxMovable: true,
          cropBoxResizable: true,
          toggleDragModeOnDblclick: true,
          modal: true,
          background: true,
          zoomOnWheel: true,
          wheelZoomRatio: 0.1
        });
      };
      
      reader.readAsDataURL(file);
    }
  }

  cropImage() {
    if (this.cropper) {
      // Get the canvas with the cropped area
      const canvas = this.cropper.getCroppedCanvas({
        maxWidth: 4096,
        maxHeight: 4096,
        fillColor: "#fff",
        imageSmoothingEnabled: true,
        imageSmoothingQuality: "high"
      });
      
      // Convert canvas to blob and create a new file
      canvas.toBlob((blob) => {
        // Create a new File object from the blob
        const croppedFile = new File([blob], "avatar-cropped.png", { type: "image/png" });
        
        // Create a new DataTransfer object to update the file input
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(croppedFile);
        this.inputTarget.files = dataTransfer.files;
        
        // Hide cropper container
        this.containerTarget.style.display = "none";
        
        // Reset the form input label to show a cropped image preview
        const preview = this.inputTarget.parentElement.querySelector(".avatar-preview");
        if (preview) {
          preview.innerHTML = `<img src="${canvas.toDataURL()}" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; margin-top: 10px;">`;
        }
      });
    }
  }

  cancelCrop() {
    this.containerTarget.style.display = "none";
    this.inputTarget.value = "";
    
    if (this.cropper) {
      this.cropper.destroy();
      this.cropper = null;
    }
  }
}
