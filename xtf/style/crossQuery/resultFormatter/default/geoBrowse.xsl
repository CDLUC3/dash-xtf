<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

  <!-- ====================================================================== -->
  <!-- geoBrowsePage Template		                                           		-->
  <!-- ====================================================================== -->
  <xsl:template name="browseLocation" exclude-result-prefixes="#all">
    <xsl:choose>
      <!-- If there's a docId parameter, build the record-specific 
        geographic interface. -->
      <xsl:when test="$docId">
        <xsl:call-template name="viewRecordLocations"/>
      </xsl:when>
      <!-- Otherwise, generate the Locations page using the 
        skeleton Browse template. -->
      <xsl:otherwise>
        <xsl:call-template name="skeleton-browse">
          <xsl:with-param name="browse-type">locations</xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- A version of the Browse interface intended to showcase the 
    locations associated with a single record. The search and facet 
    features in skeleton-browse have been removed. -->
  <xsl:template name="viewRecordLocations">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <title>Dash</title>
        <xsl:copy-of select="$assets.htmlhead"/>
        <xsl:copy-of select="$assets.leaflet-map"/>
        <xsl:copy-of select="$brand.googleanalytics"/>
      </head>
      <body>
        <!-- begin page id -->
        <div id="browse-locations-page"> 
          <!-- begin outer container -->  
          <div id="outer-container"> 
            <!-- begin inner container -->
            <div id="inner-container"> 
              <!-- begin header -->
              <div class="header">
                <xsl:call-template name="brandheader"/>
                <div id="navbar">
                  <xsl:copy-of select="$assets.nav-header"/>
                  <xsl:call-template name="navheader"/>
                </div>
              </div>
              <div id="banner">
                <img width="952" height="72" alt="Publish and Download Research Datasets" src="assets/img/banner-home-v8.0.jpg"></img>
              </div>
              <!-- begin content -->
              <div id="content">
                <div id="browse-locations-container">
                  <!-- The record title is the page header. -->
                  <h1><xsl:value-of select="//title"/></h1>
                  <div class="search-refine">
                    <div class="search-refine-controls">
                      <div class="search-form-area">
                          <!-- The Browse Locations button moves to the 
                            left-hand sidebar. -->
                          <div class="map-browse-button">
                            <a href="/xtf/search?browse-locations=yes">
                              <input type="image" src="assets/img/map-browse-button.png" alt="Explore by geoLocation"/>
                            </a>
                          </div>
                      </div>
                    </div>
                  </div>
                  <div class="search-results">
                  <!-- Replace the sort mechanism with a note on collection policy. -->
                  <div class="search-controls">
                    <span style="padding:5px">NOTE: Only data with assigned geoLocation values will appear in this map interface.</span>
                  </div>
                  <div id="map">
                    <script>
                      <xsl:text>initMap();</xsl:text>
                      <xsl:call-template name="generateMapLayers"/>
                    </script>
                  </div>
                    <div class="search-result">
                      <xsl:apply-templates select="//docHit">
                        <xsl:with-param name="browse-type">locations</xsl:with-param>
                      </xsl:apply-templates>
                    </div>
                  </div>
                </div>
              </div>
              <xsl:copy-of select="$assets.nav-footer"/>
              <xsl:copy-of select="$brand.footer"/>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <!-- Write Javascript to populate the map. -->
  <xsl:template name="generateMapLayers">
    <!-- Create an array of map features. -->
    <xsl:text>var markers = []; </xsl:text>
    <xsl:text>var rectangles = [];</xsl:text>
    <!-- Ignore geoLocationPlace. -->
    <xsl:apply-templates select="(//geoLocationPoint|//geoLocationBox)"
      mode="makeLayers"/>
    <!-- Fit the map to all its features. -->
    <xsl:text>resultBounds = markers.concat(rectangles);</xsl:text>
    <xsl:text>map.fitBounds(resultBounds); </xsl:text>
  </xsl:template>
  
  <!-- Build a marker map feature from a geoLocationPoint. -->
  <xsl:template match="geoLocationPoint" mode="makeLayers">
    <xsl:variable name="coord" select="tokenize(text(),' ')"/>
    <xsl:variable name="coordPair">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="$coord[1]"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$coord[2]"/>
      <xsl:text>]</xsl:text>
    </xsl:variable>
    <!-- Write the Javascript command to populate the map. -->
    <xsl:text>L.marker(</xsl:text>
    <xsl:value-of select="$coordPair"/>
    <xsl:text>).addTo(map).bindPopup('</xsl:text>
    <xsl:call-template name="makePopup">
      <xsl:with-param name="geoInfo" select="$coordPair"/>
    </xsl:call-template>
    <xsl:text>'); </xsl:text>
    <!-- Add the new marker to the tracking array. -->
    <xsl:text>markers.push(</xsl:text>
    <xsl:value-of select="$coordPair"/>
    <xsl:text>); </xsl:text>
  </xsl:template>
  
  <!-- Build a rectangle map feature from a geoLocationBox. -->
  <xsl:template match="geoLocationBox" mode="makeLayers">
    <xsl:variable name="coords" select="tokenize(text(),' ')"/>
    <xsl:variable name="swCoordPair">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="$coords[1]"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$coords[2]"/>
      <xsl:text>]</xsl:text>
    </xsl:variable>
    <xsl:variable name="neCoordPair">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="$coords[3]"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$coords[4]"/>
      <xsl:text>]</xsl:text>
    </xsl:variable>
    <xsl:variable name="rectBounds">
      <xsl:value-of select="$swCoordPair"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="$neCoordPair"/>
    </xsl:variable>
    <xsl:text>var rectBounds = L.latLngBounds(</xsl:text><xsl:value-of select="$rectBounds"/><xsl:text>);</xsl:text>
    <!-- Write the Javascript command to populate the map. -->
    <!-- The weight attribute sets the line width of the rectangle's border. -->
    <xsl:text>newRectangle = L.rectangle(rectBounds, { weight: 2 }).addTo(map).bindPopup('</xsl:text>
    <xsl:call-template name="makePopup">
      <xsl:with-param name="geoInfo" select="$rectBounds"/>
    </xsl:call-template>
    <xsl:text>'); </xsl:text>
    <!-- If this rectangle contains a previously-created rectangle, move it a 
      layer below the older rectangle. -->
    <xsl:text>for (x in rectangles) { 
        oldRectangle = rectangles[x]; 
        if ( rectBounds.contains(oldRectangle.getLatLngs()) ) {
          newRectangle.bringBelow(oldRectangle); 
        }
      };
    </xsl:text>
    <!-- Add the new rectangle to the tracking array. -->
    <xsl:text>rectangles.push(newRectangle); </xsl:text>
  </xsl:template>
  
  <!-- Generate a feature's popup box with information about its 
    associated record. -->
  <xsl:template name="makePopup">
    <xsl:param name="geoInfo"/>
    <xsl:apply-templates select="ancestor::docHit">
      <xsl:with-param name="browse-type">mapPopup</xsl:with-param>
    </xsl:apply-templates>
    <!-- Show the coordinates of the feature. -->
    <xsl:text>This location: </xsl:text><xsl:value-of select="$geoInfo"/>
  </xsl:template>

</xsl:stylesheet>
