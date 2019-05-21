<%@ page contentType="text/html; charset=UTF-8"%>
<script src="//cdn.ckeditor.com/4.11.4/standard/ckeditor.js"></script>
<script>
function init(){
	CKEDITOR.replace('content');
}

window.addEventListener("load", function(){
	init();
});
</script>