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
	ICD-10-CM
		|-version
			|-chapter
				|-SectionInd
					|-Diagnosis
-->

<!--
	Includes
-->
<xsl:include href="includes/txt_fmt.xsl"/>

<xsl:variable name="delimiter" select="'|'"/>

<xsl:strip-space elements="*"/>


<xsl:template match="/">
	<xsl:text>version|chapter|id_grp|diag_id|diag</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
	<xsl:copy>
		<!--	
			Data
		-->		
		<xsl:apply-templates select="//chapter/section/diag" mode="csv-d">
			<xsl:with-param name="lastcol">da</xsl:with-param>
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>

<xsl:template match="*" mode="csv-d">
	<xsl:param name="key-value" select="''"/>
	<xsl:param name="lastcol"/>

	<xsl:apply-templates select="." mode="d-diag"/>

</xsl:template>

<xsl:template match="*" mode="d-diag">
	<!-- Parent -->
	<xsl:value-of select="ancestor::node()/version"/>
	<xsl:value-of select="$delimiter"/>
	<xsl:value-of select="../.././name"/>
	<xsl:value-of select="$delimiter"/>

	<xsl:value-of select="../.././sectionIndex/sectionRef/@id"/>
	<xsl:value-of select="$delimiter"/>
	<xsl:value-of select="name(../.././sectionIndex/sectionRef[@id = concat(./name,'-','A09')])"/>
	<xsl:value-of select="$delimiter"/>

		<xsl:value-of select="concat('**',../.././sectionIndex/sectionRef/@first,'**')"/>
		<xsl:value-of select="concat('**',../.././sectionIndex/sectionRef/@last,'**')"/>
	
	<xsl:if test="../.././sectionIndex/sectionRef/@first &lt;= ./name">
		<xsl:value-of select="../.././sectionIndex/sectionRef/@first"/>
		<xsl:value-of select="concat(./name,'-','A09')"/>
		<xsl:value-of select="$delimiter"/>
	</xsl:if>

	<xsl:value-of select="$delimiter"/>
	<xsl:value-of select="./name"/>
	<xsl:value-of select="$delimiter"/>
	<!-- Text Fields need Format -->
	<xsl:call-template name="Node_Format">
		<xsl:with-param name="Node_Value" select="./desc"/>
	</xsl:call-template>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>



</xsl:stylesheet>
