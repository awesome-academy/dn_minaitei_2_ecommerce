document.addEventListener("turbo:load", function() {
  var toastElements = document.querySelectorAll('.toast');
  toastElements.forEach(function(toastElement) {
    var toast = new bootstrap.Toast(toastElement);
    toast.show();
  });
});
