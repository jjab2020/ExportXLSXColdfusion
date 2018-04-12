
<!--- usage  --->
<!---<cf_log var="a" filename="test.html" thread="1" />--->

<!--- http://www.isummation.com/blog/custom-tag-to-log-data/ --->

<!--- String List Of Variables --->
<cfparam name="attributes.var" default="" type="string">
<cfparam name="attributes.fileName" default="log.html">
<cfparam name="attributes.fileAction" default="write">
<cfparam name="attributes.unique" default="1">

<!--- Use Thread If Set To 1 --->
<cfparam name="attributes.thread" default="1">
<cfparam name="logDir" default="PathToLogDirectory" />


<cfif thisTag.ExecutionMode is 'start'>
	<cfif val(attributes.thread)>
		<cfthread action="run" name="mythread#randrange(1,1000)#" priority="NORMAL" attrcollection="#attributes#" >
			<cfscript>
				LogDetails(attrcollection);
				</cfscript>
			</cfthread>
		<cfelse>
			<cfscript>
				LogDetails(attributes);
				</cfscript>
			</cfif>
		</cfif>
		<cffunction name="LogDetails" access="private" returntype="void">
			<cfargument name="attrCollection" /><cfset var dumpOutput="" />
			<cfset var ts="" />
			<cfsavecontent variable="dumpOutput">
				<cfloop list="#attrCollection.var#" index="varName">
					<cftry>
						<cfdump var="#caller[varname]#" label="#varName#" />
						<cfcatch type="any">
							<cfoutput>
								<br>Variable #varName# Not Found In Caller
							</cfoutput>
						</cfcatch>
					</cftry>
				</cfloop>
			</cfsavecontent>
			<cfif val(attrCollection.unique)>
				<cfscript>
					ts = dateFormat(now(),'YYYYMMDD') & "-" & timeFormat(now(),'HHMMSS');fName = ts & "-" & attrCollection.fileName;
					</cfscript>
				<cfelse>
					<cfscript>
						fName = attrCollection.fileName;
						</cfscript>
					</cfif>
					<cfif listFindNoCase("write,append",attrCollection.fileAction)>
						<cftry>
							<cffile action="#attrCollection.fileAction#" file="#logDir##fName#" output="#dumpOutput#"><cfcatch type="any">
								<!--- File I/O Failed --->
							</cfcatch>
						</cftry>
					</cfif>
				</cffunction>