<?xml version="1.0" encoding="UTF-8"?>
<!-- HTML style sheet for movie-watcher XML (template format) -->
<!-- Written by Keith Wood, 4 June 1999 -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <!-- Main document template -->
  <xsl:template match="/">
    <html>
      <body>
        <h1><a name="top">Welcome to Movie Watchers</a></h1>
        <p>Your source for local film entertainment.
          Have a look at <a href="#movies">what's on</a>,
          <a href="#cinemas">where</a> and 
          <a href="#screenings">when</a>.</p>
        <hr/>
        <h2><a name="movies">Movies</a></h2>
        <xsl:apply-templates select="//movie">
          <xsl:sort select="name"/>
        </xsl:apply-templates>
        <p>Back to <a href="#top">the top</a>.</p>
        <hr/>
        <h2><a name="cinemas">Cinemas</a></h2>
        <xsl:apply-templates select="//cinema">
          <xsl:sort select="name"/>
        </xsl:apply-templates>
        <p>Back to <a href="#top">the top</a>.</p>
        <hr/>
        <h2><a name="screenings">Screenings</a></h2>
        <xsl:apply-templates select="//screening">
          <xsl:sort select="id(@movie-id)/name"/>
          <xsl:sort select="id(@cinema-id)/name"/>
        </xsl:apply-templates>
        <p>Back to <a href="#top">the top</a>.</p>
        <hr/>
        <p>Movie Watcher data supplied by
          <a href="mailto:kbwood@iprimus.com.au">Keith Wood</a>.</p>
      </body>
    </html>
  </xsl:template>

  <!-- Details for one movie -->
  <xsl:template match="movie">
    <!-- Provide link target and optional web link -->
    <a name="{@id}">
      <xsl:if test="@url">
        <xsl:attribute name="href">
          <xsl:value-of select="unparsed-entity-uri(@url)"/></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@logo-url">
          <img src="{unparsed-entity-uri(@logo-url)}" alt="{name}"/>
        </xsl:when>
        <xsl:otherwise>
          <h3><xsl:value-of select="name"/></h3>
        </xsl:otherwise>
      </xsl:choose>
    </a>
    <table border="0" width="100%">
      <tr>
        <th align="left" valign="top" width="15%">Rating:</th>
        <td width="15%"><xsl:value-of select="@rating"/></td>
        <th align="left" valign="top" width="15%">Length:</th>
        <td><xsl:value-of select="length"/> mins</td>
      </tr>
      <tr>
        <th align="left" valign="top">Director:</th>
        <td colspan="3"><xsl:value-of select="director"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Starring:</th>
        <td colspan="3"><xsl:apply-templates select="starring/star"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Synopsis:</th>
        <td colspan="3"><xsl:value-of select="synopsis"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Showing at:</th>
        <td colspan="3">
          <xsl:apply-templates select="//screening[@movie-id=current()/@id]"
            mode="link-cinema"/>
        </td>
      </tr>
    </table>
  </xsl:template>
           
  <!-- List each star -->
  <xsl:template match="star">
    <xsl:value-of select="."/><br/>
  </xsl:template>

  <!-- Details for one cinema -->
  <xsl:template match="cinema">
    <a name="{@id}">
      <xsl:if test="@url">
        <xsl:attribute name="href">
          <xsl:value-of select="unparsed-entity-uri(@url)"/></xsl:attribute>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="@logo-url">
          <img src="{unparsed-entity-uri(@logo-url)}" alt="{name}"/>
        </xsl:when>
        <xsl:otherwise>
          <h3><xsl:value-of select="name"/></h3>
        </xsl:otherwise>
      </xsl:choose>
    </a>
    <table border="0" width="100%">
      <tr>
        <th align="left" valign="top" width="15%">Phone:</th>
        <td><xsl:value-of select="phone"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Address:</th>
        <td><xsl:value-of select="address"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Directions:</th>
        <td><xsl:value-of select="directions"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Facilities:</th>
        <td>
          <xsl:if test="facilities/candy-bar">
            Candy bar<br/>
          </xsl:if>
          <xsl:if test="facilities/disabled-access">
            Disabled access<br/>
          </xsl:if>
        </td>
      </tr>
      <tr>
        <th align="left" valign="top">Pricing:</th>
        <td>
          <table border="1" cellpadding="3">
            <tr>
              <th>Name</th>
              <th>Times</th>
              <th>Adult</th>
              <th>Child</th>
              <th>Discount</th>
            </tr>
            <xsl:apply-templates select="pricing/prices"/>
          </table>
        </td>
      </tr>
      <tr>
        <th align="left" valign="top">Showing:</th>
        <td>
          <xsl:apply-templates select="//screening[@cinema-id=current()/@id]"
            mode="link-movie"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- Table of pricing schemes -->
  <xsl:template match="prices">
    <tr>
      <td><a name="{@id}"><xsl:value-of select="name"/></a></td>
      <td><xsl:value-of select="period"/></td>
      <td align="right"><xsl:value-of select="adult"/></td>
      <td align="right"><xsl:value-of select="child"/></td>
      <td align="right"><xsl:value-of select="discount"/></td>
    </tr>
  </xsl:template>

  <!-- Details for one screening -->
  <xsl:template match="screening">
    <a name="{@movie-id}-{@cinema-id}">
      <h3>
        <a href="#{@movie-id}"><xsl:value-of select="id(@movie-id)/name"/></a> at 
        <a href="#{@cinema-id}"><xsl:value-of select="id(@cinema-id)/name"/></a>
      </h3>
    </a>
    <table border="0" width="100%">
      <tr>
        <th align="left" valign="top" width="15%">Dates:</th>
        <td><xsl:value-of select="start-date"/>-<xsl:value-of select="end-date"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Features:</th>
        <td>Digital sound: <xsl:value-of select="features/digital-sound"/></td>
      </tr>
      <tr>
        <th align="left" valign="top">Restrictions:</th>
        <td>
          <xsl:choose>
            <xsl:when test="restrictions/no-passes">
              No passes
            </xsl:when>
            <xsl:otherwise>
              None
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
      <tr>
        <th align="left" valign="top">Sessions:</th>
        <td>
          <table border="1" cellpadding="3">
            <tr>
              <th>Time</th>
              <th>Pricing</th>
            </tr>
            <xsl:apply-templates select="sessions/session"/>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- Link to screening for movie -->
  <xsl:template match="screening" mode="link-movie">
            <a href="#{@movie-id}-{@cinema-id}">
              <xsl:value-of select="id(@movie-id)/name"/></a><br/>
  </xsl:template>

  <!-- Link to screening for cinema -->
  <xsl:template match="screening" mode="link-cinema">
            <a href="#{@movie-id}-{@cinema-id}">
              <xsl:value-of select="id(@cinema-id)/name"/></a><br/>
  </xsl:template>

  <!-- Table of session details -->
  <xsl:template match="session">
    <tr>
      <td><xsl:value-of select="."/></td>
      <td>
        <a href="#{@price-id}"><xsl:value-of select="id(@price-id)/name"/></a>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>