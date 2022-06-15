/*global $*/
document.addEventListener('turbolinks:load', () => {
    const dropDown = document.getElementById("nav-dropdown");

    
    $('#nav-dropdown').on('click', function() {
        $("#nav-menus").slideToggle();
        }).next().hide();
    });
  
  