<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" indent="no"/>
<!--
    RRE
	2016-03
	Experimental Phase.
	XML transfer to csv 
	NOTE:
	CSV delimiter should be defined in the caller file
	<xsl:variable name="delimiter" select="'|'"/>

-->

<!--
	CSV export Routines
	Header adds quotes and delimiter to the node
-->
<xsl:template match="*" mode="csv-delimited-header">
	<xsl:param name="key-column" select="''"/>
	<xsl:param name="lastcol"/>
	
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="local-name()"/>
	<xsl:text>&quot;</xsl:text>
	
	<xsl:choose>
		<xsl:when test="local-name()=$lastcol">
			<xsl:if test="$key-column">
				<xsl:value-of select="$delimiter"/>
				<xsl:text>&quot;</xsl:text>
				<xsl:value-of select="$key-column"/>
				<xsl:text>&quot;</xsl:text>
			</xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$delimiter"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
	CSV export Routines
	Rows adds quotes and delimiter to the node
	To assign the line break is necessary to define the last column
-->
<xsl:template match="*" mode="csv-delimited">
	<xsl:param name="key-value" select="''"/>
	<xsl:param name="lastcol"/>

	<xsl:apply-templates select="." mode="d-string"/>

	<xsl:choose>
		<xsl:when test="name()=$lastcol">
			<xsl:if test="$key-value">
				<xsl:value-of select="$delimiter"/>
				<xsl:value-of select="$key-value"/>
			</xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$delimiter"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!--
	Add double quotes for strings with comma included in the text
-->
<xsl:template match="*" mode="d-string">
	<xsl:choose>
		<xsl:when test="contains(text(),',')">
			<xsl:text>&quot;</xsl:text>
			<xsl:call-template name="doublequotes">
				<xsl:with-param name="text" select="text()"/>
			</xsl:call-template>
			<xsl:text>&quot;</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="."/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="doublequotes">
	<xsl:param name="text" />
	<xsl:choose>
		<xsl:when test="contains($text,'&quot;')">
			<xsl:value-of select="concat(substring-before($text,'&quot;'),'&quot;&quot;')" />
			<xsl:call-template name="doublequotes">
				<xsl:with-param name="text" select="substring-after($text,'&quot;')" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$text" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
