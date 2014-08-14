<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   xmlns:editURL="http://cdlib.org/xtf/editURL"
   xmlns="http://www.w3.org/1999/xhtml"
   extension-element-prefixes="session"
   exclude-result-prefixes="#all"
   version="2.0">
   
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- Query result formatter stylesheet                                      -->
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   
   <!--
      Copyright (c) 2008, Regents of the University of California
      All rights reserved.
      
      Redistribution and use in source and binary forms, with or without 
      modification, are permitted provided that the following conditions are 
      met:
      
      - Redistributions of source code must retain the above copyright notice, 
      this list of conditions and the following disclaimer.
      - Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in the 
      documentation and/or other materials provided with the distribution.
      - Neither the name of the University of California nor the names of its
      contributors may be used to endorse or promote products derived from 
      this software without specific prior written permission.
      
      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
      AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
      IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
      ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
      LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
      CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
      SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
      INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
      CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
      ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
      POSSIBILITY OF SUCH DAMAGE.
   -->
   
   <!-- this stylesheet implements very simple search forms and query results. 
      Alpha and facet browsing are also included. Formatting has been kept to a 
      minimum to make the stylesheets easily adaptable. -->
   
   <!-- ====================================================================== -->
   <!-- Import Common Templates                                                -->
   <!-- ====================================================================== -->
   
   <xsl:import href="../common/resultFormatterCommon.xsl"/>
   <xsl:import href="rss.xsl"/>
   <xsl:include href="searchForms.xsl"/>
   <!-- ====================================================================== -->
   <!-- Output                                                                 -->
   <!-- ====================================================================== -->
   
   <xsl:output method="xhtml" indent="no" 
      encoding="UTF-8" media-type="text/html; charset=UTF-8" 
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
      omit-xml-declaration="yes"
      exclude-result-prefixes="#all"/>
   
   <!-- ====================================================================== -->
   <!-- Local Parameters                                                       -->
   <!-- ====================================================================== -->
   
   <xsl:param name="css.path" select="concat($xtfURL, 'css/default/')"/>
   <xsl:param name="icon.path" select="concat($xtfURL, 'icons/default/')"/>
   <xsl:param name="docHits" select="/crossQueryResult/docHit"/>
   <xsl:param name="email"/>
   <xsl:param name="name"/>

   <!-- ====================================================================== -->
   <!-- Root Template                                                          -->
   <!-- ====================================================================== -->
   
<xsl:template match="/" exclude-result-prefixes="#all">
	<xsl:choose>
		<xsl:when test="$smode = 'aboutPage'">   	 
			<xsl:call-template name="aboutPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'whyShareDataPage'">   	 
			<xsl:call-template name="whyShareDataPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'faqPage'">   	 
			<xsl:call-template name="faqPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'metadataBasicsPage'">   	 
		 	<xsl:call-template name="metadataBasicsPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'uploadFaqPage'">   	 
		 	<xsl:call-template name="uploadFaqPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'dataUseAgreement'">   	 
		 	<xsl:call-template name="dataUseAgreement"/>
		</xsl:when>
		<xsl:when test="$smode = 'preparePage'">   	 
			<xsl:call-template name="preparePage"/>
		</xsl:when>
		<xsl:when test="$smode = 'policiesPage'">   	 
			<xsl:call-template name="policiesPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'rightsPage'">   	 
			<xsl:call-template name="rightsPage"/>
		</xsl:when>
		<xsl:when test="$smode = 'stepsPage'">   	 
			<xsl:call-template name="stepsPage"/>
		</xsl:when>
		<!-- robot response -->
        <xsl:when test="matches($http.user-agent,$robots)">
			<xsl:apply-templates select="crossQueryResult" mode="robot"/>
		</xsl:when>
		<xsl:when test="$smode = 'showBag'">
			<xsl:apply-templates select="crossQueryResult" mode="results"/>
		</xsl:when>
		<!-- book bag -->
		<xsl:when test="$smode = 'addToBag'">
			<span>Added</span>
		</xsl:when>
		<xsl:when test="$smode = 'removeFromBag'">
			<!-- no output needed -->
		</xsl:when>
		<xsl:when test="$smode='getAddress'">
			<xsl:call-template name="getAddress"/>
		</xsl:when>
		<xsl:when test="$smode='getLang'">
			<xsl:call-template name="getLang"/>
		</xsl:when>
		<xsl:when test="$smode='setLang'">
			<xsl:call-template name="setLang"/>
		</xsl:when>
		<!-- rss feed -->
		<xsl:when test="$rmode='rss'">
			<xsl:apply-templates select="crossQueryResult" mode="rss"/>
		</xsl:when>
		<xsl:when test="$smode='emailFolder'">
			<xsl:call-template name="translate">
				<xsl:with-param name="resultTree">
					<xsl:apply-templates select="crossQueryResult" mode="emailFolder"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<!-- similar item -->
		<xsl:when test="$smode = 'moreLike'">
			<xsl:call-template name="translate">
				<xsl:with-param name="resultTree">
					<xsl:apply-templates select="crossQueryResult" mode="moreLike"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<!-- modify search -->
		<xsl:when test="contains($smode, '-modify')">
			<xsl:call-template name="translate">
				<xsl:with-param name="resultTree">
					<xsl:apply-templates select="crossQueryResult" mode="form"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<!-- browse pages -->
		<xsl:when test="$browse-title or $browse-creator or $browse-contributor or $browse-keyword or $browse-campus">
			<xsl:call-template name="translate">
				<xsl:with-param name="resultTree">
					<xsl:apply-templates select="crossQueryResult" mode="browse"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>

		<!-- show results -->
		<xsl:when test="crossQueryResult/query/*/*">
			<xsl:call-template name="translate">
				<xsl:with-param name="resultTree">
					<xsl:apply-templates select="crossQueryResult" mode="results"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<!-- show form -->
		<xsl:otherwise>
			<xsl:call-template name="translate">
				<xsl:with-param name="resultTree">
					<xsl:apply-templates select="crossQueryResult" mode="form"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="crossQueryResult" mode="results" exclude-result-prefixes="#all">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
		<body>
			<!-- begin page id -->
			<div id="browse-all-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
					<!-- begin inner container -->
					<div id="inner-container"> 
						<!-- begin header -->
						<div class="header">
							<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
						</div>
						<div id="banner">
    						<img width="952" height="72" alt="Publish and Download Research Datasets" src="assets/img/banner-home-v8.0.jpg"></img>
						</div>
						<!-- begin content -->
						<div id="content">
							<div id="browse-all-container">
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
														<xsl:apply-templates select="facet[@field='facet-campus']"/>
														<xsl:apply-templates select="facet[@field='facet-creator']"/>
														<xsl:apply-templates select="facet[@field='facet-keyword']"/>
													</div>
												</td>
											</tr>
										</table>
									</div>
								</div>
								<div class="search-results">
									<xsl:call-template name="search_controls"/>
									<div class="search-result">
										<xsl:apply-templates select="docHit"/>
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


   <!-- ====================================================================== -->
   <!-- Bookbag Templates                                                      -->
   <!-- ====================================================================== -->
   
