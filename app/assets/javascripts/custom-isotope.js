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
	
	$(".promoted").on( {
		click      : function(e) {
				// if an old object was full sized, shrink it to normal
				if (prev_obj != null) {	
		    	$(prev_obj).toggleClass('gigante');			
					$preview_div = $(prev_obj).children("div.preview-on-hover");
					$preview_div.slideDown(1);
			 		$content_div = $(prev_obj).children("div.story-content");
					$content_div.slideUp(1);										
					prev_obj = null;
				}
				var obj = "#story" + $(this).attr("data-item-id");
			  var $obj = $( obj );
				$obj.toggleClass("gone");		
				// change size of item by toggling gigante class
				$obj.toggleClass('gigante');
				$preview_div = $obj.children("div.preview-on-hover");
				$preview_div.slideUp(1);
				$content_div = $obj.children("div.story-content");
				$content_div.slideDown(1);			
//				prev_obj = $obj.get(0); // refer back to the actual obj
				prev_obj = $obj;
				e.stopImmediatePropagation();
				// isotope needs to relayout the items
				$container.isotope('layout');							 	
			}
	});
			
	$(".category-control").on({
			click					: function(e) {
				id = $(this).attr("data-control-id");
				item = $(this).attr("data-item");
				target_id =  item + id;
				$("#material"+id+">div").slideUp(1);
				$("#"+target_id).slideDown(1);
				e.preventDefault();				
				e.stopImmediatePropagation();				
			}
	});
	
	$(".story").on({
	    mouseenter : function() {
				if (!$(this).hasClass('gigante')) {
	        $(this).addClass("hover");
		    /*	$container.isotope('layout');*/
				}
	    },
	    mouseleave : function() {
				if (!$(this).hasClass('gigante')) {
	        $(this).removeClass("hover");
//		    	$container.isotope('layout');
				}
	    },
	    click      : function() {
				if (this !== prev_obj) {
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
					prev_obj = this;

					// isotope needs to relayout the items
			    $container.isotope('layout');					
				}
	    }
	});		
	
	$(".exit").on( {
	  mouseenter : function() {
			$(".story").off("click");
		},
		click      : function(e) {
				// if an old object was full sized, shrink it to normal
				if (prev_obj != null) {	
		    	$(prev_obj).toggleClass('gigante');			
					$preview_div = $(prev_obj).children("div.preview-on-hover");
					$preview_div.slideDown(1);
			 		$content_div = $(prev_obj).children("div.story-content");
					$content_div.slideUp(1);										
					if ($(prev_obj).hasClass("promote")) {
						$(prev_obj).toggleClass("gone");
					}
					prev_obj = null;					
					// isotope needs to relayout the items
			    $container.isotope('layout');
					e.stopImmediatePropagation();
					$(".story").on("click", function() {
						if (this !== prev_obj) {
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
							prev_obj = this;

							// isotope needs to relayout the items
					    $container.isotope('layout');					
						}
			    });
			
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
		// activate media plugin on all video links
		$('a.media').media({width: 640, bgColor: "#E5E4E0"});       
});