function changeCost(){
	value = $("frugle_discount").getValue();
	if (value == "percent") {
		$("cost_div").innerHTML = "<input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"3\" type=\"text\" /> % Off <input id=\"frugle_product\" name=\"frugle[product]\" size=\"15\" type=\"text\" />";
	}
	else if (value == "dollar") {
		$("cost_div").innerHTML = "$<input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"3\" type=\"text\" /> Off <input id=\"frugle_product\" name=\"frugle[product]\" size=\"15\" type=\"text\" />";
	}
	else if (value == "flat") {
		$("cost_div").innerHTML = "$<input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"3\" type=\"text\" /> For <input id=\"frugle_product\" name=\"frugle[product]\" size=\"15\" type=\"text\" />";
	}
	else if (value == "bonus") {
		$("cost_div").innerHTML = "Free <input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"10\" type=\"text\" /> With Purchase of <input id=\"frugle_product\" name=\"frugle[product]\" size=\"10\" type=\"text\" />";
	}
	else if (value == "bogo") {
		$("cost_div").innerHTML = "Buy One <input id=\"frugle_percentage\" name=\"frugle[percentage]\" size=\"10\" type=\"text\" /> Get One <input id=\"frugle_product\" name=\"frugle[product]\" size=\"10\" type=\"text\" /> Free";
	}
};

document.observe('dom:loaded', function() {
	$("frugle_discount").observe('change', changeCost);
});