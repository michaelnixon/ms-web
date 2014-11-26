$( function() {
  var prev_obj = null;
  var $container = $('#isotope').isotope({
		layoutMode: 'fitRows',
    itemSelector: '.story',
  });				
	// initial filtering
	var selector = $('#home-nav').attr('data-filter');
	$container.isotope({ filter: selector });

	// controls the filtering
	$('.nav-items a').click(function(){
		if (prev_obj != null) {	
			shrinkBigOldObject();
			prev_obj = null;
		}
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
	
	function shrinkBigOldObject() {
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
		}		
	}

	function enlargeNewObject($obj) {
		// change size of item by toggling gigante class
	  $obj.toggleClass('gigante');
		$preview_div = $obj.children("div.preview-on-hover");
		$preview_div.slideUp(1);
		$content_div = $obj.children("div.story-content");
		$content_div.slideDown(1);			
	}
		
	$(".promoted").on( {
		click      : function(e) {
				shrinkBigOldObject();									
				prev_obj = null;
				var obj = "#story" + $(this).attr("data-item-id");
			  var $obj = $( obj );
				$obj.toggleClass("gone");		
				enlargeNewObject($obj);
				prev_obj = $obj;
				e.preventDefault();
				//e.stopImmediatePropagation();
				// isotope needs to relayout the items
				$container.isotope('layout');							 	
			}
	});
	
	function categoryControlOnClickHandler(e) {
		id = $(this).attr("data-control-id");
		item = $(this).attr("data-item");
		target_id =  item + id;
		$("#material"+id+">div").slideUp(1);
		$("#"+target_id).slideDown(1);
		e.preventDefault();				
		e.stopImmediatePropagation();		
	}
	
	function storyOnClickHandler() {
		if (this !== prev_obj) {
			shrinkBigOldObject();
      var $obj = $(this);
			$obj.removeClass("hover");		
			enlargeNewObject($obj);
			prev_obj = this;
			var request = $.ajax({url: "pages/change_focus", type: "GET", data: {id: $(this).attr("data-story-content-id")}});
			request.done(function( msg ) {
				$(".exit").on("click", exitOnClickHandler);			
				$(".category-control").on("click", categoryControlOnClickHandler);					
			});
			// isotope needs to relayout the items
	    $container.isotope('layout');					
		}    
	}
	
	function exitOnClickHandler(event) {
		// if an old object was full sized, shrink it to normal
		if (prev_obj != null) {	
			shrinkBigOldObject();
			prev_obj = null;					
			// isotope needs to relayout the items
	    $container.isotope('layout');
			event.stopImmediatePropagation();
			$(".story").on("click", storyOnClickHandler);
		}		
	}
		
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
	    click      : storyOnClickHandler
	});		
	
	$(".exit").on( {
	  mouseenter : function() {
			$(".story").off("click");
		},
		click      : exitOnClickHandler
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
		
		// sets up the carousels for each of the items
	  $('.carousel').carousel({
	    interval: false
	  });

		$(".story").each(function(index, value) {
			var numRand = Math.floor(Math.random() * 10 + 10);
			$(this).css('margin-right', numRand+"%");
			$(this).css('margin-bottom', numRand+"%");			
			$('#isotope').isotope('layout');							 	
		});
});
