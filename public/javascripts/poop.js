function changeCost(){
	value = $("frugle_discount").getValue();
	if (value == "percent") {
		$("discount").innerHTML = "<span id=\"percentage\"></span>% Off <span id=\"product\"></span>";
		$("cost_div").innerHTML = "<input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"3\" type=\"text\" /> % Off <input id=\"frugle_product\" name=\"frugle[product]\" size=\"15\" type=\"text\" />";
	}
	else if (value == "dollar") {
		$("discount").innerHTML = "$<span id=\"percentage\"></span> Off <span id=\"product\"></span>";
		$("cost_div").innerHTML = "$<input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"3\" type=\"text\" /> Off <input id=\"frugle_product\" name=\"frugle[product]\" size=\"15\" type=\"text\" />";
	}
	else if (value == "flat") {
		$("discount").innerHTML = "$<span id=\"percentage\"></span> For <span id=\"product\"></span>";
		$("cost_div").innerHTML = "$<input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"3\" type=\"text\" /> For <input id=\"frugle_product\" name=\"frugle[product]\" size=\"15\" type=\"text\" />";
	}
	else if (value == "bonus") {
		$("discount").innerHTML = "Free <span id=\"percentage\"></span> With Purchase Of <span id=\"product\"></span>";
		$("cost_div").innerHTML = "Free <input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"10\" type=\"text\" /> With Purchase of <input id=\"frugle_product\" name=\"frugle[product]\" size=\"10\" type=\"text\" />";
	}
	else if (value == "bogo") {
		$("discount").innerHTML = "Buy One <span id=\"percentage\"></span> Get One <span id=\"product\"></span> Free";
		$("cost_div").innerHTML = "Buy One <input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"10\" type=\"text\" /> Get One <input id=\"frugle_product\" name=\"frugle[product]\" size=\"10\" type=\"text\" /> Free";
	}
};

jQuery(function() {
  jQuery("#frugle_start").datepicker();
	jQuery("#frugle_end").datepicker();
	
	jQuery('#frugle_start').change(function() {
		value = jQuery('#frugle_start').val();
	  jQuery('#start').text(value)
	});
	
	jQuery('#frugle_end').change(function() {
		value = jQuery('#frugle_end').val();
	  jQuery('#end').text(value)
	});
	
});

document.observe('dom:loaded', function() {
	$("frugle_discount").observe('change', changeCost);
	
	$("frugle_details").observe('keyup', function() {
		var value = $("frugle_details").getValue();
		$("details").innerHTML = value
	});
	
	$("frugle_quantity").observe('change', function() {
		value = $("frugle_quantity").getValue();
		$("details").innerHTML = "Quantity: " + value
	});
	
	$("frugle_other_offer").observe('change', function() {
		value = $("frugle_other_offer").getValue();
		if( value == 1 ) {
			$("other_offer").innerHTML ="Not Valid With Any Other Offers."
		}
		else {
			$("other_offer").innerHTML = " "
		}
	});
	
	$("frugle_visit").observe('change', function() {
		value = $("frugle_visit").getValue();
		if( value == 1 ) {
			$("visit").innerHTML = "Limit One Per Visit."
		}
		else {
			$("visit").innerHTML = " "
		}
	});
	
	$("frugle_altered").observe('change', function() {
		value = $("frugle_altered").getValue();
		if( value == 1 ) {
			$("altered").innerHTML = "Coupon Void If Altered."
		}
		else {
			$("altered").innerHTML = " "
		}
	});
	
	$("frugle_mobile").observe('change', function() {
		value = $("frugle_mobile").getValue();
		if( value == 1 ) {
			$("mobile").innerHTML = "We will accept this Frugle printed out or on a phone."
		}
		else {
			$("mobile").innerHTML = "We will only accept this Frugle when it is printed out"
		}
	});
	
	$("frugle_customers_new").observe('change', function() {
		value = $("frugle_customers_new").getValue();
		$("customers").innerHTML = "New Customers Only"
	});
	
	$("frugle_customers_returning").observe('change', function() {
		value = $("frugle_customers_returning").getValue();
		$("customers").innerHTML = "Returning Customers Only"
	});
	
	$("frugle_customers_anyone").observe('change', function() {
		value = $("frugle_customers_anyone").getValue();
		$("customers").innerHTML = "Available for Everyone"
	});
	
	$("frugle_tag_list").observe('keyup', function() {
		value = $("frugle_tag_list").getValue();
		$("tags").innerHTML = value
	});
	
	$("cost_div").observe('keyup', function(event) {
	    if (event.target.id == "frugle_percentage") {
				value = $("frugle_percentage").getValue(); 
				$("percentage").innerHTML = value;
			}
	});
	
	$("cost_div").observe('keyup', function(event) {
	    if (event.target.id == "frugle_product") {
				value = $("frugle_product").getValue(); 
				$("product").innerHTML = value;
			}
	});
	
});

