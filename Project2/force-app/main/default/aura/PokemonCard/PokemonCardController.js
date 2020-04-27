({
	navigateToPage : function(component,event,helper) {
        
        	
			event.preventDefault();
            
            var navService = component.find("navService");
            var pageReference = {
                type: "comm__namedPage",
                attributes: {
                    pageName: "profilepage"
                },
                state: {
                    pokeObj: component.get("v.pokeObj")
                }
            };
            sessionStorage.setItem('toProfileFromCard', JSON.stringify(pageReference.state));
            navService.navigate(pageReference);
	}
})