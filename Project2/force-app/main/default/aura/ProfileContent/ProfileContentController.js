({
	doInit : function(component, event, helper) {
		var localStuff = sessionStorage.getItem('toProfileFromCard');
        if (localStuff) {
            var state = JSON.parse(localStuff);
            component.set("v.pokeObj",state.pokeObj);
 
            console.log(state);

            sessionStorage.clear();
            // Do the needed stuff here
        }
	}
})