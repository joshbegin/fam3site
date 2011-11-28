//Add Datepicker to User/Birthdate
$(function () { 
  $("#user_birthdate").datepicker({ 
  	changeYear: true, 
  	yearRange: 'c-100:c', 
  	changeMonth: true,
  	dateFormat: 'yy-mm-dd' 
  });  
});