<cfset user = new User()>
<cfset user.setUsername("dvega")>

<cfset result = application.hyrule.validate(user,"username")>

<cfdump var="#result.getErrors()#">
