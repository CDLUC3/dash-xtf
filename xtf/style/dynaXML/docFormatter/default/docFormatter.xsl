<xsl:stylesheet version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xtf="http://cdlib.org/xtf"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   xmlns:editURL="http://cdlib.org/xtf/editURL"
   xmlns="http://www.w3.org/1999/xhtml"> 
   
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- ERC (Electronic Resource Citations) Stylesheet                         -->
   <!-- See the ERC spec: http://www.cdlib.org/inside/diglib/ark/ercspec.html  -->
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
   
   <!-- ====================================================================== -->
   <!-- Import Common Templates                                                -->
   <!-- ====================================================================== -->
   
   <xsl:import href="../common/docFormatterCommon.xsl"/>

   <!-- ====================================================================== -->
   <!-- Output Format                                                          -->
   <!-- ====================================================================== -->
   
   <xsl:output method="xhtml" indent="no" 
      encoding="UTF-8" media-type="text/html; charset=UTF-8" 
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
      exclude-result-prefixes="#all"
      omit-xml-declaration="yes"/>

   <xsl:output name="frameset" method="xhtml" indent="no" 
      encoding="UTF-8" media-type="text/html; charset=UTF-8" 
      doctype-public="-//W3C//DTD XHTML 1.0 Frameset//EN" 
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd" 
      omit-xml-declaration="yes"
      exclude-result-prefixes="#all"/>

   
   <!-- ====================================================================== -->
   <!-- Global parameters and variables                                        -->
   <!-- ====================================================================== -->
   
   <xsl:param name="http.URL"/>
   <xsl:variable name="serverName" select="session:getData('server')"/>
   <xsl:variable name="ercPat" select="'^(http://[^?]+)/erc/([^?]+)\?q$'"/>
   <xsl:param name="docId">
      <!-- Normally this is a URL parameter, but in ERC mode it's part of the main URL. -->
      <!-- <xsl:value-of select="replace($http.URL, $ercPat, '$2')"/> -->
   </xsl:param>
   <xsl:param name="http.cookie"/>

   <!-- ====================================================================== -->
   <!-- Define Parameters and variables                                        -->
   <!-- ====================================================================== -->
   
   <xsl:param name="doc.title" select="/title"/>
   <xsl:param name="css.path" select="'css/default/'"/>
   <xsl:variable name="Shib_cookie_name" select="'dash_logged_in'"/>
   
   <!-- ====================================================================== -->
   <!-- Root Template                                                          -->
   <!-- ====================================================================== -->
<xsl:template match="/">
	<xsl:choose>
		<!-- robot solution -->
		<xsl:when test="matches($http.user-agent,$robots)">
			<xsl:call-template name="robot"/>
		</xsl:when>
		<!-- Creates the button bar.-->
		<xsl:when test="$doc.view = 'bbar'">
			<xsl:call-template name="bbar"/>
		</xsl:when>
		<!-- Creates the basic frameset.-->
		<xsl:otherwise>
			<xsl:call-template name="frameset"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

   <!-- ====================================================================== -->
   <!-- Frameset Template                                                      -->
   <!-- ====================================================================== -->
<xsl:template name="frameset">
	<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
			<title>Dash: <xsl:apply-templates select="//title"/></title>
			<xsl:copy-of select="$assets.htmlhead"/>
			<xsl:copy-of select="$brand.googleanalytics"/>
		</head>
		<body>
			<div id="dataset-description-page"> 
				<!-- begin outer container -->  
				<div id="outer-container"> 
					<!-- begin inner container -->
					<div id="inner-container"> 
						<!-- begin header -->
						<div class="header">
							<xsl:call-template name="brandheader"/>
