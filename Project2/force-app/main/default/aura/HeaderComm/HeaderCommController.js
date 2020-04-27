({
    onClick : function(component, event, helper) {
        var id = event.target.dataset.menuItemId;
        if (id) {
            component.getSuper().navigate(id);
         }
   },
    
    updateValue :function(component,event,helper){
    	console.log("FUICK YOU");

	}
})