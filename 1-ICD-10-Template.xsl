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
	Public declarations and global processes
-->
<xsl:variable name="delimiter" select="'|'"/>

<xsl:strip-space elements="*"/>

<!--
	Includes
-->

<!--
     Initial Global Template
-->
<xsl:template match="/">
	<xsl:copy>
		<!--	
			Data
		-->		
		<!-- 
		=========================================================================================
			Chapter
		=========================================================================================
		-->
		<!-- 
			Chapter Table 
			<xsl:apply-templates select="//chapter" mode="table"></xsl:apply-templates>

			Header definition:
			version | chapter | name
		-->
		<!-- 
			Chapter NoteType Table 
			<xsl:apply-templates select="//chapter/child::node()/note" mode="table"></xsl:apply-templates>

			Header definition:
			chapter | notetype | note

		-->

		<!-- 
		=========================================================================================
			Section 
		=========================================================================================
		-->
		<!-- 
			Section Index Table 
			<xsl:apply-templates select="//chapter/sectionIndex" mode="table"></xsl:apply-templates>

			Header definition:
			chapter | group_id | first_id | last_id | description

			Export example:
			"1"|"B99"|"B99"|"B99"|"Other infectious diseases"
			"2"|"C00-C14"|"C00"|"C14"|"Malignant neoplasms of lip, oral cavity and pharynx"
			
		-->

		<!-- 
			Section desc Table 
			<xsl:apply-templates select="//chapter/section/desc" mode="table"></xsl:apply-templates>
			
			Header definition:
			chapter | section_id | description

			Export example:
			"1"|"B99"|"Other infectious diseases (B99)"
			"2"|"C00-C96"|"Malignant neoplasms (C00-C96)"
			"2"|"C00-C75"|"Malignant neoplasms, stated or presumed to be primary (of specified sites), and certain specified histologies, except neuroendocrine, and of lymphoid, hematopoietic and related tissue (C00-C75)"
			"2"|"C00-C14"|"Malignant neoplasms of lip, oral cavity and pharynx (C00-C14)"
			"2"|"C15-C26"|"Malignant neoplasms of digestive organs (C15-C26)"
			
		-->

		<!-- 
		=========================================================================================
			Diagnostic 
		=========================================================================================
		-->
		
		<!-- 
			Section diagnostic Table:
			<xsl:apply-templates select="//chapter/section/diag/name | //chapter/section/diag/desc" mode="table"></xsl:apply-templates>
			or
			<xsl:apply-templates select="(//diag/name | //diag/desc)" mode="table"></xsl:apply-templates>

			Header definition:
			diag_par | diag_id | reportable | description
			Export example:
			""|"A02"|No|"Other salmonella infections"
			"A02"|"A02.0"|Yes|"Salmonella enteritis"
			"A02"|"A02.1"|Yes|"Salmonella sepsis"
			"A02"|"A02.2"|No|"Localized salmonella infections"
			"A02.2"|"A02.20"|Yes|"Localized salmonella infection, unspecified"
		-->
			<xsl:apply-templates select="(//diag/name | //diag/desc)" mode="table"></xsl:apply-templates>
		<!-- 
			Section diagnostic notes Table:
			<xsl:apply-templates select="//chapter/section/diag//note" mode="table"></xsl:apply-templates>
			Header definition:
			diag_id | noteType | note
		-->
		
		
	</xsl:copy>

</xsl:template>

<xsl:template match="chapter" mode="table">
	<xsl:copy>
		<xsl:apply-templates select="./name | ./desc" mode="table">
		</xsl:apply-templates>
	</xsl:copy>

</xsl:template>



<!--
	//chapter/sectionIndex
-->
<xsl:template match="sectionIndex">
	<xsl:copy>
		<xsl:apply-templates select="./sectionRef">
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>

<!--
	//chapter/sectionIndex/sectionRef
-->
<xsl:template match="sectionIndex/sectionRef">
	<!-- Range -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="./@id"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="./@first"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="./@last"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
    <!-- Description -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="sectionIndex/sectionRef" mode="table">
	<!-- Chapter -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="../../name"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>
	<!-- Range -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="./@id"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="./@first"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="./@last"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
    <!-- Description -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--
	//chapter/section
-->
<xsl:template match="section/desc">
	<xsl:copy>
		<xsl:apply-templates select=".">
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>

<xsl:template match="section/desc" mode="table">

	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="../../name"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>
	
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="../@id"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>

	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="section/diag">
	<xsl:copy>
		<xsl:apply-templates select="./diag">
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>


<!--
	Based on the xsd definition
	
	<xsd:element type="contentType" name="note"/>
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


<xsl:template match="inclusionTerm|sevenChrNote|includes|excludes1|excludes2|codeFirst|useAdditionalCode|notes|instruction">
	<xsl:copy>
		<xsl:apply-templates select="./note">
		</xsl:apply-templates>
	</xsl:copy>
</xsl:template>

<!--
	Based on the xsd definition
	
	<xsd:element type="contentType" name="version"/>
	<xsd:element type="contentType" name="title"/>
	<xsd:element type="contentType" name="name"/>
	<xsd:element type="contentType" name="desc"/>
	<xsd:element type="contentType" name="note"/>
	<xsd:element type="contentType" name="diff"/>
-->
<xsl:template match="version|title|name|desc|note|diff" mode="local">
	<xsl:text>Parent-&gt;</xsl:text>
	<xsl:value-of select="local-name(parent::node())"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="../../name"/>
	<xsl:value-of select="parent::node()/name"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>

	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!--
     id Notes with Classification
	 id | noteType | note
-->
<xsl:template match="note" mode="table">
	<!-- id -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="../../name"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>
	
	<!-- noteType -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="local-name(parent::node())"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
	
	<!-- note -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


<!--
    Key assembly to reach parent levels
-->
<xsl:template match="diag/name" mode="table">
<!--	
	<xsl:text>Parent-&gt;</xsl:text>
	<xsl:value-of select="local-name(parent::node())"/>
-->	
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="../../name"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="parent::node()/name"/>
	<xsl:text>&quot;</xsl:text>	
	<xsl:value-of select="$delimiter"/>

	<!-- Reportable -->
	<xsl:choose>
		<xsl:when test="../diag/*">
			<xsl:text>No</xsl:text>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>Yes</xsl:text>	
		</xsl:otherwise>
	</xsl:choose>

	<xsl:value-of select="$delimiter"/>

</xsl:template>

<xsl:template match="name" mode="local">
	<xsl:value-of select="local-name(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<!-- Standarize the field and adds the delimiter -->
<xsl:template match="version" mode="table">
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
</xsl:template>

<xsl:template match="chapter/name" mode="table">
	<!-- Version -->
	<xsl:copy>
		<xsl:apply-templates select="parent::node()/parent::node()/version" mode="table">
		</xsl:apply-templates>
	</xsl:copy>

	<!-- Chapter -->
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="."/>
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="$delimiter"/>
</xsl:template>

<xsl:template match="desc" mode="table">	
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>

<xsl:template match="desc" mode="local">
	
	<xsl:text>&quot;</xsl:text>
	<xsl:value-of select="normalize-space(.)"/>
	<xsl:text>&quot;</xsl:text>
	<xsl:text>&#13;&#10;</xsl:text>
</xsl:template>


	
</xsl:stylesheet>