<xsl:template name="getAddress" exclude-result-prefixes="#all">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>E-mail My Bookbag: Get Address</title>
			<xsl:copy-of select="$brand.links"/>
		</head>
		<body>
			<div class="header">
				<xsl:copy-of select="$brand.header"/>
			</div>
            <div class="getAddress">
				<h2>E-mail My Bookbag</h2>
				<form action="{$xtfURL}{$crossqueryPath}" method="get">
					<xsl:text>Address: </xsl:text>
					<input type="text" name="email"/>
					<xsl:text>&#160;</xsl:text>
					<input type="reset" value="CLEAR"/>
					<xsl:text>&#160;</xsl:text>
					<input type="submit" value="SUBMIT"/>
					<input type="hidden" name="smode" value="emailFolder"/>
				</form>
            </div>
         </body>
	</html>
</xsl:template>
   
<xsl:template match="crossQueryResult" mode="emailFolder" exclude-result-prefixes="#all">
	<xsl:variable name="bookbagContents" select="session:getData('bag')/bag"/>
	<!-- Change the values for @smtpHost and @from to those valid for your domain -->
	<mail:send xmlns:mail="java:/org.cdlib.xtf.saxonExt.Mail" 
		xsl:extension-element-prefixes="mail" 
		smtpHost="smtp.yourserver.org" 
		useSSL="no" 
		from="admin@yourserver.org"
		to="{$email}" 
		subject="XTF: My Bookbag">
		Your XTF Bookbag:
		<xsl:apply-templates select="$bookbagContents/savedDoc" mode="emailFolder"/>
	</mail:send>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>E-mail My Citations: Success</title>
            <xsl:copy-of select="$brand.links"/>
		</head>
		<body onload="autoCloseTimer = setTimeout('window.close()', 1000)">
			<div class="header">
				<xsl:copy-of select="$brand.header"/>
			</div>
            <h1>E-mail My Citations</h1>
            <b>Your citations have been sent.</b>
		</body>
	</html>
</xsl:template>
   
<xsl:template match="savedDoc" mode="emailFolder" exclude-result-prefixes="#all">
	<xsl:variable name="num" select="position()"/>
	<xsl:variable name="id" select="@id"/>
	<xsl:for-each select="$docHits[string(meta/identifier[1]) = $id][1]">
		<xsl:variable name="path" select="@path"/>
		<xsl:variable name="url">
			<xsl:value-of select="$xtfURL"/>
			<xsl:choose>
				<xsl:when test="matches(meta/display, 'dynaxml')">
					<xsl:call-template name="dynaxml.url">
						<xsl:with-param name="path" select="$path"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="rawDisplay.url">
						<xsl:with-param name="path" select="$path"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		Item number <xsl:value-of select="$num"/>: 
		<xsl:value-of select="meta/creator"/>. <xsl:value-of select="meta/title"/>. <xsl:value-of select="meta/year"/>. 
		[<xsl:value-of select="$url"/>]
	</xsl:for-each>
</xsl:template>
   
   <!-- ====================================================================== -->
   <!-- Browse Template                                                        -->
   <!-- ====================================================================== -->
   
<xsl:template match="crossQueryResult" mode="browse" exclude-result-prefixes="#all">
	<xsl:variable name="alphaList" select="'A B C D E F G H I J K L M N O P Q R S T U V W Y Z OTHER'"/>
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>XTF: Search Results</title>
			<xsl:copy-of select="$brand.links"/>
            <!-- AJAX support -->
			<script src="script/yui/yahoo-dom-event.js" type="text/javascript"/> 
			<script src="script/yui/connection-min.js" type="text/javascript"/> 
		</head>
		<body>
			<div class="header">
				<xsl:copy-of select="$brand.header"/>
				<xsl:copy-of select="$assets.nav-header"/>
			</div>
            <!-- result header -->
            <div class="resultsHeader">
				<table>
					<tr>
						<td>
						<b>Browse by:&#160;</b>
						<xsl:choose>
							<xsl:when test="$browse-title">Title</xsl:when>
							<xsl:when test="$browse-creator">Author</xsl:when>
							<xsl:when test="$browse-contributor">Contributor</xsl:when>
							<xsl:when test="$browse-campus">Campus</xsl:when>
							<xsl:otherwise>All Items</xsl:otherwise>
						</xsl:choose>
						</td>
						<td class="right">
							<a href="{$xtfURL}{$crossqueryPath}">
							<xsl:text>New Search</xsl:text>
							</a>
							<xsl:if test="$smode = 'showBag'">
								<xsl:text>&#160;|&#160;</xsl:text>
								<a href="{session:getData('queryURL')}">
									<xsl:text>Return to Search Results</xsl:text>
								</a>
							</xsl:if>
						</td>
					</tr>
					<tr>
						<td>
							<b>Results:&#160;</b>
							<xsl:variable name="items" select="facet/group[docHit]/@totalDocs"/>
							<xsl:choose>
								<xsl:when test="$items &gt; 1">
									<xsl:value-of select="$items"/>
									<xsl:text> Items</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$items"/>
									<xsl:text> Item</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</td>
						<td class="right">
							<xsl:text>Browse by </xsl:text>
							<xsl:call-template name="browseLinks"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="center">
							<xsl:call-template name="alphaList">
								<xsl:with-param name="alphaList" select="$alphaList"/>
							</xsl:call-template>
						</td>
					</tr>
				</table>
			</div>
			<!-- results -->
			<div class="results">
				<table>
					<tr>
						<td>
							<xsl:choose>
								<xsl:when test="$browse-title">
									<xsl:apply-templates select="facet[@field='browse-title']/group/docHit"/>
								</xsl:when>
								<xsl:when test="$browse-creator">
									<xsl:apply-templates select="facet[@field='browse-creator']/group/docHit"/>
								</xsl:when>
								<xsl:when test="$browse-contributor">
									<xsl:apply-templates select="facet[@field='browse-contributor']/group/docHit"/>
								</xsl:when>
								<xsl:when test="$browse-campus">
									<xsl:apply-templates select="facet[@field='browse-campus']/group/docHit"/>
								</xsl:when>
							</xsl:choose>
						</td>
					</tr>
				</table>
			</div>
			<!-- footer -->
			<xsl:copy-of select="$assets.nav-footer"/>
			<xsl:copy-of select="$brand.footer"/>
		</body>
	</html>
