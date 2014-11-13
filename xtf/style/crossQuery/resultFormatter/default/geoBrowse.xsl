<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <xsl:template name="generateMapLayers">
    <xsl:text>var resultBounds = [];</xsl:text>
    <xsl:apply-templates select="(//geoLocationPoint|//geoLocationBox)"
      mode="makeLayers"/>
    <xsl:text>map.fitBounds(resultBounds); </xsl:text>
  </xsl:template>

  <xsl:template match="geoLocationPoint" mode="makeLayers">
    <xsl:variable name="coord" select="tokenize(text(),' ')"/>
    <xsl:variable name="coordPair">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="$coord[1]"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="$coord[2]"/>
      <xsl:text>]</xsl:text>
    </xsl:variable>
    <xsl:text>resultBounds.push(</xsl:text>
    <xsl:value-of select="$coordPair"/>
    <xsl:text>); </xsl:text>
    <xsl:text>L.marker(</xsl:text>
    <xsl:value-of select="$coordPair"/>
    <xsl:text>).addTo(map).bindPopup('</xsl:text>
    <xsl:call-template name="makePopup"/>
    <xsl:text>'); </xsl:text>
  </xsl:template>

  <xsl:template match="geoLocationBox" mode="makeLayers">
    <xsl:variable name="coords" select="tokenize(text(),' ')"/>
    <xsl:variable name="swCoordPair">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="$coords[1]"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="$coords[2]"/>
      <xsl:text>]</xsl:text>
    </xsl:variable>
    <xsl:variable name="neCoordPair">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="$coords[3]"/>
      <xsl:text>,</xsl:text>
      <xsl:value-of select="$coords[4]"/>
      <xsl:text>]</xsl:text>
    </xsl:variable>
    <xsl:text>resultBounds.push([</xsl:text>
    <xsl:value-of select="$swCoordPair"/>
    <xsl:text>,</xsl:text>
    <xsl:value-of select="$neCoordPair"/>
    <xsl:text>]); </xsl:text>
    <xsl:text>L.rectangle([</xsl:text>
    <xsl:value-of select="$swCoordPair"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$neCoordPair"/>
    <!-- The weight attribute sets the line width of the rectangle's border. -->
    <xsl:text>], { weight: 2 }).addTo(map).bindPopup('</xsl:text>
    <xsl:call-template name="makePopup"/>
    <xsl:text>'); </xsl:text>
  </xsl:template>

  <xsl:template name="setBounds"> 
    <xsl:param name="layersAmt" as="xs:integer" required="yes"/>
    <xsl:if test="$layersAmt > 0">
      
      <xsl:call-template name="setBounds">
        <xsl:with-param name="layersAmt">
          <xsl:value-of select="$layersAmt - 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="makePopup">
    <xsl:apply-templates select="ancestor::docHit">
      <xsl:with-param name="browse-type">mapPopup</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>



  <!-- ====================================================================== -->
  <!-- geoBrowsePage Template		                                           		-->
  <!-- ====================================================================== -->
  <xsl:template name="browseLocation" exclude-result-prefixes="#all">
    <xsl:call-template name="skeleton-browse">
      <xsl:with-param name="browse-type">locations</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
