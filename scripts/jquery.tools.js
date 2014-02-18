$(document).ready(function(){
  $('.jt_authorEmail').html(function(){
	var e = "robert.qian";
	var a = "@";
	var d = "lampnode";
	var c = ".com";
	var h = 'mailto:' + e + a + d + c;
	$(this).parent('a').attr('href', h);
	return e + a + d + c;
 });
});