</xsl:template>




<xsl:template name="browseLinks">
	<xsl:choose>
		<xsl:when test="$browse-all">
			<xsl:text>Facet | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-title=first;sort=title">Title</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-creator=first;sort=creator">Author</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-contributor=first;sort=contributor">Contributor</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?smode=affiliation">Affiliation</a>
		</xsl:when>
		<xsl:when test="$browse-title">
			<a href="{$xtfURL}{$crossqueryPath}?browse-all=yes">Facet</a>
			<xsl:text> | </xsl:text>
			<xsl:text>Title | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-creator=first;sort=creator">Author</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-contributor=first;sort=contributor">Contributor</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?smode=affiliation">Affiliation</a>
		</xsl:when>
		<xsl:when test="$browse-creator">
			<a href="{$xtfURL}{$crossqueryPath}?browse-all=yes">Facet</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-title=first;sort=title">Title</a>
			<xsl:text> | </xsl:text>
			<xsl:text>Author | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-contributor=first;sort=contributor">Contributor</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?smode=affiliation">Affiliation</a>
		</xsl:when>
		<xsl:when test="$browse-contributor">
			<a href="{$xtfURL}{$crossqueryPath}?browse-all=yes">Facet</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-title=first;sort=title">Title</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-creator=first;sort=creator">Author</a>
			<xsl:text> | </xsl:text>
			<xsl:text>Contributor | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?smode=affiliation">Affiliation</a>
		</xsl:when>
		<xsl:when test="$browse-contributor">
			<a href="{$xtfURL}{$crossqueryPath}?browse-all=yes">Facet</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-title=first;sort=title">Title</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-creator=first;sort=creator">Author</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-contributor=first;sort=contributor">Contributor</a>
			<xsl:text> | </xsl:text>
			<xsl:text>Affiliation</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$xtfURL}{$crossqueryPath}?browse-all=yes">Facet</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-title=first;sort=title">Title</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-creator=first;sort=creator">Author</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?browse-contributor=first;sort=contributor">Contributor</a>
			<xsl:text> | </xsl:text>
			<a href="{$xtfURL}{$crossqueryPath}?smode=affiliation">Affiliation</a>
		</xsl:otherwise>
    </xsl:choose>
</xsl:template>
   
<!-- ====================================================================== -->
<!-- Document Hit Template                                                  -->
<!-- ====================================================================== -->
<xsl:template match="docHit" exclude-result-prefixes="#all">
	<xsl:variable name="path" select="@path"/>
	<xsl:variable name="identifier" select="meta/identifier[1]"/>
	<xsl:variable name="quotedID" select="concat('&quot;', $identifier, '&quot;')"/>
	<xsl:variable name="indexId" select="replace($identifier, '.*/', '')"/>
	<!-- scrolling anchor -->
	<xsl:variable name="anchor">
		<xsl:choose>
			<xsl:when test="$sort = 'contributor'">
				<xsl:value-of select="substring(string(meta/contributor[1]), 1, 1)"/>
			</xsl:when>
			<xsl:when test="$sort = 'creator'">
				<xsl:value-of select="substring(string(meta/creator[1]), 1, 1)"/>
			</xsl:when>
			<xsl:when test="$sort = 'title'">
				<xsl:value-of select="substring(string(meta/title[1]), 1, 1)"/> 
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<div id="main_{@rank}" class="docHit">     
		<h3><span class="DC-Title">
		<a>
		<xsl:attribute name="href">
			<xsl:call-template name="dynaxml.url">
				<xsl:with-param name="path" select="$path"/>
			</xsl:call-template>
		</xsl:attribute>
		<strong>
		<xsl:apply-templates select="meta/title"/>
		</strong></a>
		</span></h3>
		<ul>
			<li>by
				<span class="DC-Creator">
				<xsl:choose>
					<xsl:when test="meta/creator">
						<xsl:apply-templates select="meta/creator"/>
					</xsl:when>
				</xsl:choose>
				</span>
			</li>
			<li>at
				<xsl:choose>
					<xsl:when test="meta/contributor">
						<span class="DC-Contributor">
							<xsl:apply-templates select="meta/contributor"/>
					    </span>
						, 	
					</xsl:when>
				</xsl:choose>
			    <span class="DC-Publisher">
					<xsl:apply-templates select="meta/campus"/>
				</span>
			</li>
			<li>
				<xsl:choose>
					<xsl:when test="meta/date">uploaded
						<span class="DC-Date">	
							<xsl:apply-templates select="meta/date"/>
						</span>,						
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
				  	<xsl:when test="meta/collected">collected
						<span class="DC-Date">	
							<xsl:apply-templates select="meta/collected"/>
						</span>						
					</xsl:when>
				</xsl:choose>
		    </li>
		    <li class="collapsible">
				<div class="collapse-control"><span class="indicator"></span> abstract</div>
				<div class="collapse-content"><span class="DC-Description">
					<xsl:apply-templates select="meta/description[@descriptionType='Abstract']"/>
				</span></div>
			</li>
		</ul>
	</div>
	<br/>
