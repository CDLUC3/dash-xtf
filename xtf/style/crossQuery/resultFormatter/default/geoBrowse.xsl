<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- ====================================================================== -->
    <!-- geoBrowsePage Template		                                           		-->
    <!-- ====================================================================== -->
    <xsl:template name="browseLocation" exclude-result-prefixes="#all">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Dash</title>
          <xsl:copy-of select="$assets.htmlhead"/>
          <xsl:copy-of select="$assets.leaflet-map"/>
          <xsl:copy-of select="$brand.googleanalytics"/>
        </head>
        <body>
          <!-- begin page id -->
          <!-- NOTE: I would change "browse-all-*" IDs to "browse-locations", 
            but that breaks the CSS. ~AMC (UCI) -->
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
                    <h1>Select a Dataset...</h1>
                    <div class="search-form-area">
                      <form name="navigationSearchForm" action="/xtf/search" method="get" class="navbar-form">
                        <input type="text" name="keyword" class="searchField cleardefault" value="Search datasets..." title="Search datasets"/>
                        <input type="submit" value="Go!" class="searchButton btn"/>
                      </form>
                      <a class="searchLabel" href="/xtf/search?browse-all=yes">Clear search</a>
                    </div>
                    <div class="search-refine">
                      <div class="search-refine-controls">
                        <table>
                          <tr>
                            <td>
                              <div class="facet">
                                <xsl:apply-templates select="//facet[@field='facet-campus']"/>
                                <xsl:apply-templates select="//facet[@field='facet-creator']"/>
                                <xsl:apply-templates select="//facet[@field='facet-keyword']"/>
                              </div>
                            </td>
                          </tr>
                        </table>
                      </div>
                    </div>
                    <div class="search-results">
                      <xsl:call-template name="search_controls"/>
                      <div id="map">
                        <script>
                          <xsl:text>initMap();</xsl:text>
                        </script>
                      </div>
                      <div class="search-result">
                        <xsl:apply-templates select="//docHit"/>
                        <xsl:if test="@totalDocs > $docsPerPage">
                          <xsl:call-template name="pages"/>
                        </xsl:if>           
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
    
</xsl:stylesheet>