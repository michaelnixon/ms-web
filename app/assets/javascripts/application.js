// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require isotope.pkgd.min
//= require bootstrap.min
//= require bootsy
//= require turbolinks
//= require jquery.media
//= require_tree .
window.Bootsy.options.parserRules.tags.iframe=
{
  set_attributes: {
    "frameborder": "0",
    "allowfullscreen": "1",
    "webkitallowfullscreen": "1",
    "mozillaallowfullscreen": "1"
  },
  check_attributes: {
    "width": "numbers",
    "height": "numbers",
    "src": "href"
  }
};

window.Bootsy.options.parserRules.tags.table= 
{
	check_attributes: {
    "width": "numbers",
    "height": "numbers",
		"border": "numbers"

	}
}
window.Bootsy.options.parserRules.tags.tr= {}
window.Bootsy.options.parserRules.tags.td= 
{
	check_attributes: {
    "width": "numbers"
	}	
}