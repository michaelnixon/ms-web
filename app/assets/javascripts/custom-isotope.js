$( function() {

  var $container = $('#isotope').isotope({
    itemSelector: '.story',
    masonry: {
      columnWidth: 100
    }
  });

	$('.nav a').click(function(){
		var selector = $(this).attr('data-filter');
		$container.isotope({ 
		filter: selector,
		animationOptions: {
 			duration: 750,
     		easing: 'linear',
     		queue: false,
 		}
		});
		return false;
	});
	
	$('.btn').click(function(){
		$(this).parent().toggleClass('full-gigante');
    $container.isotope('layout');
		$(this).children("span").toggleClass("glyphicon-plus-sign glyphicon-minus-sign");
		return false;
	});
		
  $container.on( 'click', '.story', function() {
    // change size of item by toggling gigante class
    $(".gigante").toggleClass('gigante');
    $( this ).toggleClass('gigante');
    $container.isotope('layout');
  });

});

$(document).ready(function(){
  $('.carousel').carousel({
    interval: false
  });
});