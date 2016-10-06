<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" indent="no"/>
<!--
    GAIN
	ICD-10-Chapter-CSV.xsl
	Template to Read WHO ICD-10-CM File	
	Experimental Phase.
	Data delimited by | 
	Creates the Table
	Chapter 
-->

<!--
	Includes
-->
<xsl:include href="includes/csv_export.xsl"/>

<xsl:variable name="delimiter" select="'|'"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:copy>
		<!--	
			Header
		-->		
		<xsl:apply-templates select="//chapter[1]/name | //chapter[1]/desc" mode="csv-delimited-header">
			<xsl:with-param name="key-column">version</xsl:with-param>
			<xsl:with-param name="lastcol">desc</xsl:with-param>
		</xsl:apply-templates>
		<!--	
			Data
		-->		
		<xsl:apply-templates select="//chapter/name | //chapter/desc" mode="csv-delimited">
			<xsl:with-param name="key-value"><xsl:value-of select="//version"/></xsl:with-param>
			<xsl:with-param name="lastcol">desc</xsl:with-param>
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>


</xsl:stylesheet>
