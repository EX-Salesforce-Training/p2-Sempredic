({
	handleClick : function(component, event, helper) {
		
	},
    
    keyCheck : function(component, event, helper){
        if (event.which == 13){
            
            var action = component.get("c.GetPokemonNearByLoc");
            var location = component.get("v.userInput");
            
            action.setParams({
                "location": location,
                "lim": 0
            });
            
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    // do nothing!
                    component.set("v.pokeList", response.getReturnValue());
                    for(var i = 0; i < response.getReturnValue().length; i++){
                        console.log(response.getReturnValue()[i].Sprites__r[0].Front_Default__c);
                        
    
                    }
                    
                    helper.navigateToPage(component,event);
                }
            });
            
            $A.enqueueAction(action);

        }    
    }
})