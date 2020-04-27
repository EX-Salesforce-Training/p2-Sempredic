public class ApiController {

    @AuraEnabled
    public static void SavePokemonByName(String name){
        
        String restAPIURL = 'https://pokeapi.co/api/v2/pokemon/'+name;  
          
        HttpRequest httpRequest = new HttpRequest();  
        httpRequest.setMethod('GET');   
        httpRequest.setEndpoint(restAPIURL);  
        
        String response = '';
        
        try {  
            
            Http http = new Http();   
            HttpResponse httpResponse = http.send(httpRequest);  
            if (httpResponse.getStatusCode() == 200 ) {  
                
                Pokemon poke = (Pokemon)JSON.deserialize(httpResponse.getBody(),Pokemon.class);  

                Pokemon__c pokeObj = new Pokemon__c();        
                pokeObj.PokeId__c = poke.id;
                pokeObj.Name = poke.name;
                pokeObj.Weight__c = poke.weight;
                pokeObj.Height__c = poke.height;
                pokeObj.BaseXP__c = poke.base_experience;
                pokeObj.Order__c = poke.order;
                
                pokeObj.Zip__c = '79407';
                pokeObj.State__c = 'TX';
                
                System.Debug(poke.stats);

                
                insert pokeObj;
                
                Pokemon__c pokeRec = [Select Id, Name,Zip__c,State__c From Pokemon__c Where Id = :pokeObj.id];

                List<Ability__c> abilityList = new List<Ability__c>();
                List<Form__c> formList = new List<Form__c>();
                List<Item__c> itemList = new List<Item__c>();
                List<Type__c> typeList = new List<Type__c>();
                List<Stat__c> statList = new List<Stat__c>();
       
                for(Abilities ability:poke.Abilities){
             
                    Ability__c abi = new Ability__c();
                    
                    abi.Name = ability.ability.name;
                    abi.Url__c = ability.ability.url;
                	abi.Pokemon__c = pokeRec.Id;
                    
                    abilityList.add(abi);
                }
                
                for(Form form:poke.forms){
                    
                    Form__c fo = new Form__c();
                    
                    fo.Name = form.name;
                    fo.Url__c = form.url;
                	fo.Pokemon__c = pokeRec.Id;
                    
                    formList.add(fo);
                }
                
                for(Items item:poke.held_items){
                    
                    Item__c it = new Item__c();
                    
                    System.Debug(item);
                    
                    it.Name = item.item.name;
                    it.Url__c = item.item.url;
                	it.Pokemon__c = pokeRec.Id;
                    
                    itemList.add(it);
                }
                
                for(StatsObj sObj:poke.stats){
                    
                    
                    Stat__c stat = new Stat__c();
                    
                    System.Debug(stat);
                    stat.Name = sObj.stat.name;
                    stat.BaseStat__c = Integer.valueOf(sObj.base_stat);
                    stat.Pokemon__c = pokeRec.Id;
                    
                    statList.add(stat);
                    
                }
                
                for(Types ty:poke.types){
                    
                    Type__c it = new Type__c();
                    
  					it.Name = ty.type.Name;
                    
                    it.Pokemon__c = pokeRec.Id;
                    
                    typeList.add(it);
                }
                
                Sprites__c sprite = new Sprites__c();
                sprite.Back_Default__c = poke.sprites.back_default;
                sprite.Back_Female__c = poke.sprites.back_female;
                sprite.Back_Shiny__c = poke.sprites.back_shiny;
                sprite.Back_Shiny_Female__c = poke.sprites.back_shiny_female;
                sprite.Front_Default__c = poke.sprites.front_default;
                sprite.Front_Female__c = poke.sprites.front_female;
                sprite.Front_Shiny__c = poke.sprites.front_shiny;
                sprite.Front_Shiny_Female__c = poke.sprites.front_shiny_female;
     			sprite.Pokemon__c = pokeRec.id;

                insert abilityList;
                insert formList;
                insert itemList;
                insert typeList;
                insert statList;
    			insert sprite;
     			
                
            } else {  
                System.debug(' httpResponse ' + httpResponse.getBody() );  
                throw new CalloutException( httpResponse.getBody() );  
            }   
            
        } catch( System.Exception e) {  
            
            System.debug('ERROR: '+ e);  
            throw e;  
        }  
   
    }

    @AuraEnabled
    public static List<Pokemon__c> GetPokemonById(String id){
    	
        if(id == ''){
            return [SELECT Id FROM Pokemon__c];
        }
        
        return [SELECT Id,Name FROM Pokemon__c WHERE Id =: id];
    }
    @AuraEnabled
    public static List<Pokemon__c> GetPokemonByName(String name){
    	
        if(name == ''){
            return [SELECT Id,Name,(SELECT Id,Front_Default__c FROM Sprites__r) FROM Pokemon__c];
        }
        
       
        return [SELECT Id,Name,(SELECT Id,Front_Default__c FROM Sprites__r) FROM Pokemon__c WHERE Name =: name];
    }
    
    @AuraEnabled
    public static List<Pokemon__c> GetPokemonNearByLoc(String location, Integer lim){

        String[] stringList = location.split(',');
        
        String zip = stringList[0];
        String state = stringList[1];
        
        System.Debug(location + ' ' + zip + ' ' + state);
        
        if(lim != 0){
            return [SELECT Id,Name,Zip__c,State__c,BaseXP__c,Height__c,PokeId__c,Weight__c,(SELECT Id,Front_Default__c FROM Sprites__r),(SELECT Id,Name FROM Abilities__r),(SELECT Id,Name FROM Types__r),(SELECT Id,Name,BaseStat__c FROM Stats__r) FROM Pokemon__c WHERE Zip__c =: zip AND State__c =: state LIMIT :lim];
    
        }
        
        return [SELECT Id,Name,Zip__c,State__c,BaseXP__c,Height__c,PokeId__c,Weight__c,(SELECT Id,Front_Default__c FROM Sprites__r),(SELECT Id,Name FROM Abilities__r),(SELECT Id,Name FROM Types__r),(SELECT Id,Name,BaseStat__c FROM Stats__r) FROM Pokemon__c WHERE Zip__c =: zip AND State__c =: state];
    }
}