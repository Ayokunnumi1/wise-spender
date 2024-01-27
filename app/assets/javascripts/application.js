$(document).ready(function() {
  const dismissButtons = document.querySelectorAll('.dismiss-flash');

    dismissButtons.forEach(function (button) {
      console.log('clicked');
    button.addEventListener('click', function () {
      this.parentElement.style.display = 'none';
      location.reload();
    });
  });
});