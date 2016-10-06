<?xml version="1.0" encoding="UTF-8"?>
<!-- RTF style sheet for movie-watcher XML
     Written by Keith Wood, 20 May 2000 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text"/>

  <!-- Match the entire document -->
  <xsl:template match="/">{\rtf1\ansi\ansicpg1252\uc1
\deff0\deflang1033\deflangfe1033
{\fonttbl{\f0\froman\fcharset0\fprq2{\*\panose 02020603050405020304}Times New Roman;}{\f1\fswiss\fcharset0\fprq2{\*\panose 020b0604020202020204}Arial;}}
{\colortbl;\red0\green0\blue0;\red0\green0\blue255;\red0\green255\blue255;\red0\green255\blue0;
\red255\green0\blue255;\red255\green0\blue0;\red255\green255\blue0;\red255\green255\blue255;\red0\green0\blue128;\red0\green128\blue128;\red0\green128\blue0;\red128\green0\blue128;\red128\green0\blue0;\red128\green128\blue0;\red128\green128\blue128;
\red192\green192\blue192;}
{\stylesheet{\sb100\sa100\nowidctlpar\adjustright \snext0 Normal;}{\*\cs10 \additive Default Paragraph Font;}{\s18\sb100\sa100\keepn\nowidctlpar\outlinelevel1\adjustright \b\fs48\kerning36 \sbasedon0 \snext0 H1;}{\s19\sb100\sa100\keepn\nowidctlpar\outlinelevel2\adjustright \b\fs36 
\sbasedon0 \snext0 H2;}{\s20\sb100\sa100\keepn\nowidctlpar\outlinelevel3\adjustright \b\fs28 \sbasedon0 \snext0 H3;}}
{\info{\title Movie Watchers}{\author movie-watcher-rtf.xsl}}
\pard\plain \s18\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs48\kerning36
{Welcome to Movie Watchers\par}
\pard\plain \sb100\sa100\nowidctlpar\outlinelevel0\adjustright 
{Your source for local film entertainment.\par}
\pard\plain \s19\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs36 {Movies\par}
<!-- Display each movie's details -->
<xsl:for-each select="//movie">
  <xsl:sort select="name"/>
\pard\plain \s20\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs28
{<xsl:value-of select="name"/>\par}
\trowd \clvertalt\cltxlrtb \cellx1520\clvertalc\cltxlrtb \cellx4485\clvertalt\cltxlrtb \cellx7450\clvertalc\cltxlrtb \cellx9359\pard\plain \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Rating:\cell}
\pard\plain \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="@rating"/>\cell}
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Length:\cell }
\pard\plain \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="length"/> mins\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\trowd \clvertalt\cltxlrtb \cellx1520\clmgf\clvertalc\cltxlrtb \cellx4485\clmrg\clvertalc\cltxlrtb \cellx7450 \clmrg\clvertalc\cltxlrtb \cellx9359\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Director:\cell }
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="director"/>\cell \cell \cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}\pard 
\qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Starring:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {
<xsl:for-each select="starring/star">
<xsl:value-of select="."/><xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
\cell \cell \cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Synopsis:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="synopsis"/>\cell \cell \cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\trowd \clvertalt\cltxlrtb \cellx1520\clmgf\clvertalc\cltxlrtb \cellx4485\clmrg\clvertalc\cltxlrtb \cellx7450\clmrg\clvertalc\cltxlrtb \cellx9359
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Showing at:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {
<xsl:for-each select="//screening[@movie-id=current()/@id]">
<xsl:value-of select="id(@cinema-id)/name"/><xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
\cell \cell \cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
</xsl:for-each>
\pard\plain \s19\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs36 {Cinemas\par}
<!-- Display each cinema's details -->
<xsl:for-each select="//cinema">
  <xsl:sort select="name"/>
\pard\plain \s20\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs28 {<xsl:value-of select="name"/>\par}
\trowd \clvertalt\cltxlrtb \cellx1854\clvertalc\cltxlrtb \cellx9359\pard\plain \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Phone:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="phone"/>\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\trowd \clvertalt\cltxlrtb \cellx1854\clvertalc\cltxlrtb \cellx9359\pard 
\qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Address:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="address"/>\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Directions:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="directions"/>\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Facilities:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {
<xsl:if test="facilities/candy-bar">Candy bar,</xsl:if>
<xsl:if test="facilities/disabled-access">Disabled access,</xsl:if>
\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\trowd \trkeep \clvmgf\clvertalt\cltxlrtb \cellx1854\clvertalc\cltxlrtb \cellx3076\clvertalc\cltxlrtb \cellx6589
\clvertalc\cltxlrtb \cellx7353\clvertalc\cltxlrtb \cellx8117\clvertalc\cltxlrtb \cellx9359\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Pricing:\cell \b Name\cell Times\cell Adult\cell Child\cell Discount\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\b \row}
\trowd \trkeep \clvmrg\clvertalt\cltxlrtb \cellx1854\clvertalc\cltxlrtb \cellx3076\clvertalc\cltxlrtb \cellx6589\clvertalc\cltxlrtb \cellx7353\clvertalc\cltxlrtb \cellx8117\clvertalc\cltxlrtb 
\cellx9359\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright 
<xsl:for-each select="pricing/prices">
{\b \cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {<xsl:value-of select="name"/>\cell <xsl:value-of select="period"/>\cell}
\pard \qr\sb100\sa100\nowidctlpar\intbl\adjustright {$<xsl:value-of select="adult"/>\cell $<xsl:value-of select="child"/>\cell $<xsl:value-of select="discount"/>\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
</xsl:for-each>
\trowd \clvertalt\cltxlrtb \cellx1854 \clvertalc\cltxlrtb \cellx9359\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Showing:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {
<xsl:for-each select="//screening[@cinema-id=current()/@id]">
<xsl:value-of select="id(@movie-id)/name"/><xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
</xsl:for-each>
\pard\plain \s19\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs36 
{Screenings\par}
<!-- Display each screening's details -->
<xsl:for-each select="//screening">
  <xsl:sort select="id(@movie-id)/name"/>
  <xsl:sort select="id(@cinema-id)/name"/>
\pard\plain \s20\sb100\sa100\keepn\nowidctlpar\outlinelevel0\adjustright \b\fs28
{<xsl:value-of select="id(@movie-id)/name"/> at <xsl:value-of select="id(@cinema-id)/name"/>\par}
\trowd \clvertalt\cltxlrtb \cellx3912\clvertalc\cltxlrtb \cellx9360\pard\plain \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Dates:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright 
{<xsl:value-of select="start-date"/>-<xsl:value-of select="end-date"/>\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\trowd \clvertalt\cltxlrtb \cellx3912\clvertalc\cltxlrtb \cellx9360\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Features:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright 
{Digital sound: <xsl:value-of select="features/digital-sound"/>\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright {\b Restrictions:\cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright {
<xsl:choose>
  <xsl:when test="restrictions/no-passes">No passes</xsl:when>
  <xsl:otherwise>None</xsl:otherwise>
</xsl:choose>
\cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
\trowd \trkeep \clvmgf\clvertalt\cltxlrtb \cellx3912\clvertalc\cltxlrtb \cellx5256\clvertalc\cltxlrtb \cellx6984\clvmgf\clvertalc\cltxlrtb \cellx9360
\pard \qc\sb100\sa100\nowidctlpar\intbl\adjustright 
{\b Sessions:\cell \b Time\cell Pricing\cell \cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\b \row}
\trowd \trkeep \clvmrg\clvertalt\cltxlrtb \cellx3912\clvertalc\cltxlrtb \cellx5256\clvertalc\cltxlrtb \cellx6984\clvmrg\clvertalc\cltxlrtb \cellx9360\pard 
\qc\sb100\sa100\nowidctlpar\intbl\adjustright 
<xsl:for-each select="sessions/session">
{\b \cell}
\pard \sb100\sa100\nowidctlpar\intbl\adjustright
{<xsl:value-of select="."/>\cell <xsl:value-of select="id(@price-id)/name"/>\cell \cell}
\pard \nowidctlpar\widctlpar\intbl\adjustright {\row}
</xsl:for-each>
</xsl:for-each>
\pard\plain \sb100\sa100\nowidctlpar\outlinelevel0\adjustright 
{Movie Watcher data supplied by Keith Wood (kbwood@iprimus.com.au)\par}}
</xsl:template>
</xsl:stylesheet>