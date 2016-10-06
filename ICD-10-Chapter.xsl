<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" version="1.0" indent="no"/>

<!--
    GAIN
	Template to Read WHO ICD-10-CM File
	Experimental Phase.
	Data delimited by | 
	Creates the Table
	Chapter 
-->
<xsl:variable name="delimiter" select="'|'"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
    <xsl:apply-templates select="ICD10CM.tabular" mode="header"/>
	<xsl:apply-templates select="ICD10CM.tabular"/>
</xsl:template>

<xsl:template match="*" mode="header" >

    <xsl:for-each select="child::*">
		<xsl:value-of select="local-name(.)"/>
		<xsl:choose>
			<xsl:when test="position()=last()">
				<xsl:text>&#13;&#10;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$delimiter"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>

	<xsl:for-each select="*">
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="local-name(.)"/>
		</xsl:call-template>
	</xsl:for-each>
	<xsl:text>&#13;&#10;</xsl:text>
	
</xsl:template>

<xsl:template match="ICD10CM.tabular/">

<!-- 
distinct-values(//*/name())
	Pruebas de seleccion nodes unicos
	/root/item[not(.=preceding-sibling::item)])
	<xsl:for-each-group select="*/*/local-name(.)" group-by=".">
		<xsl:copy-of select="."/>
	</xsl:for-each-group>
-->

	<xsl:for-each select="chapter">
<!--
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="../version"/></xsl:call-template>
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="name"/></xsl:call-template>
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="desc"/></xsl:call-template>
-->
		<xsl:call-template name="Node_Format">
			<xsl:with-param name="Node_Value" select="../version|./name|./desc"/>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>

<xsl:template match="*" mode="row">
    <xsl:apply-templates select="*" mode="data" />
    <xsl:value-of select="$delimiter"/>
</xsl:template>

 <xsl:template match="*" mode="data">
    <xsl:choose>
      <xsl:when test="contains(text(),',')">
        <xsl:text>&quot;</xsl:text>
        <xsl:call-template name="doublequotes">
          <xsl:with-param name="text" select="text()" />
        </xsl:call-template>
        <xsl:text>&quot;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="position() != last()">,</xsl:if>
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

<!--
    Node Format for the export Task
-->
<xsl:template name="Node_Format">
	<xsl:param name="Node_Value"/><xsl:call-template name="Trim"><xsl:with-param name="s" select="normalize-space($Node_Value)"/>
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
</xsl:template>
	
</xsl:stylesheet>