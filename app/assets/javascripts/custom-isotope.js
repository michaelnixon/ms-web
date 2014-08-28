$( function() {
  var prev_obj = null;
  var $container = $('#isotope').isotope({
		layoutMode: 'fitRows',
    itemSelector: '.story',
  });
	// controls the filtering
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
		
	$(".story").on({
	    mouseenter : function() {
				if (!$(this).hasClass('gigante')) {
	        $(this).addClass("hover");
		    	$container.isotope('layout');
				}
	    },
	    mouseleave : function() {
				if (!$(this).hasClass('gigante')) {
	        $(this).removeClass("hover");
		    	$container.isotope('layout');
				}
	    },
	    click      : function() {
	        if(this !== prev_obj) {
						// if an old object was full sized, shrink it to normal
						if (prev_obj != null) {	
				    	$(prev_obj).toggleClass('gigante');			
							$preview_div = $(prev_obj).children("div.preview-on-hover");
							$preview_div.slideDown(1);
					 		$content_div = $(prev_obj).children("div.story-content");
							$content_div.slideUp(1);										
						} 	
						
		        var $obj = $(this);
						$obj.removeClass("hover");		
				    // change size of item by toggling gigante class
				    $obj.toggleClass('gigante');
						$preview_div = $obj.children("div.preview-on-hover");
						$preview_div.slideUp(1);
				 		$content_div = $obj.children("div.story-content");
						$content_div.slideDown(1);
						// isotope needs to relayout the items
				    $container.isotope('layout');					
						// record the new previous object for next click 
						prev_obj = this;						
	        } 
	    }
	});		

});

// sets up the carousels for each of the items
$(document).ready(function(){
  $('.carousel').carousel({
    interval: false
  });
});

// controls changing the active class on nav links so that the currently selected one is underlined
$(document).ready(function () {
    $('.nav-items li a').click(function(e) {

        $('.active').removeClass('active');

        var $parent = $(this).parent();
        if (!$parent.hasClass('active')) {
            $parent.addClass('active');
        }
        e.preventDefault();
    });

    $('.nav_elem').click(function(e) {
				$.ajax({url: "pages/change_subnav", type: "GET", data: {id: $(this).attr("data-id")}});
        e.preventDefault();
    });

});