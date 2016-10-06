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

<!--
<xsl:template match="desc">
	<xsl:apply-templates select="." mode="d-string"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="*" mode="column">
	<xsl:apply-templates select="." mode="d-string"/>
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

-->





<xsl:variable name="delimiter" select="'|'"/>
<xsl:strip-space elements="*"/>
<!--
<xsl:key name="names" match="//*" use="local-name(.)"/>
<xsl:key name="names" match="*/*[3]/*" use="local-name(.)"/>
-->
<xsl:key name="names" match="//*" use="local-name(.)"/>


<xsl:template match="/">
    <xsl:apply-templates select="ICD10CM.tabular" mode="header"/>
	<xsl:apply-templates select="ICD10CM.tabular"/>
</xsl:template>

<xsl:template match="/">
	<!--Do something with the unique list of elements-->
<!--
    <xsl:for-each select="//*[generate-id(.) = generate-id(key('names', local-name(.)))]">
		<xsl:value-of select="name()" />
		<xsl:if test="not(position() = last())">,</xsl:if>
    </xsl:for-each>
	Chapter
    <xsl:for-each select="*/*[3]/*[generate-id(.) = generate-id(key('names', local-name(.)))]">

-->
    <xsl:for-each select="*/*[3]/*[generate-id(.) = generate-id(key('names', local-name(.)))]">
		<xsl:value-of select="name()" />
		<xsl:if test="not(position() = last())">,</xsl:if>
    </xsl:for-each>
	
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
	
<xsl:template match="ICD10CM.tabular">

<!-- 
distinct-values(//*/name())
	Pruebas de seleccion nodes unicos
	/root/item[not(.=preceding-sibling::item)])
	<xsl:for-each-group select="*/*/local-name(.)" group-by=".">
		<xsl:copy-of select="."/>
	</xsl:for-each-group>
-->

	<xsl:for-each select="chapter">
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="../version"/></xsl:call-template>
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="name"/></xsl:call-template>
		<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="desc"/></xsl:call-template>
	</xsl:for-each>
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



<xsl:template match="/"><xsl:apply-templates select="ICD10CM_tabular"/></xsl:template>
	
<xsl:template match="ICD10CM_tabular">

	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="name(node())"/></xsl:call-template>
	<xsl:text>&#10;&#13;</xsl:text>
	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="local-name(node())"/></xsl:call-template>
	<xsl:text>&#10;&#13;</xsl:text>

	<xsl:call-template name="T-version"></xsl:call-template>
	<xsl:for-each select="chapter">
		<xsl:value-of select="chapter"/>
		<xsl:call-template name="T-chapter"></xsl:call-template>
	</xsl:for-each>
</xsl:template>

<xsl:template name="T-version">
	<xsl:value-of select="version"/>
	<xsl:text>&#10;&#13;</xsl:text>
</xsl:template>

<xsl:template name="T-introduction">
	<xsl:value-of select="introduction"/> |
	<xsl:text>&#10;&#13;</xsl:text>
</xsl:template>

<!--
     Creating a template to extract information about the Chapters
-->
<!--
	<xsd:complexType name="chapterType">
		<xsd:sequence>
			<xsd:element ref="name" minOccurs="0" maxOccurs="1"/>
			<xsd:element ref="desc" minOccurs="0" maxOccurs="1"/>
			<xsd:choice minOccurs="0" maxOccurs="unbounded">
				<xsd:element ref="inclusionTerm" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="sevenChrNote" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="sevenChrDef" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="includes" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="excludes1" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="excludes2" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="codeFirst" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="useAdditionalCode" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="codeAlso" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="notes" minOccurs="0" maxOccurs="unbounded"/>
				<xsd:element ref="sectionIndex" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="section" minOccurs="0" maxOccurs="unbounded"/>
			</xsd:choice>
		</xsd:sequence>
	</xsd:complexType>
	
-->

<xsl:template name="T-chapter">
	<xsl:call-template name="Formato"><xsl:with-param name="valor" select="name(parent::node())"/></xsl:call-template>
	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="../version"/></xsl:call-template>
	<!-- name -->
	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="name(node())"/></xsl:call-template>
	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="name"/></xsl:call-template>
	<!-- desc -->
	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="name(node())"/></xsl:call-template>
	<xsl:call-template name="Node_Format"><xsl:with-param name="Node_Value" select="desc"/></xsl:call-template>
	
	<xsl:text>&#10;&#13;</xsl:text>

	<!-- inclusionTerm --> 
	<!-- sevenChrNote -->
	<!-- sevenChrDef" -->
	<!-- includes --> 
	<!-- includes = <xsl:value-of select="includes"/> |	-->
	<xsl:choose>
		<xsl:when test="includes">
			<xsl:call-template name="T-noteType">
				<xsl:with-param name="V-variable" select="includes"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="includes"/></xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
	<!-- excludes1 --> 
    <!-- excludes1 = <xsl:value-of select="excludes1"/> |	-->
	<xsl:choose>
		<xsl:when test="excludes1">
			<xsl:call-template name="T-noteType">
				<xsl:with-param name="V-variable" select="excludes1"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="excludes1"/></xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
	<!-- excludes2 --> 
	<xsl:call-template name="T-noteType">
		<xsl:with-param name="V-variable" select="excludes2"/>
	</xsl:call-template>
	<!-- codeFirst -->
	<!-- useAdditionalCode-->
	<xsl:choose>
		<xsl:when test="useAdditionalCode">
			<xsl:call-template name="T-noteType">
				<xsl:with-param name="V-variable" select="useAdditionalCode"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>
