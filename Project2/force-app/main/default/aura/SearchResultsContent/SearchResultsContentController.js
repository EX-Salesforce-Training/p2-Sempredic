({
	doInit: function(component,event,helper){
        var localStuff = sessionStorage.getItem('toSearchFromHome');
        if (localStuff) {
            var state = JSON.parse(localStuff);
            component.set("v.loc",state.location);
            component.set("v.pokeList",state.pokeList);
            component.set("v.listSize",state.pokeList.length);
            console.log(state);
            console.log(state.location + " " + state.pokeList);
            sessionStorage.clear();
            // Do the needed stuff here
        }
    },
    
    onSelect:function(component,event,helper){
        console.log("IM CHANGED");
        //helper.filter(component);
    },
    
    keyCheck: function(component,event,helper){
        if (event.which == 13){
            helper.filterName(component);
        }
        
    }
})