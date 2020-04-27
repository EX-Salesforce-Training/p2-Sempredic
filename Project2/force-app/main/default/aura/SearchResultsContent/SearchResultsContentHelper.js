({
	filterName : function(component) {
        
        var list = component.get("v.pokeList");
        var name = component.get("v.userInput");
        console.log(list.length);
        
        for(var i =0;i<list.length;i++){
            if(list[i].Name == name){
                component.set("v.pokeList",list[i]);
            }
        }
        
	}
})