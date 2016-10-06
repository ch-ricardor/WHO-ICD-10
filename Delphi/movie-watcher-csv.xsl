<?xml version="1.0" encoding="UTF-8"?>
<!-- Straight text style sheet for movie-watcher XML
     Multiple comma-separated value lists
     Written by Keith Wood, 30 May 2000 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <!-- Main document template -->
  <xsl:template match="/">"Name","Rating","Length","Director","Stars","Synopsis"
<xsl:apply-templates select="//movie">
  <xsl:sort select="name"/>
</xsl:apply-templates>
------------------------------------------------------------------------------------------------
"Name","Phone","Address","Directions","Facilities"
<xsl:apply-templates select="//cinema">
  <xsl:sort select="name"/>
</xsl:apply-templates>
------------------------------------------------------------------------------------------------
"Movie","Cinema","Dates","Features","Restrictions","Sessions"
<xsl:apply-templates select="//screening">
  <xsl:sort select="id(@movie-id)/name"/>
  <xsl:sort select="id(@cinema-id)/name"/>
</xsl:apply-templates>
  </xsl:template>

  <!-- Details for one movie -->
  <xsl:template match="movie">"<xsl:value-of select="name"/>","<xsl:value-of select="@rating"/>","<xsl:value-of select="length"/>","<xsl:value-of select="director"/>","<xsl:apply-templates select="starring/star"/>","<xsl:value-of select="translate(synopsis,'&quot;',&quot;'&quot;)"/>"
</xsl:template>

  <!-- Details for each star -->
  <xsl:template match="star"><xsl:value-of select="."/><xsl:if test="position()!=last()">,</xsl:if></xsl:template>

  <!-- Details for one cinema -->
  <xsl:template match="cinema">"<xsl:value-of select="name"/>","<xsl:value-of select="phone"/>","<xsl:value-of select="address"/>","<xsl:value-of select="directions"/>","<xsl:if test="facilities/candy-bar">Candy bar,</xsl:if><xsl:if test="facilities/disabled-access">Disabled access</xsl:if>"
</xsl:template>

  <!-- Table of pricing schemes -->
  <xsl:template match="prices">"<xsl:value-of select="name"/>","<xsl:value-of select="period"/>","<xsl:value-of select="adult"/>","<xsl:value-of select="child"/>","<xsl:value-of select="discount"/>"
</xsl:template>

  <!-- Details for one screening -->
  <xsl:template match="screening">"<xsl:value-of select="id(@movie-id)/name"/>","<xsl:value-of select="id(@cinema-id)/name"/>","<xsl:value-of select="start-date"/>-<xsl:value-of select="end-date"/>","<xsl:if test="features/digital-sound">Digital sound: <xsl:value-of select="features/digital-sound"/></xsl:if>","<xsl:if test="restrictions/no-passes">No passes</xsl:if>","<xsl:apply-templates select="sessions/session"/>"
</xsl:template>

  <!-- Table of session details -->
  <xsl:template match="session"><xsl:value-of select="."/><xsl:if test="position()!=last()">,</xsl:if></xsl:template>
</xsl:stylesheet>