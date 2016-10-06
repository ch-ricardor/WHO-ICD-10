<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" indent="no"/>
<!--
    GAIN
	ICD-10-Section-CSV.xsl
	Template to Read WHO ICD-10-CM File	
	Experimental Phase.
	Data delimited by | 
	Creates the Table
	Chapter 
-->

<!--
	Includes
<xsl:include href="includes/csv_export.xsl"/>
-->

<xsl:variable name="delimiter" select="'|'"/>

<xsl:strip-space elements="*"/>


<xsl:template match="/">
	<xsl:text>version|chapter|section</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:copy>
		<!--	
			Data
		-->		
		<xsl:apply-templates select="//chapter/section" mode="csv-d">
			<xsl:with-param name="lastcol">desc</xsl:with-param>
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>

<xsl:template match="*" mode="csv-d">
	<xsl:param name="key-value" select="''"/>
	<xsl:param name="lastcol"/>

	<xsl:apply-templates select="." mode="d-section"/>

</xsl:template>

<xsl:template match="*" mode="d-section">
	<!-- Parent -->
	<xsl:value-of select="ancestor::node()/version"/>
	<xsl:value-of select="$delimiter"/>
	<xsl:value-of select="parent::node()/name"/>
	<xsl:value-of select="$delimiter"/>
	<xsl:value-of select="./desc"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


</xsl:stylesheet>
