({
	doInit : function(component, event, helper) {
        
		var action = component.get("c.GetPokemonNearByLoc");
        action.setParams({
            "location": "79407,TX",
            "lim": 5
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // do nothing!
                component.set("v.pokeList", response.getReturnValue());
                for(var i = 0; i < response.getReturnValue().length; i++){
					console.log(response.getReturnValue()[i].Sprites__r[0].Front_Default__c);
                	

                }
            }
        });
        
        $A.enqueueAction(action);
	}
    
    
    
})