</xsl:template>
 

<!-- ====================================================================== -->
<!-- Snippet Template (for snippets in the full text)                       -->
<!-- ====================================================================== -->
<xsl:template match="snippet" mode="text" exclude-result-prefixes="#all">
	<xsl:text>...</xsl:text>
	<xsl:apply-templates mode="text"/>
	<xsl:text>...</xsl:text>
	<br/>
</xsl:template>
   
<!-- ====================================================================== -->
<!-- Term Template (for snippets in the full text)                          -->
<!-- ====================================================================== -->
<xsl:template match="term" mode="text" exclude-result-prefixes="#all">
	<xsl:variable name="path" select="ancestor::docHit/@path"/>
	<xsl:variable name="display" select="ancestor::docHit/meta/display"/>
	<xsl:variable name="hit.rank"><xsl:value-of select="ancestor::snippet/@rank"/></xsl:variable>
	<xsl:variable name="snippet.link">
		<xsl:call-template name="dynaxml.url">
			<xsl:with-param name="path" select="$path"/>
		</xsl:call-template>
		<xsl:value-of select="concat(';hit.rank=', $hit.rank)"/>
	</xsl:variable>
      
	<xsl:choose>
		<xsl:when test="ancestor::query"/>
		<xsl:when test="not(ancestor::snippet) or not(matches($display, 'dynaxml'))">
			<span class="hit"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<a href="{$snippet.link}" class="hit"><xsl:apply-templates/></a>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
   
<!-- ====================================================================== -->
<!-- Term Template (for snippets in meta-data fields)                       -->
<!-- ====================================================================== -->
<xsl:template match="term" exclude-result-prefixes="#all">
	<xsl:choose>
		<xsl:when test="ancestor::query"/>
		<xsl:otherwise>
			<span class="hit"><xsl:apply-templates/></span>
		</xsl:otherwise>
	</xsl:choose> 
</xsl:template>
   
<!-- ====================================================================== -->
<!-- More Like This Template                                                -->
<!-- ====================================================================== -->
<!-- results -->
<xsl:template match="crossQueryResult" mode="moreLike" exclude-result-prefixes="#all">
	<xsl:choose>
		<xsl:when test="docHit">
			<div class="moreLike">
				<ol>
					<xsl:apply-templates select="docHit" mode="moreLike"/>
				</ol>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div class="moreLike">
				<b>No similar documents found.</b>
			</div>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- ====================================================================== -->
<!-- docHit/moreLike Template                                          		-->
<!-- ====================================================================== -->
<xsl:template match="docHit" mode="moreLike" exclude-result-prefixes="#all">
	<xsl:variable name="path" select="@path"/>
	<li>
		<xsl:apply-templates select="meta/creator[1]"/>
		<xsl:text>. </xsl:text>
		<a>
			<xsl:attribute name="href">
				<xsl:choose>
					<xsl:when test="matches(meta/display, 'dynaxml')">
						<xsl:call-template name="dynaxml.url">
							<xsl:with-param name="path" select="$path"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="rawDisplay.url">
							<xsl:with-param name="path" select="$path"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
            <xsl:apply-templates select="meta/title[1]"/>
		</a>
		<xsl:text>. </xsl:text>
		<xsl:apply-templates select="meta/year[1]"/>
		<xsl:text>. </xsl:text>
	</li>
</xsl:template>
	

<!-- ====================================================================== -->
<!-- Search controls Template                                           	-->
<!-- ====================================================================== -->
<xsl:template name="search_controls">
	<div class="search-controls">
		<div class="search-control-sort">
			<form method="get" action="{$xtfURL}{$crossqueryPath}" class="navbar-form">
				<b>Sorted by:&#160;</b>
				<xsl:call-template name="sort.options"/>
				<xsl:call-template name="hidden.query">
					<xsl:with-param name="queryString" select="editURL:remove($queryString, 'sort')"/>
				</xsl:call-template>
				<xsl:text>&#160;</xsl:text>
				<input type="submit" value="Go!" class="btn"/>
           </form>
		</div>
	</div>
<!--	
<div class="search-control-sort">Sort by: <a href="./sort=title">Title</a> <a href="#">Researcher</a> <a href="#">Lab/Department</a> <a href="#">Date</a></div>
</div>
-->
</xsl:template>




<!-- ====================================================================== -->
<!-- faqPage Template		                                           		-->
<!-- ====================================================================== -->
<xsl:template name="faqPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: FAQ - Open data for the global research community</title>
				<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="faq"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
					<!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
				    	<div id="banner">
							<img src="assets/img/banner-home-v8.0.jpg" width="952" height="72" alt="Publish and Download Research Datasets"/>
						</div>
						<!-- begin content -->
						<div id="content">
							<div class="single-column">
								<h1>Frequently Asked Questions</h1>
								<xsl:copy-of select="$brand.faq"/>
							</div>
						</div> <!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>
	

<!-- ====================================================================== -->
<!-- preparePage Template		                                           	-->
<!-- ====================================================================== -->
<xsl:template name="preparePage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Preparing to Submit - Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="prepare-to-submit-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
					<!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
						<!-- begin content -->
						<div id="content"> 	
							<div class="single-column">
								<h1>Preparing to Submit</h1>
								<div class="text-container">
									<p>Use this checklist to prepare your dataset for submission to Dash. See our <a href="/xtf/search?smode=policiesPage">Policies</a> for more information.</p>
									<ol>
										<li>Inform your dataset co-creators that you plan to deposit the dataset in Dash.</li>
										<li>Ensure that all governmental and institutional regulations regarding the handling of sensitive data are addressed.</li>
										<li>Prepare or obtain the most up-to-date and complete version of dataset.</li>
										<li>Prepare or obtain relevant explanatory documents related to the dataset (e.g., readme.txt files, formal metadata records, or other critical information.etc.)</li>
										<li>Gather the following information, to be entered as metadata in the Dash system (see <a href="/xtf/search?smode=metadataBasicsPage">Metadata Basics</a> for more information):
											<ul>
												<li>Dataset title&#8212;be as descriptive as possible</li>
												<li>Full names of all dataset co-creators</li>
												<li>Keywords for the dataset (use discipline-specific controlled vocabularies whenever possible)</li>
												<li>Abstract (description) describing the dataset you are submitting</li>
												<li>Description of the methods used to collect the data</li>
												<li>Citations to associated materials, including grant numbers, publications using the dataset, and other related datasets</li>
											</ul>
										</li>
									</ol>
								</div>
							</div>
						</div> <!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>

