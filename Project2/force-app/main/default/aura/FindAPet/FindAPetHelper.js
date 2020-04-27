({
	navigateToPage : function(component,event) {
		event.preventDefault();
            
            var navService = component.find("navService");
            var pageReference = {
                type: "comm__namedPage",
                attributes: {
                    pageName: "searchresultspage"
                },
                state: {
                    location: component.get("v.userInput"),
                    pokeList: component.get("v.pokeList")
                }
            };
            sessionStorage.setItem('toSearchFromHome', JSON.stringify(pageReference.state));
            navService.navigate(pageReference);
	}
})