<cfcomponent>
	<cffunction name="spreadsheetNewFromQuery" access="public" output="false">
		<cfargument name="myQyery" type="query" required="true" hint="requete sql passé">
		<cfargument name="sheetName" type="string" default="Sheet1" required="false" hint="nom feuille xlsx" >
		<cfargument name="pathfile" type="string" required="true" hint="chemin de fichier">
		<cfargument name="columnData" type="object" required="true" hint="Columns data Passed" />
		<cfset list_column = "" />
		<cfloop array="#arguments.columnData#" index="m">
			<cfif structKeyExists(m, "id") >
				<cfset list_column = listappend(list_column, UCase(m.column), ",") />
			</cfif>
		</cfloop>
		<cfscript>
			/* Format text*/
			textStyle=StructNew();
			/*textStyle.fgcolor="green";*/
			textStyle.dataformat="text";
			textStyle.font="arial";
			textStyle.alignment="center";
			
			/* Format Date*/
			dateStyle=StructNew();
			/*dateStyle.fgcolor="yellow";*/
			dateStyle.font="arial";
			dateStyle.alignment="center";
			dateStyle.dataformat="m/d/yy";

			/*Format numeric*/

			numericStyle=StructNew();
			/*numericStyle.fgcolor="blue";*/
			numericStyle.font="arial";
			numericStyle.alignment="center";
			numericStyle.dataformat="0";

			//creation du spreasheet	
			spreadsheet = spreadsheetNew(sheetName,true);

			//si on a des enregistrements on génére le fichier excel

			if(myQyery.recordCount !=0){
				/*Create the spreadsheet*/
				
				spreadsheetAddRow(spreadsheet,list_column);
				spreadsheetAddRows(spreadsheet,myQyery);
				spreadsheetFormatRow(spreadsheet,{alignment="center",color="green",font="arial",fontsize="13",bold="true",italic="true",bottomborder="thin"},1);
				for (var rowIdx=1; rowIdx <= spreadsheet.getWorkbook().getSheetAt(0).getLastRowNum(); rowIdx++) {
					var rowObj = spreadsheet.getWorkbook().getSheetAt(0).getRow(rowIdx);
					for (var cellIdx=1; cellIdx < rowObj.getLastCellNum()+1; cellIdx++) {
						SpreadsheetFormatCell(spreadsheet,{alignment="center",font="arial"},rowIdx+1,cellIdx);

						for(i=1; i <= arrayLen(columnData); i++) {
							if (columnData[i]['id'] EQ cellIdx) {
								switch(columnData[i]['format']) {
									case "textstyle":
									SpreadsheetFormatCell(spreadsheet,textstyle,rowIdx+1,cellIdx);
									break;
									case "dateStyle":
									SpreadsheetFormatCell(spreadsheet,dateStyle,rowIdx+1,cellIdx);
									break;
									case "numericStyle":
									SpreadsheetFormatCell(spreadsheet,numericStyle,rowIdx+1,cellIdx);
									break;
									default: 
									SpreadsheetFormatCell(spreadsheet,textstyle,rowIdx+1,cellIdx);
								}
							}
						}
					}
				}
			}
			else{
				/*Create empty excel file */
				SpreadSheetAddRow(spreadsheet,"Pas d'enregistrements",2,2,true);
				SpreadsheetMergeCells (spreadsheet, 2, 3, 2,15);
				spreadsheetFormatCellRange(spreadsheet, {alignment="center",color="blue",font="arial",fontsize="16",bold="true",italic="true",bottomborder="thin",leftborder="thin",leftbordercolor="blue",rightborder="thin",rightbordercolor="blue",topborder="thin",topbordercolor="blue",verticalalignment="VERTICAL_center",bottombordercolor="blue"},2,2,3,15);
			}
			spreadsheet.getWorkbook().getSheetAt(javacast("int", 0)).autoSizeColumn( javacast("int", 0) );
			spreadsheetWrite(spreadsheet,pathfile,true);	
			</cfscript>
		</cffunction>
	</cfcomponent>