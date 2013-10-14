﻿component accessors="true" {

	property string propertyName;
	property string constraintName;
	property string constraintValue;
	property string context;
	property string message;

	public ValidationRule function init(){
		return this;
	}

	//overriding this setter to handle the "typeCase"
	public void function setConstraintName(required string name){
		if(arguments.name == 'type')
			variables.constraintName = 'isValid';
		else
			variables.constraintName = arguments.name;

	}
	
	public boolean function hasMessage(){
		return !isNULL(variables.message);
	}

}