<!-- ====================================================================== -->
<!-- policiesPage Template		                                           	-->
<!-- ====================================================================== -->
<xsl:template name="policiesPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Policies- Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="prepare-to-submit-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
				    	<div id="banner">
							<img src="assets/img/banner-home-v8.0.jpg" width="952" height="72" alt="Publish and Download Research Datasets"/>
						</div>
						<!-- begin content -->
						<div id="content"> 	
							<div class="single-column">
								<h1>Policies</h1>
								<div class="text-container">
									  <h2>Scope</h2>
									  <p>All fields of scholarship. All types of research artifacts. Content must not violate privacy or copyright, or breach confidentiality or nondisclosure for data collected from human subjects.</p>

									  <h2>Status of research data</h2>
									  <p>Complete, final research data sets are accepted, although there is no restriction on uploading new versions. The content does not need to be associated with a published research article.</p>

									  <h2>Eligible depositors</h2>
									  <p>Access to the Dash data submission system is limited to individuals affiliated with UC campuses that have implemented Dash. Contact <a href="mailto:uc3@ucop.edu">uc3@ucop.edu</a> for more information.</p>

									  <h2>Versions</h2>
									  <p>All versions of a dataset will be kept in the Merritt Repository, but only the most recent version will be available through the Dash user interface. Users may not delete datasets once they've been submitted, but may submit new versions whenever appropriate.</p>

									  <h2>Data file formats</h2>
									  <p>All formats are allowed.</p>

									  <h2>Volume and size limitations</h2>
									  <p>10GB per file sizeconstraint. Quotas are likely to be introduced at a later stage. All data files are stored in the Merritt Repository. More information about the Merritt Repository Service is available in the white paper "<a href="https://merritt.cdlib.org/d/ark%3A%2F13030%2Fm52f7p63/2/producer%2FUC3-Merritt-preservation-latest.pdf">UC3, Merritt and Long-term Preservation</a>."</p>

									  <h2>Data quality</h2>
									  <p>All information is provided "as-is" and the user shall hold Dash and information providers supplying data to Dash free and harmless in connection with the use of such information.</p>
									  
									  <h2>Embargo status</h2>
									  <p>Dash does not currently have the capability for users to deposit content under an embargo status.</p>

									  <h1><a name="h.vuanhwo3t3up" id="h.vuanhwo3t3up"></a>Withdrawal of data and revocation of DOIs</h1>

									  <h2>Revocation</h2>
									  <p>Content not considered to fall under the scope of the repository will be removed and associated DOIs issued by Dash revoked. Please signal promptly any suspected policy violations, ideally no later than 24 hours from upload. User access may be revoked on violation of <a href="http://www.cdlib.org/about/terms.html">Terms of Use</a>.</p>
									  
									  <h2>Withdrawal</h2>
									  <p>Withdrawal is considered an exceptional action which normally should be requested and fully justified by the original contributor. In any other circumstance reasonable attempts will be made to contact the original contributor to obtain consent.</p>

									  <h1><a name="h.gt79ttyx3jfc" id="h.gt79ttyx3jfc"></a>Access and reuse of data</h1>

									  <h2>Access to data objects</h2>
									  <p>Data deposited into Dash may have a custom Data Use Agreement, or it may be under <a href="https://creativecommons.org/licenses/by/4.0/">CC-BY-4.0</a>. The dataset landing page will display the license associated with the dataset. Note that content in Dash is offered "as is." By downloading files, you agree to the <a href="http://www.cdlib.org/about/terms.html">Dash Terms of Use</a>.</p>

									  <h2>Tracking users and statistics</h2>
									  <p>The California Digital Library does not track, collect or retain personal information from users of Dash, except as otherwise provided herein. In order to enhance Dash and monitor traffic, non-personal information such as IP addresses and cookies may be tracked and retained. User provided information, like corrections of metadata or paper claims, will be integrated into the database without displaying its source and may be shared with other services.</p>
									  <p>The California Digital Library will take all reasonable measures to protect the privacy of its users and to resist service interruptions, intentional attacks, or other events that may compromise the security of the Dash website.</p>

									  <h1><a name="h.atav9amvh8gv" id="h.atav9amvh8gv"></a>Preservation of data</h1>
									  <p>All data submitted to Dash will be housed in the CDL's Merritt Repository. For a full description of the services provided by Merritt, see this document: <a href="https://merritt.cdlib.org/d/ark%3A%2F13030%2Fm52f7p63/2/producer%2FUC3-Merritt-preservation-latest.pdf">UC3, Merritt, and Long-term preservation</a>.</p>

									  <h2>Retention period</h2>
									  <p>Items will be retained for the lifetime of the repository.</p>

									  <h2>Functional preservation</h2>
									  <p>Dash makes no promises of usability and understandability of deposited objects over time.</p>

									  <h2>File preservation</h2>
									  <p>Data files are replicated with multiple copies in multiple geographic locations; metadata are backed up on a nightly basis.</p>
									  
									  <h2>Fixity and authenticity</h2>
									  <p>All data files are stored along with a SHA-256 checksum of the file  content. Regular checks of files against their checksums are made. The audit process cycles continually, with a current cycle time of approximately two months.</p>

									  <h1><a name="h.a1h6vbdcpidu" id="h.a1h6vbdcpidu"></a>Succession plans</h1>
									  <p>In case of closure of the repository, reasonable efforts will be made to integrate all content into suitable alternative institutional and/or subject based repositories.</p>
									  <p>All information is provided "as-is" and the user shall hold the California Digital Library, UC Campus, and information providers supplying data to Dash free and harmless in connection with the use of such information.</p>
								</div>
							</div>
						</div> <!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>

