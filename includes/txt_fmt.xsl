<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" indent="no"/>
<!--
    RRE
	2016-03
	Experimental Phase.
	Text formating Templates
	NOTE:

-->
<!--
    Node Format for the export Task
-->
<xsl:template name="Node_Format">
	<xsl:param name="Node_Value"/>
	<xsl:call-template name="Trim">
		<xsl:with-param name="s" select="normalize-space($Node_Value)"/>
	</xsl:call-template>
	<xsl:value-of select="$delimiter"/>
</xsl:template>
	
<xsl:template name="Opcional"><xsl:param name="valor"/><xsl:if test="$valor">|Optional<xsl:call-template name="Trim"><xsl:with-param name="s" select="$valor"/></xsl:call-template></xsl:if></xsl:template>
	
<!-- 
	Remove Special characters
-->
<xsl:template name="Trim">
	<xsl:param name="s"/>
	<xsl:call-template name="rtrim">
	<xsl:with-param name="s" select="concat(substring(translate($s,' &#9;&#10;&#13;',''),1,1),substring-after($s,substring(translate($s,' &#9;&#10;&#13;',''),1,1)))"/>
	</xsl:call-template>
</xsl:template>
	
<!-- 
	Remove Special characters Right to Left
	Adds de delimiter character
-->
<xsl:template name="rtrim">
	<xsl:param name="s"/>
	<xsl:param name="i" select="string-length($s)"/>

	<xsl:if test="contains($s,',')">
		<xsl:text>&quot;</xsl:text>
	</xsl:if>
	
	<xsl:choose>
		<xsl:when test="translate(substring($s,$i,1),' &#9;&#10;&#13;','')">
			<xsl:value-of select="substring($s,1,$i)"/>
		</xsl:when>
		<xsl:when test="$i&lt;2"/>
		<xsl:otherwise>
			<xsl:call-template name="rtrim">
				<xsl:with-param name="s" select="$s"/>
				<xsl:with-param name="i" select="$i - 1"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>

	<xsl:if test="contains($s,',')">
		<xsl:text>&quot;</xsl:text>
	</xsl:if>

</xsl:template>
	
</xsl:stylesheet>
