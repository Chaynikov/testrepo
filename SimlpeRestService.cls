@RestResource(UrlMapping='/SimpleRestService')
global class SimpleRestService {
    global class CatClass {
        String name;
        String accId;
        String accName;
        Decimal foodQu;
        String imageURL;
        
        public CatClass(String catName,String catAccId,String catAccName,Decimal catFoodQu) {
            name = catName;
            accId = catAccId;
            accName = catAccName;
            foodQu = catFoodQu;
        }
    }
    
    @HttpGet
    global static List <CatClass> getAllCats () {        
        List <CatClass> ret = new List <catClass> ();
        for(cat__c c : [SELECT Name,Account__c,Account__r.Name,food_quantity__c FROM cat__c]){            
            ret.add(new CatClass(c.Name,c.Account__c,c.Account__r.Name,c.food_quantity__c));
        }
        
        return ret;
    }
    
    @HttpPost
    global static void addCat() {
        String body = RestContext.request.requestBody.toString();
        CatClass cat = (CatClass)JSON.deserialize(body, CatClass.class);
        
        insert new cat__c(name = cat.name,
                         Account__c = cat.accId,
                         food_quantity__c = cat.foodQu,
                         image_URL__c = cat.imageURL);
    }
}