<!-- ====================================================================== -->
<!-- rightsPage Template		                                           	-->
<!-- ====================================================================== -->
<xsl:template name="rightsPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Rights Information: Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="prepare-to-submit-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
						<!-- begin content -->
						<div id="content"> 	
							<div class="single-column">
								<h1>Rights, Ownership and Licensing of Research Data</h1>
								<div class="text-container">
									<h2>Ownership</h2> 
									<p><a href="http://www.ucop.edu/academic-personnel/_files/apm/apm-020.pdf">The University of California Academic Personnel Policy (APM) 020</a> states:
									<blockquote>"Notebooks and other original records of the research are the property of the University." (II. 5, p.3)</blockquote>
									which the university interprets as meaning that research data are owned by the university.</p>
									<h2>Licenses</h2>
									<p>UCOP General Counsel currently recommends using a Creative Commons <a href="https://creativecommons.org/licenses/by/4.0/">CC-BY 4.0</a> license, requiring attribution. Dash supports this recommendation by only offering CC-BY 4.0, but we can support other licenses.</p>
								</div>
							</div>
						</div> <!-- end content-->
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>

<!-- ====================================================================== -->
<!-- uploadFaqPage Template		                                           	-->
<!-- ====================================================================== -->
<xsl:template name="uploadFaqPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Upload Basics - Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="prepare-to-submit-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
						<!-- begin content -->
						<div id="content"> 	
							<div class="single-column">
								<h1>Upload Basics</h1>
								<div class="text-container">
									<ul>
										<li>See <a href="/xtf/search?smode=policiesPage">Policies</a> for more information on uploading datasets to Dash.</li>
										<li>All file formats are accepted by Dash, although it is good practice to share data using open formats. See the UK Data Archive for a <a href="http://www.data-archive.ac.uk/create-manage/format/formats-table">list of optimal file formats</a>.</li>
										<li>Include any files that may help others to use your data. This includes readme files, formal metadata files, or other critical information.</li>
										<li>Any data submitted via Dash will be in the <a href="https://creativecommons.org/publicdomain/zero/1.0/">Public Domain (CC0)</a>. We do not currently support any other license types, nor do we allow for restrictions on data access or use.</li>
										<li>It is your responsibility to ensure your data are being shared responsibly and ethically. Please be careful of sharing sensitive data and ensure you are complying with institutional and governmental regulations.</li>
										<li>There is <a href="/xtf/search?smode=rightsPage">more information</a> on rights and ownership of, and licences for, research data.</li>
									</ul>
								</div>
							</div>
						</div> <!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>

<!-- ====================================================================== -->
<!-- dataUseAgreementPage Template                                         	-->
<!-- ====================================================================== -->
<xsl:template name="dataUseAgreement">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Data Use Agreement - Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="prepare-to-submit-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
						<!-- begin content -->
						<div id="content"> 	
							<div class="single-column">
								<div class="single-column">
									<h1>Dash Data Use Agreement</h1>
									<div class="text-container">
										<p>As part of this agreement, Consumer submits to the following statements:</p>
										<ol>
											<li>I will receive access to de-identified data and will not attempt to establish the identity of any of the study subjects.</li>
											<li>I will share these data only with my immediate co-workers, and I will not transfer these data to other research groups. I understand that these data are available to other research groups through the process by which I obtain them.</li>
											<li>I will require anyone in my group who utilizes these data, or anyone with whom I share these data to comply with this data use agreement.</li>
											<li>I will accurately provide the requested information for persons who will use these data and the analyses that are planned using these data.</li>
											<li>I will comply with any rules and regulations imposed by my institution and its institutional review board in requesting these data.</li>
											<li>I understand that approved usage of these data does not entitle Consumer to any rights, title, or interest in the shared data.</li>
											<li>I understand that Provider has the right to terminate this Agreement at any time for any reason.</li>
											<li>I will ensure that Investigators who utilize these data will use appropriate administrative, physical and technical safeguards to prevent use or disclosure of the data other than as provided for by this Agreement.</li>
											<li>I will report any use or disclosure of the data not provided for by this Agreement of which I become aware within 15 days of becoming aware of such use or disclosure.</li>
											<li>I will, upon completion of my usage of these data, submit a brief usage report describing how the data were used and citing any abstracts, talks, or publications that resulted. This will be done within one year of data usage completion, or within 6 months of acceptance of any resulting abstracts, talks, or publications.</li>
										</ol>
										<p>I understand that failure to abide by these guidelines will result in termination of my privileges to access any further data.</p>
									</div>
								</div>
							</div>
						</div> <!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>
	
<!-- ====================================================================== -->
<!-- metadataBasicsPage Template                                         	-->
<!-- ====================================================================== -->
<xsl:template name="metadataBasicsPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Metadata Basics - Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="metadata-basics-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
							<!-- begin content -->
						<div id="content"> 	
							<div class="single-column">
								<h1>Metadata Basics</h1>
								<div class="text-container">
									<p>Comprehensive data documentation (i.e. metadata) is the key to future understanding of data. Without a thorough description of the context of the data file, the context in which the data were collected, the measurements that were made, and the quality of the data, it is unlikely that the data can be easily discovered, understood, or effectively used. Metadata is important not only to help people understand and make proper use of a data resource, but metadata also makes the resource discoverable (for example through internet searches or data indexing services). Read more about metadata in the <a href="http://www.dataone.org/sites/all/documents/DataONE_BP_Primer_020212.pdf">DataONE Primer on Data Management</a> (PDF).</p>
									<p class="secondary-para">Dash requires a few key pieces of metadata. A complete list of the metadata fields in Dash is below. Additional metadata can be uploaded alongside the dataset (e.g., as a readme.txt file). The metadata entry form for Dash is based on fields from the <a href="http://schema.datacite.org/meta/kernel-3/index.html">DataCite schema</a>, version 3.0.</p>
									<table class="table table-bordered">
										<tr>
											<th>Metadata Field Name</th>
											<th>Description</th>
										</tr>
										<tr>
											<td>Title *</td>
											<td>Title of the dataset. Be as descriptive as possible.</td>
										</tr>
										<tr>
											<td>Institution *</td>
											<td>Name of the institution that supported creation of the resource.</td>
										</tr>
										<tr>
											<td>Data type *</td>
											<td>Type of data. This entry is constrained to a list from DataCite.</td>
										</tr>
										<tr>
											<td>Data Creator(s) *</td>
											<td>Main researcher(s) involved in producing the data</td>
										</tr>
										<tr>
											<td>Date</td>
											<td>Date submitted to Dash. This is automatically populated by Dash.</td>
										</tr>
										<tr>
											<td>Keyword(s)</td>
											<td>Descriptive words that may help others discover your dataset. Dash recommends that you research whether your discipline has an existing controlled vocabulary from which to choose your keywords. Please enter one keyword per line.</td>
										</tr>
										<tr>
											<td>Abstract</td>
											<td>An abstract or general description of the dataset.</td>
										</tr>
										<tr>
											<td>Methods</td>
											<td>Any technical or methodological information that may help others to understand how the data were generated and/or how they may be properly reused.</td>
										</tr>
										<tr>
											<td>Citations</td>
											<td>Use this field to indicate other resources that are associated with the data. Examples include publications, grant numbers, and other datasets.</td>
										</tr>
									</table>
									<p class="secondary-para">* Required for submission</p>
								</div>
							</div>
						</div><!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>

