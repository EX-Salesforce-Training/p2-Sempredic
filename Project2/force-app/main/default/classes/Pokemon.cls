public class Pokemon{
    
    @AuraEnabled
	public String name;
    @AuraEnabled
    public String weight;
    @AuraEnabled
    public String height;
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String base_experience;
    @AuraEnabled
    public String order;
    @AuraEnabled
    public String location_area_encounters;
    
    @AuraEnabled
  	public Species species;
    @AuraEnabled
    public List<Abilities> abilities;
    @AuraEnabled
    public List<Form> forms;
    @AuraEnabled
    public List<Items> held_items;
    @AuraEnabled
    public List<Types> types;
    @AuraEnabled
    public Sprite sprites;
    @AuraEnabled
    public List<StatsObj> stats;

}