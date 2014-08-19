$( function() {
  var $current_id = "";

  var $container = $('#isotope').isotope({
    itemSelector: '.story',
    masonry: {
      columnWidth: 100
    }
  });

	$('.nav-items a').click(function(){
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
	
	$('.btn.expander').click(function(){
		$(this).parent().parent().toggleClass('full-gigante');
		$(this).children("span").toggleClass("glyphicon-plus-sign glyphicon-minus-sign");		
    $container.isotope('layout');
		return false;
	});
		
  $container.on( 'click', '.story', function() {
		$new_id = $( this ).attr('id');
		if ($new_id != $current_id) {
			if ($current_id != "") {
				// if there was an old id already open, hide its h2
				$( "#" + $current_id + ">div>h2" ).toggleClass('gone');	

				// if the old item was expanded, we need to make it small and switch the plus sign back
				if ($( "#"+$current_id ).hasClass('full-gigante')) {
					$( "#"+$current_id ).toggleClass('full-gigante');
					$( "#"+$current_id + ">div>button>span" ).toggleClass("glyphicon-plus-sign glyphicon-minus-sign");
				}
			
			}
		
			$current_id = $new_id;
			$( "#" + $current_id + ">div>h2" ).toggleClass('gone');				
		
	    // change size of item by toggling gigante class
	    $(".gigante").toggleClass('gigante');
	    $( this ).toggleClass('gigante');
	    $container.isotope('layout');
		}
  });

});

$(document).ready(function(){
  $('.carousel').carousel({
    interval: false
  });
});

$(document).ready(function () {
    $('.nav li a').click(function(e) {

        $('.nav li').removeClass('active');

        var $parent = $(this).parent();
        if (!$parent.hasClass('active')) {
            $parent.addClass('active');
        }
        e.preventDefault();
    });
});