<!-- ====================================================================== -->
<!-- stepsPage Template			                                         	-->
<!-- ====================================================================== -->	
<xsl:template name="stepsPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Steps to Share your Data - Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="steps-to-publish"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
				    	<div id="banner">
							<img src="assets/img/banner-home-v8.0.jpg" width="952" height="72" alt="Publish and Download Research Datasets"/>
						</div>
						<!-- begin content -->
						<div id="content"> 	
							<div id="steps-content">	
								<div id="left-container">
									<h1>Steps to Share Your Data</h1>
									<div class="steps">
										<ul>
											<li><span class="title">1. Prepare </span><br />
											Gather your data and information: <a href="/xtf/search?smode=preparePage">Preparing to Submit</a></li>
											<li><span class="title">2. Describe Data </span> <br />
											Create your metadata: <a href="/xtf/search?smode=metadataBasicsPage">Metadata Basics</a></li>
											<li><span class="title">3. Upload data </span><br />
											Add your data and metadata to Dash: <a href="/xtf/search?smode=uploadFaqPage">Upload Basics</a></li>
											<li><span class="title">4. Get confirmation </span><br/>
											Receive your data citation.</li>
										</ul>
									</div>
									<div class="begin">
										<a href="/login">
											<button class="btn btn-large btn-success">Begin</button>
										</a>
									</div>
								</div>
								<div id="right-container">
									<div class="why-share">Why Share?</div>
									<div class="bullet-points">
										<ul>
											<li>Promotes transparency and reproducibility in research.</li>
											<li>Increases the visibility of underlying research (69% increase in citations for articles associated with shared datasets, Piwowar et al. 2007, <a href="http://dx.doi.org/10.1371/journal.pone.0000308">doi:10.1371/journal.pone.0000308</a>).</li>
											<li>Allows you to get credit for your dataset&#8212;add it to your CV, share it with colleagues, and have others cite your dataset when using it.</li>
											<li>Helps you meet funder and publisher requirements for data availability.</li>
											<li>Increases chances for collaboration.</li>
										</ul>
										<br /><br />
										<p>For more information, see the <a href="http://www.data-archive.ac.uk/create-manage/planning-for-sharing/why-share-data">UK Data Archive list of reasons to share data</a>.</p>
									</div>
								</div>
							</div>
						</div> <!-- end content-->
						<div id="triangle-container">
							<div id="triangle"></div>
						</div>
						<xsl:copy-of select="$assets.nav-footer"/>
						<xsl:copy-of select="$brand.footer"/>
					</div> <!-- end inner container -->
				</div> <!-- end outer container -->
			</div>
		</body>
	</html>
</xsl:template>
	
<!-- ====================================================================== -->
<!-- aboutPage Template			                                         	-->
<!-- ====================================================================== -->	
<xsl:template name="aboutPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<!-- begin page id -->
			<div id="terms-of-use"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header"> 
				     		<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
				    	</div>
				    	<div id="banner">
							<img src="assets/img/banner-home-v8.0.jpg" width="952" height="72" alt="Publish and Download Research Datasets"/>
						</div>
						<!-- begin content -->
						<div id="content"> 	
							<div id="terms-content">
								<h1>About</h1>
								<div class="text-container">
									<xsl:copy-of select="$brand.about"/>
									<h3>UC Curation Center (UC3)</h3>
									<p>The <a href="http://cdlib.org/uc3">UC3</a> is a creative partnership bringing together the expertise and resources of the CDL, the ten UC campuses, and the broader international curation community. The group fosters collaborative analysis, projects and solutions to ensure the long-term viability and usability of curated digital content. Examples of tools and services include the <a href="https://merritt.cdlib.org">Merritt Repository Service</a>, the <a href="http://was.cdlib.org">Web Archiving Service</a> (WAS), and <a href="https://dmptool.org">Data Management Planning Tool</a> (DMPTool).</p>
									<h3>Dash Origins</h3>
									<p>The Dash project began as <a href="http://datashare.ucsf.edu">DataShare</a>, a collaboration between University of California San Francisco's <a href="http://ctsi.ucsf.edu">Clinical and Translational Science Institute</a> (CTSI), the <a href="http://library.ucsf.edu">UCSF Library</a>, and <a href="http://cdlib.org/uc3">UC3</a>.</p>
									<p>UCSF's <a href="http://ctsi.ucsf.edu">Clinical &amp; Translational Science Institute</a> facilitates the rapid translation of research to improvements in patient and community health. It is a cross-school, campus-wide institute with scientist leaders at its helm. To achieve its goal of accelerating research to advance health, CTSI provides infrastructure, services, and training to support clinical and translational research. To advance its mission, it also develops broad coalitions and partnerships at the local and national levels to enable a transformation of the research environment. Established in 2006, the Institute was among the first of the now 60-member, National Institutes of Health-funded, Clinical and Translational Science Awards (CTSA) consortium.</p>
									<p>The mission of the <a href="http://library.ucsf.edu">UCSF Library and Center for Knowledge Management</a> is to advance science, foster excellence in teaching and learning, and promote health through the collection, development, organization, and dissemination of the world's health sciences knowledge base. It delivers services to the UCSF community and works with faculty on a number of collaborative projects in both education and research. On May 21, 2012 the UCSF faculty approved an Open Access policy for journal articles and the Library is developing systems and strategies to comply with the policy.</p>
									<p>This project was originally envisioned by Michael W. Weiner M.D., the director for the <a href="http://www.radiology.ucsf.edu/cind">Center for Imaging of Neurodegenerative Diseases</a> at UCSF. Dr. Weiner's experience as the Principal Investigator of the <a href="http://adni.loni.ucla.edu">Alzheimer's Disease Neuroimaging Initiative</a> (ADNI) led him to conclude that widespread data sharing can be achieved now, with great scientific and economic benefits. All ADNI raw data are immediately shared, without embargo, with all scientists in the world. The project is very successful; more than 300 publications have resulted from use of the ADNI data resource. This success demonstrates the feasibility and benefits of sharing data.</p>
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
	
