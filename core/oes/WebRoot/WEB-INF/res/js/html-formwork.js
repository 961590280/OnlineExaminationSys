function htmlBuid(html,arrValue){
	var valuePlace = "??";
	for(var key in arrValue){
		html = html.repalce("??",arrValue[key]);
	}
	return html;
	
}