<!--							<xsl:copy-of select="$brand.header"/> -->
							<div id="navbar">
								<xsl:copy-of select="$assets.nav-header"/>
								<xsl:call-template name="navheader"/>
							</div>
						</div>
						<div id="banner">
    						<img width="952" height="72" alt="Publish and Download Research Datasets" src="assets/img/banner-home-v8.0.jpg"></img>
						</div>
						<div class="content content-dataset" id="content">
							<div class="single-column">
								<h1><xsl:apply-templates select="/*/*:meta/*:title"/></h1>
								<div class="dataset-description">
									<dl>
									<!-- Citation -->
										<dt>Citation</dt>
										<dd>
											<xsl:for-each select="/*/*:meta/*:creator">
												<xsl:value-of select="normalize-space(.)"/>
												<xsl:if test="not(position() = last())">
													<xsl:text>; </xsl:text>
												</xsl:if>
											</xsl:for-each>
											<xsl:choose>
												<xsl:when test="/*/*:meta/*:publicationYear">
													(<xsl:apply-templates select="/*/*:meta/*:publicationYear"/>):
												</xsl:when>
												<xsl:otherwise>. </xsl:otherwise>
											</xsl:choose>
											<xsl:value-of select="normalize-space(/*/*:meta/title)"/>.
											<xsl:if test="/*/*:meta/*:publisher">
												<xsl:value-of select="/*/*:meta/*:publisher"/>.
											</xsl:if>
											<xsl:if test="/*/*:meta/*:resourceType">
												<xsl:value-of select="/*/*:meta/*:resourceType"/>.
											</xsl:if>
											<xsl:if test="substring(/*/*:meta/*:doi,1,3)='doi'">
												<xsl:value-of select="/*/*:meta/*:doi"/>
											</xsl:if>
											<xsl:if test="substring(/*/*:meta/*:doi,1,3)='ark'">
												http://n2t.net/<xsl:value-of select="/*/*:meta/*:doi"/>
											</xsl:if>
										</dd>
										<xsl:if test="//title"> 
											<dt>Title</dt>
											<dd><span class="DC-Title"><xsl:apply-templates select="//*:meta/*:title"/></span></dd>
										</xsl:if>
										<xsl:if test="//*/*:meta/*:creator"> 
											<dt>Creator(s)</dt>
											<dd class="DC-Creator">
												<xsl:apply-templates select="//*/*:meta/*:creator"/>
											</dd>
										</xsl:if>
										<xsl:if test="//*/*:meta/*:contributor"> 
											<dt>At</dt>
											<dd>
												<span class="DC-Contributor"><xsl:apply-templates select="//*/*:meta/*:contributor"/>,&#160;</span>
												<span class="DC-Publisher"><xsl:apply-templates select="//*/*:meta/*:publisher"/></span>
											</dd>
										</xsl:if>
										<xsl:if test="//*/*:meta/*:description[@descriptionType='SeriesInformation']"> 
											<dt>Papers</dt>
											<xsl:if test="count(//*/*:meta/*:description[@descriptionType='SeriesInformation']) > 1">
												<dd>
													<div class="collapsible">
														<div class="collapse-control">
															<span class="indicator"></span> publications associated with data
														</div>
														<div class="collapse-content">
															<xsl:for-each select="//*/*:meta/*:description[@descriptionType='SeriesInformation']">
																<span class="DC-Type">
																	<xsl:value-of select="."/>
																</span>
																<br/>
															</xsl:for-each>
														</div>
													</div>
												</dd>
											</xsl:if>
											<xsl:if test="count(//*/*:meta/*:description[@descriptionType='SeriesInformation']) = 1">
												<dd>
													<span class="DC-Type"><xsl:apply-templates select="//*/*:meta/*:description[@descriptionType='SeriesInformation']"/></span>
												</dd>
											</xsl:if>
										</xsl:if>
										<xsl:for-each select="//*/*:meta/*:description[@descriptionType='Abstract']">
											<xsl:if test="not(normalize-space(.)='')">
												<dt>Abstract</dt>
												<dd>
													<span class="DC-Type">
														<xsl:value-of select="."/>
													</span>
												</dd>
											</xsl:if>
										</xsl:for-each>
										<xsl:for-each select="//*/*:meta/*:description[@descriptionType='Methods']">
											<xsl:if test="not(normalize-space(.)='')">
												<dt>Methods</dt>
												<dd>
													<div class="collapsible">
														<div class="collapse-control">
															<span class="indicator"></span> Methods
														</div>
														<div class="collapse-content">
															<xsl:value-of select="."/>
														</div>
													</div>
												</dd>
											</xsl:if>
										</xsl:for-each>
										<xsl:if test="//*/*:meta/*:resourceType"> 
											<dt>Type</dt>
											<dd>
												<span class="DC-Type">
													<xsl:if test="//@resourceTypeGeneral">
														<xsl:apply-templates select="//@resourceTypeGeneral"/>: 
													</xsl:if>
													<xsl:apply-templates select="//*/*:meta/*:resourceType"/>
												</span>
											</dd>
										</xsl:if>
										<xsl:if test="//objectsize"> 
											<dt>Size</dt>
											<dd>
												<span class="DC-Type">
													<xsl:apply-templates select="//objectsize"/>
												</span>
											</dd>
										</xsl:if>
										<xsl:if test="/*/*:meta/*:date"> 
											<dt>Date</dt>
											<dd>
												<xsl:if test="//*/*:meta/*:collected">	Collected 
													<span class="DC-Coverage">
														<xsl:apply-templates select="//*/*:meta/*:collected"/>
													</span>
												</xsl:if>
												<xsl:if test="//*/*:meta/*:date">
													Analyzed <span class="DC-Date-Created">
														<xsl:apply-templates select="//*/*:meta/*:date"/>
													</span>
												</xsl:if>
												<xsl:if test="//*/*:meta/*:added">
													Uploaded <span class="DC-Date">
														<xsl:apply-templates select="//*/*:meta/*:added"/>
													</span>
												</xsl:if>
											</dd>
										</xsl:if>
										<xsl:if test="//*/*:meta/*:publicationYear">
											<dt>Published</dt>
											<dd>
												<span class="DC-Date">
													<xsl:apply-templates select="//*/*:meta/*:publicationYear"/>
												</span>
											</dd>
										</xsl:if>
										<xsl:if test="//*/*:meta/*:subject!=''"> 
											<dt>Keywords</dt>
											<dd>
												<span class="DC-Subject">
													<xsl:apply-templates select="//*/*:meta/*:subject"/>
												</span>
											</dd>
										</xsl:if>
										<xsl:if test="//doi"> 
											<dt>Identifier</dt>
											<dd>
												<span class="DC-Identifier">
													<xsl:apply-templates select="//doi"/>
												</span>
											</dd>
										</xsl:if>
									</dl>
								</div>
								<div class="dataset-actions">
									<div class="dataset-action-buttons">
										<a class="dataset-action-download">
											<xsl:attribute name="href">
												<xsl:value-of select="normalize-space(//target)"/>
											</xsl:attribute> 
											<xsl:attribute name="target">
												<xsl:value-of select="'_target'"/>
											</xsl:attribute>
											<b>Download <xsl:apply-templates select="//objectsize"/> dataset
											</b>
										</a>
									</div>
									<div class="cc-license">
									<!--the logic here: if the metadata contains either CC-BY or CC-0 in the  -->
									<!--rights element, display the approved wording. If not, and the rights  -->
									<!--contains something, display what it contains; if empty, display CC-BY -->
										<xsl:choose>
											<xsl:when test="//@rightsURI='https://creativecommons.org/licenses/by/4.0/'">
												<xsl:call-template name="cc-by-4"/>
											</xsl:when>
											<xsl:when test="//@rightsURI='http://creativecommons.org/about/cc0'">
												<xsl:call-template name="cc-0"/>
											</xsl:when>
											<xsl:when test="//@rightsURI='http://creativecommons.org/publicdomain/zero/1.0/'">
												<xsl:call-template name="cc-0"/>
											</xsl:when>
											<xsl:when test="starts-with(//@rightsURI, 'http://datashare.ucsf.edu/xtf/search')">
												<xsl:call-template name="ucsf-datashare-dua"/>
											</xsl:when>
											<xsl:when test="//publisher='UC San Francisco'">
												<xsl:call-template name="ucsf-datashare-dua"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="//rightsList!=''">
														<xsl:value-of select="//rightsList"/>
													</xsl:when>
													<xsl:when test="//publisher='DataONE'">
														<xsl:call-template name="cc-0"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:call-template name="cc-by-4"/>
													</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise> 
										</xsl:choose>
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

	<!-- ======================================================================	-->
	<!-- NavHeader Template	                                                	-->
	<!-- ======================================================================	-->
<xsl:template name="navheader">
	<xsl:choose>
		<xsl:when test="contains($http.cookie, $Shib_cookie_name)">
			<div id="project_links">
				<ul>
					<li><xsl:copy-of select="$brand.homelink"/></li>
					<li><a href="/logout">Log Out</a></li>
				</ul>
			</div>
		</xsl:when>
		<xsl:otherwise>
			<div id="project_links_no_logout">
				<xsl:copy-of select="$brand.homelink"/>
			</div>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template> 

<xsl:template name="brandheader">
	<xsl:message>x-forwarded-host: <xsl:value-of select="$http.x-forwarded-host"/></xsl:message>
	<a href="{$serverName}"><img src="assets/img/dash_cdl_logo.png" alt="Dash: Data sharing made easy" class="your-logo"/></a>
	<xsl:copy-of select="$brand.header"/>
</xsl:template>

</xsl:stylesheet>
