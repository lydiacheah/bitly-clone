$(document).ready(function() {
	$('.fa').mouseenter(function() {
		$(this).effect('bounce', {times:1, distance: 20}, 900);
	});

	$('#form1').on('submit',function(event) {
		event.preventDefault();
		var input = $(this).serialize();
		$.ajax({
			url: '/submit',
			method: 'POST',
			data:input,
			dataType: "json",

			success: function(jsonString) {
				if (jsonString["errors"]) {
					// append doesn't work because it will keep adding the error message to the HTML 
					$("#shortened").remove();
					$("#input_long").remove();
          $(".error-message").html('<div id="errors">'+jsonString["errors"].long_url[0]+'</div>');
        }
        else {
        	$("#errors").remove();
        	$("#input-url").html('<div id="input_long">'+jsonString.long_url+'</div>');
        	$(".shortened-url").html('<a id="shortened" href="http://localhost:9393/'+jsonString.short_url+'">http://localhost:9393/'+jsonString.short_url+'</a>');
        }
			},

			error: function(request, errorType, errorMessage) {
          alert('Error: ' + errorType + ' with message: ' + errorMessage)} 
		})
	})
});