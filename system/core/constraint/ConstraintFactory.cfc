﻿import hyrule.system.core.constraint.*;

component accessors="true" {
	
	property name="constraints" type="struct";

	public ConstraintFactory function init(){
		variables.constraints = {};
		load();
		return this;
	}
	
	/**
	 * I return a list of valid constraints in Hyrule
	 */
	public string function getConstraintList(){
		return lcase(structKeyList(constraints));	
	}
	
	public any function getConstraint(required string constraintName){
		if(!StructKeyExists(getConstraints(),arguments.constraintName))
			throw("constraint name #arguments.constraintName# not available");
		else return variables.constraints[arguments.constraintName];
	}
	
	/**
	 * I read the constraints directory and load a collection of constraint objects
	 * 
	 */
	private function load(){
		var exclude = "AbstractConstraint.cfc,ConstraintFactory.cfc";
		var clazzes = [];
		
		// read this directory and get a list of constraints
		var dir = getDirectoryFromPath(getCurrentTemplatePath());		
		// for each constraint instantiate the class and set it in the constraints collection
		var components = directoryList(dir);

		// remove exclusions
		for(var x=1; x<=arrayLen(components); ++x){
			var f = getFileFromPath(components[x]);									
			if( listFindNoCase(exclude,f) == 0){
				arrayAppend(clazzes,replaceNoCase(f,".cfc",""));
			}
		}
					
		// now we have a list of components to instantiate
		for(var i=1; i<=arrayLen(clazzes); ++i){
			var temp = new "#clazzes[i]#"();
			var name = temp.getConstraintName();
			variables.constraints['#name#'] = temp;
		}
		
	}

}