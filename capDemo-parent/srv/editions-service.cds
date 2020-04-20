using de.javamagazin as jm from '../db/data-model';

service EditionsService {

  	type DynamicAppLauncher {
    	icon: String;
    	info: String;
    	infoState: String;
    	number: Decimal(9,2);
    	numberDigits: Integer;
    	numberFactor: String;
    	numberState: String;
    	numberUnit: String;
    	stateArrow: String;
    	subtitle: String;
    	title: String;
 	}
	
	function getNumberOfEditionsForDynamicTile() returns DynamicAppLauncher;
	
    entity Editions as projection on jm.Editions;
    entity Articles as projection on jm.Articles;
    entity Authors as projection on jm.Authors;
}