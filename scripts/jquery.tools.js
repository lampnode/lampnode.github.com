$(document).ready(function(){
  $('.jt_authorEmail').html(function(){
	var e = "robert.c";
	var a = "@";
	var d = "lampnode";
	var c = ".com";
	var h = 'mailto:' + e + a + d + c;
	$(this).parent('a').attr('href', h);
	return e + a + d + c;
 });
});
