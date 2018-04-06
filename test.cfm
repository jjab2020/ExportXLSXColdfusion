<CFQUERY NAME="GetData" DATASOURCE="MyDns">
	SELECT *
	FROM contacts
</CFQUERY>

<cfset dataArray = ArrayNew(1) />
<cfset dataStruct = StructNew() >
<cfset dataStruct["id"] = 1>
<cfset dataStruct["column"] = "index">
<cfset dataStruct["format"] = "numericStyle">
<cfset ArrayAppend(dataArray,dataStruct) />
<cfset dataStruct = StructNew() >
<cfset dataStruct["id"] = 2>
<cfset dataStruct["column"] = "nom">
<cfset dataStruct["format"] = "textStyle">
<cfset ArrayAppend(dataArray,dataStruct) />
<cfset dataStruct = StructNew() >
<cfset dataStruct["id"] = 3>
<cfset dataStruct["column"] = "tel">
<cfset dataStruct["format"] = "textStyle">
<cfset ArrayAppend(dataArray,dataStruct) />
<cfset dataStruct = StructNew() >
<cfset dataStruct["id"] = 4>
<cfset dataStruct["column"] = "email">
<cfset dataStruct["format"] = "textStyle">
<cfset ArrayAppend(dataArray,dataStruct) />
<cfset dataStruct = StructNew() >
<cfset dataStruct["id"] = 5>
<cfset dataStruct["column"] = "adresse">
<cfset dataStruct["format"] = "textStyle">
<cfset ArrayAppend(dataArray,dataStruct) />
<cfset dataStruct = StructNew() >
<cfset dataStruct["id"] = 6>
<cfset dataStruct["column"] = "naissance">
<cfset dataStruct["format"] = "dateStyle">
<cfset ArrayAppend(dataArray,dataStruct) />
<cfset mypath = #GetDirectoryFromPath(GetCurrentTemplatePath())# & dateFormat(Now(),"yyyymmdd") & ".xlsx"/>


<cfset infoStruct = StructNew() >
<cfset infoStruct["title"] = "Export from mysql">
<cfset infoStruct["category"] = "Cfscript cfml">
<cfset infoStruct["author"] = "Jabrane Jabri">
<cfset infoStruct["subject"] = "export data from mysql database to xslx">
<cfset infoStruct["comments"] = "you have to create database before using the cfc script">
<cfset infoStruct["manager"] = "Jabrane Jabri" />

<cfinvoke component="excelExport" method="spreadsheetNewFromQuery">
	<cfinvokeargument name="myQyery" value="#GetData#">
	<cfinvokeargument name="sheetName" value="DATA1">
	<cfinvokeargument name="pathfile" value=#mypath#>
	<cfinvokeargument name="columnData" value="#dataArray#">
	<cfinvokeargument name="removeHeader" value="false">
	<cfinvokeargument name="infos" value="#infoStruct#">
</cfinvoke>