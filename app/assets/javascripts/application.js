document.addEventListener('DOMContentLoaded', function() {
  const dismissButtons = document.querySelectorAll('.dismiss-flash');

  dismissButtons.forEach(function(button) {
    button.addEventListener('click', function (e) {
      console.log('clicked');
      // const alert = e.target.parentElement;
      this.style.display = 'none';

       // Reload the page
        location.reload();
    });
  });
});