Empty
			</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
<!--	
				<xsd:element ref="codeAlso" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="notes" minOccurs="0" maxOccurs="unbounded"/>
				<xsd:element ref="sectionIndex" minOccurs="0" maxOccurs="1"/>
				<xsd:element ref="section" minOccurs="0" maxOccurs="unbounded"/>
-->	
</xsl:template>

<!--
	************************************************
	Template for noteType Nodes
	<xsl:call-template name="T-noteType">
		<xsl:with-param name="V-variable" select="parent_note_name"/>
		like this:                        select="excludes2"
	</xsl:call-template>
	************************************************
	
	<xsd:complexType name="noteType">
	<xsd:sequence>
		<xsd:element ref="note" minOccurs="0" maxOccurs="unbounded"/>
	</xsd:sequence>
	</xsd:complexType>
	<xsd:element type="noteType" name="inclusionTerm"/>
	<xsd:element type="noteType" name="sevenChrNote"/>
	<xsd:element type="noteType" name="includes"/>
	<xsd:element type="noteType" name="excludes1"/>
	<xsd:element type="noteType" name="excludes2"/>
	<xsd:element type="noteType" name="codeFirst"/>
	<xsd:element type="noteType" name="useAdditionalCode"/>
	<xsd:element type="noteType" name="codeAlso"/>
	<xsd:element type="noteType" name="notes"/>
	<xsd:element type="noteType" name="instruction"/>
-->
<xsl:template name="T-noteType">
	<xsl:param name="V-variable"/>
	<xsl:for-each select="$V-variable/note">
		<!-- Display the content and the parent node name -->
		<!-- <xsl:value-of select="name(parent::node())"/> | <xsl:value-of select="."/> | -->
		<!-- Formatting the Node -->
		<xsl:call-template name="Formato"><xsl:with-param name="valor" select="name(parent::node())"/></xsl:call-template>
		<xsl:call-template name="Formato"><xsl:with-param name="valor" select="."/></xsl:call-template>
		<xsl:text>&#10;&#13;</xsl:text>
	</xsl:for-each>		
</xsl:template>


<xsl:template match="Emisor">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@rfc"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@nombre"/></xsl:call-template>
<xsl:apply-templates select="./DomicilioFiscal"/>
<xsl:if test="./ExpedidoEn"><xsl:call-template name="Domicilio"><xsl:with-param name="Nodo" select="./ExpedidoEn"/></xsl:call-template></xsl:if>
</xsl:template>

<xsl:template match="Receptor">
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@rfc"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@nombre"/></xsl:call-template>
<xsl:call-template name="Domicilio"><xsl:with-param name="Nodo" select="./Domicilio"/></xsl:call-template>
</xsl:template>

<xsl:template match="Retencion">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@impuesto"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@importe"/></xsl:call-template>
</xsl:template>

<xsl:template match="Traslado">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@impuesto"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@importe"/></xsl:call-template>
</xsl:template>

<xsl:template match="Concepto">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@cantidad"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@unidad"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@descripcion"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@valorUnitario"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@importe"/></xsl:call-template>
<xsl:if test="./InformacionAduanera"><xsl:apply-templates select="./InformacionAduanera"/></xsl:if>
<xsl:if test="./CuentaPredial"><xsl:apply-templates select="./CuentaPredial"/></xsl:if>
</xsl:template>

<xsl:template match="InformacionAduanera">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@numero"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@fecha"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@aduana"/></xsl:call-template>
</xsl:template>

<xsl:template match="CuentaPredial">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@numero"/></xsl:call-template>
</xsl:template>

<xsl:template match="DomicilioFiscal">
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@calle"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@noExterior"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@noInterior"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@colonia"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@localidad"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="./@referencia"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@municipio"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@estado"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@pais"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="./@codigoPostal"/></xsl:call-template>
</xsl:template>

<xsl:template name="Domicilio">
<xsl:param name="Nodo"/>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="$Nodo/@calle"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@noExterior"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@noInterior"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@colonia"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@localidad"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@referencia"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@municipio"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@estado"/></xsl:call-template>
<xsl:call-template name="Formato"><xsl:with-param name="valor" select="$Nodo/@pais"/></xsl:call-template>
<xsl:call-template name="Opcional"><xsl:with-param name="valor" select="$Nodo/@codigoPostal"/></xsl:call-template>
</xsl:template>


<xsl:template name="Formato"><xsl:param name="valor"/>|<xsl:call-template name="Trim"><xsl:with-param name="s" select="$valor"/></xsl:call-template></xsl:template>
