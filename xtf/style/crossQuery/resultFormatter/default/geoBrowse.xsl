<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  
  <xsl:variable name="oc-assets">
    <xsl:copy-of select="document('../../../../assets/oc-assets.xml')"/>
  </xsl:variable>
  <xsl:variable name="oc-assets.htmlhead" select="$oc-assets//htmlhead/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
  <xsl:variable name="oc-assets.nav-header" select="$oc-assets//nav-header/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
  <xsl:variable name="oc-assets.nav-footer" select="$oc-assets//nav-footer/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
  <xsl:variable name="oc-assets.about" select="$oc-assets//about/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
  <xsl:variable name="oc-assets.homelink" select="$oc-assets//ocdp-homelink/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>

  <!-- ====================================================================== -->
  <!-- browse-orangecounty Template		                                     		-->
  <!-- ====================================================================== -->
  <xsl:template match="crossQueryResult" mode="browseOC">
    <xsl:call-template name="skeleton-browse">
      <xsl:with-param name="browse-type">orangecounty</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- OC Data Portal home page Template		                                           	-->
  <!-- ====================================================================== -->
  <xsl:template name="orangecounty-home">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <title>Dash: Orange County Data Portal Home</title>
        <xsl:copy-of select="$oc-assets.htmlhead"/>
        <xsl:copy-of select="$brand.googleanalytics"/>
      </head>
      <body>
        <!-- begin page id -->
        <div id="orangecounty-home-page" class="ocdp"> 
          <!-- begin outer container -->  
          <div id="outer-container"> 
            <!-- begin inner container -->
            <div id="inner-container"> 
              <div class="header">
                <xsl:call-template name="brandheader"/>
                <div id="navbar">
                  <xsl:copy-of select="$oc-assets.nav-header" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
                  <xsl:call-template name="navheader"/>
                </div>
              </div>
              <div id="banner">
                <img src="assets/img/data-portal.png" width="952" height="74" alt="Orange-County-banner"/>
              </div>
              <!-- begin content -->
              <div id="content">
                <div id="left-column">
                  <div id="search-container">
                    <div class="left">
                      <img src="assets/img/searchOC.gif" width="76" height="75" alt="Search-icon"/>
                    </div>
                    <div class="right">
                      <h1>Search for Data</h1>
                      <form id="search-form" name="search-form" action="/xtf/search" method="get">
                        <!-- Ensure searches take place within OCDP. -->
                        <input type="hidden" name="browse-orangecounty" value="yes"/>
                        <label for="search-box"><span class="hidden">Search</span></label><input id="search-box" name="keyword" type="text"/>
                        <button class="btn btn-success" type="submit" value="submit">Go</button>
                      </form>
                      <p class="or">or</p>
                      <a href="/xtf/search?browse-orangecounty=yes">
                        <button class="btn">Browse OC datasets</button>
                      </a>
                    </div>
                  </div>
                </div>
                <div id="right-column">
                  <div id="publish-data-oc">
                    <div class="left-publish">
                      <img src="assets/img/worldOC.gif" width="75" height="73" alt="World-icon"/>
                    </div>
                    <div class="right-publish">
                      <h1>Share Data</h1>
                      <ul>
                        <li>Make your data count</li>
                        <li>Get credit for your data</li>
                        <li>Ensure reproducibility</li>
                        <li>Promote reuse</li>
                        <li>Meet funder requirements</li>
                      </ul>
                      <a href="/xtf/search?smode=stepsPage">
                        <button class="btn">Get started</button>
                        <!-- <img src="assets/img/learn-more.gif" width="125" height="27" alt="Learn more"/> -->
                      </a>
                    </div>
                  </div>
                </div>
              </div> <!-- end content-->
              <xsl:copy-of select="$oc-assets.nav-footer"/>
              <xsl:copy-of select="$brand.footer"/>
            </div> <!-- end inner container -->
          </div> <!-- end outer container -->
        </div>
      </body>
    </html>
  </xsl:template>
  
  <!-- ====================================================================== -->
  <!-- OC Data Portal about page Template		                                           	-->
  <!-- ====================================================================== -->
  <xsl:template name="about-orangecounty">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
      <head>
        <title>Dash: About the Orange County Data Portal</title>
        <xsl:copy-of select="$oc-assets.htmlhead"/>
        <xsl:copy-of select="$brand.googleanalytics"/>
      </head>
      <body>
        <!-- begin page id -->
        <div id="orangecounty-about-page" class="ocdp"> 
          <!-- begin outer container -->  
          <div id="outer-container"> 
            <!-- begin inner container -->
            <div id="inner-container"> 
              <div class="header">
                <xsl:call-template name="brandheader"/>
                <div id="navbar">
                  <xsl:copy-of select="$oc-assets.nav-header" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
                  <xsl:call-template name="navheader"/>
                </div>
              </div>
              <div id="banner">
                <img src="assets/img/data-portal.png" width="952" height="74" alt="Orange-County-banner"/>
              </div>
              <!-- begin content -->
              <div id="content">
                <div id="terms-of-use">
                  <div id="terms-content">
                    <h1>About</h1>
                    <div class="text-container">
                      <xsl:copy-of select="$oc-assets.about"/>
                      <h3>UC Curation Center (UC3)</h3>
                      <p>The <a href="http://cdlib.org/uc3">UC3</a> is a creative partnership bringing together the expertise and resources of the CDL, the ten UC campuses, and the broader international curation community. The group fosters collaborative analysis, projects and solutions to ensure the long-term viability and usability of curated digital content. Examples of tools and services include the <a href="https://merritt.cdlib.org">Merritt Repository Service</a>, the <a href="http://was.cdlib.org">Web Archiving Service</a> (WAS), and <a href="https://dmptool.org">Data Management Planning Tool</a> (DMPTool).</p>
                      <h2>Dash Origins</h2>
                      <p>The Dash project began as <a href="http://datashare.ucsf.edu">DataShare</a>, a collaboration between University of California San Francisco's <a href="http://ctsi.ucsf.edu">Clinical &amp; Translational Science Institute</a> (CTSI), the <a href="http://www.library.ucsf.edu/">UCSF Library and Center for Knowledge Management</a>, and <a href="http://cdlib.org/uc3">UC3</a>. CTSI is part of the Clinical and Translational Science Award program funded by the National Center for Advancing Translational Sciences at the National Institutes of Health (Grant Number UL1 TR000004).</p>
                    </div>
                  </div>
                </div>
              </div> <!-- end content-->
              <xsl:copy-of select="$oc-assets.nav-footer"/>
              <xsl:copy-of select="$brand.footer"/>
            </div> <!-- end inner container -->
          </div> <!-- end outer container -->
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- browse-locations Template                                          		-->
  <!-- ====================================================================== -->
  <xsl:template match="crossQueryResult" mode="browseLocations" exclude-result-prefixes="#all">
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
                      <xsl:text>initMap(); </xsl:text>
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
      <xsl:text>var resultBounds = []; </xsl:text>
    <!-- Create array for testing rectangles. -->
    <xsl:text>var rectangles = []; </xsl:text>
    <!-- Ignore geoLocationPlace. -->
    <xsl:apply-templates select="//(geoLocationPoint|geoLocationBox)"
      mode="makeLayers"/>
    <xsl:if test="$browse-locations">
      <!-- Fit the map to all its features. -->
      <xsl:text>map.fitBounds(resultBounds); </xsl:text>
    </xsl:if>
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
    <!-- Add the new marker to the bounds array. -->
    <xsl:text>resultBounds.push(</xsl:text>
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
    <!-- Add the new rectangle to the bounds array. -->
    <xsl:text>resultBounds.push(</xsl:text>
    <xsl:value-of select="$rectBounds"/>
    <xsl:text>); </xsl:text>
    <xsl:text>var rectBounds = L.latLngBounds(</xsl:text><xsl:value-of select="$rectBounds"/><xsl:text>); </xsl:text>
    <!-- Write the Javascript command to populate the map. -->
    <!-- The weight attribute sets the line width of the rectangle's border. -->
    <xsl:text>newRectangle = L.rectangle(rectBounds, { weight: 2 }).addTo(map).bindPopup('</xsl:text>
    <xsl:call-template name="makePopup">
      <xsl:with-param name="geoInfo" select="$rectBounds"/>
    </xsl:call-template>
    <xsl:text>'); </xsl:text>
    <!-- If this rectangle contains a previously-created rectangle, move it a 
      layer below the older rectangle. -->
    <xsl:text>for (x in rectangles) { </xsl:text> 
      <xsl:text> oldRectangle = rectangles[x]; </xsl:text>
      <xsl:text>if ( rectBounds.contains(oldRectangle.getLatLngs()) ) { </xsl:text>
      <xsl:text>newRectangle.bringBelow(oldRectangle); } }; </xsl:text>
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
