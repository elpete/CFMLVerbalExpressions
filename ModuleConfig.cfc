component name="ModuleConfig" {

	this.title 				= "VerbalExpressions";
	this.author 			= "Eric Peterson";
	this.webURL 			= "http://dev.elpete.com";
	this.description 		= "Verbal Expression port to CFML";
	this.version			= "1.0.0";
	this.dependencies 		= [];

	function configure() {
        binder.map("VerbalExpression").to("#moduleMapping#.models.Expression");
	}

}