<!-- ====================================================================== -->
<!-- whyShareDataPage Template	                                         	-->
<!-- ====================================================================== -->	
<xsl:template name="whyShareDataPage">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Why Share Data?</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
 		<body>
			<div id="terms-of-use"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
				    <!-- begin inner container -->
				    <div id="inner-container"> 
						<div class="header">
							<xsl:copy-of select="$brand.header"/>
							<xsl:copy-of select="$assets.nav-header"/>
						</div>
						<div class="content">
							<h1>Why Share Data?</h1>
							<p>Sharing research data helps to advance science and is beneficial to data sharers, data re-users, and the general public.</p>
							<h2>Sharing research data allows:</h2>
							<ul>
								<li>Enhanced visibility of a researcher’s work: Sharing data is associated with a significant increase in citation rate for related publications (Piwowar, H A, et al., 2007); additionally the re-use of a dataset results in citation of the dataset itself</li>
								<li>Improved understanding of original analyses</li>
								<li>Exploration of related or new hypotheses with data re-use (particularly with combined datasets)</li>
								<li>Investigation and development of new study methods, analysis techniques, and software implementations with data re-use</li>
								<li>Encouragement of multiple perspectives</li>
								<li>Establishment of new collaborations</li>
								<li>Discouragement of fraud</li>
								<li>Provision of training materials for new researchers</li>
								<li>Identification of errors</li>
								<li>Efficient use of funding and patient population resources by avoiding duplicate data collection</li>
								<li>Encouragement of improved data management</li>
								<li>Long-term preservation (and provenance) of data with improved accessibility</li>
							</ul>
							<h2>Related Policies</h2>
							<ul>
								<li>NIH Open Access policy</li>
								<li>NIH Statement on Sharing Research Data (NIH-OD-03-032) : All projects whose funds total more than $500K must share the resulting acquired data</li>
								<li>NSF general grant conditions: "Investigators are expected to share with other researchers, at no more than incremental cost and within a reasonable time, the primary data, samples, physical collections and other supporting materials created or gathered in the course of work under NSF grants. Grantees are expected to encourage and facilitate such sharing."</li>
								<li>Wellcome Trust "expects all of its funded researchers to maximise the availability of research data with as few restrictions as possible."</li>
								<li>Journal requirements to make data available as a condition of publication (Nature journals, PLoS journals, Royal Society journals)</li>
							</ul>
							<p><b>Dash</b> provides a unique infrastructure to support sharing of scientific datasets. We have developed a set of user-driven features that enhance the utility of the data resource while also providing an intuitive user interface. Our site allows for enrichment of data resources by associating descriptive metadata, but only requires entry of minimal metadata information. Data deposited into Dash will benefit from the outstanding archival services offered by the California Digital Library, and will be indexed for discovery in the Web of Science. Dash datasets will also be assigned a unique persistent identifier (doi), allowing the data to be properly cited upon re-use.</p>
							<h2>References:</h2>
							<ul>
								<li>Piwowar, H A, et al. (2007) Sharing detailed research data is associated with increased citation rate. PLoS ONE 2(3): e308. doi:10.1371/journal.pone.0000308
								<br/><a href="http://www.plosone.org/article/info:doi%2F10.1371%2Fjournal.pone.0000308">http://www.plosone.org/article/info:doi%2F10.1371%2Fjournal.pone.0000308</a></li>
								<li>Finkbeiner (2001). "Invisible Astronomers Give Their All to the Sloan." Science 292: 1472-1475.
								<br/><a href="http://dx.doi.org/10.1126/science.292.5521.1472">http://dx.doi.org/10.1126/science.292.5521.1472</a></li>
								<li>Sinnott et al. (2005). Large-scale data sharing in the life sciences: Data standards, incentives, barriers and funding models (The Joint Data Standards Study). 
								<br/><a href="http://www.dcs.gla.ac.uk/publications/paperdetails.cfm?id=8109">http://www.dcs.gla.ac.uk/publications/paperdetails.cfm?id=8109</a></li>
								<li>Nelson (2009). Data sharing: Empty archives. Nature 461: 160-163. 
								<br/>http://www.nature.com/news/2009/090909/full/461160a.html</li>
								<li>Pienta, Alter and Lyle (2010). The enduring value of social science research: The use and reuse of primary research data. ICPSR book. 
								<br/><a href="http://hdl.handle.net/2027.42/78307">http://hdl.handle.net/2027.42/78307</a></li>
								<li>From UK Data Archive: Why share data?
								<br/><a href="http://www.data-archive.ac.uk/create-manage/planning-for-sharing/why-share-data">http://www.data-archive.ac.uk/create-manage/planning-for-sharing/why-share-data</a>
								<br/><a href="http://www.kevinmd.com/blog/2011/10/medical-scientists-share-data.html">http://www.kevinmd.com/blog/2011/10/medical-scientists-share-data.html</a></li>
							</ul>
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


