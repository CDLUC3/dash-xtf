<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:editURL="http://cdlib.org/xtf/editURL"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   version="2.0">
   
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- Search forms stylesheet                                                -->
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
   <!-- Global parameters                                                      -->
   <!-- ====================================================================== -->
   
   <xsl:param name="freeformQuery"/>
   <xsl:param name="http.x-forwarded-host"/>
   <xsl:variable name="brand" select="session:getData('brand')"/>
   <xsl:variable name="serverName" select="session:getData('server')"/>
   <xsl:param name="http.cookie"/>
   <xsl:variable name="Shib_cookie_name" select="'dash_logged_in'"/>      
   <!-- ====================================================================== -->
   <!-- Form Templates                                                         -->
   <!-- ====================================================================== -->
   
   <!-- main form page -->
<xsl:template match="crossQueryResult" mode="form" exclude-result-prefixes="#all">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
		<xsl:if test="matches($smode,'simple')">
			<xsl:call-template name="simpleForm"/>
		</xsl:if>
	</html>
</xsl:template>

   <!-- Home page template -->
<xsl:template name="simpleForm">
   	<body>
		<div id="terms-of-use">
			<!-- begin outer container -->  
			<div id="outer-container"> 
				<!-- begin inner container -->
				<div id="inner-container"> 
					<!-- begin header -->
					<div class="header">
						<xsl:call-template name="brandheader"/>
<!--						<xsl:copy-of select="$brand.header"/> -->
						<div id="navbar">
							<xsl:copy-of select="$assets.nav-header"/>
							<xsl:call-template name="navheader"/>
						</div>
					</div>
					<div id="banner">
						<img src="assets/img/banner-home-v8.0.jpg" width="952" height="72" alt="Publish and Download Research Datasets"/>
					</div>	
					<!-- begin content -->
					<div id="content"> 	
						<div id="left-column">
							<div id="search-container">
								<div class="left">
									<img src="assets/img/magnifying2.gif" width="76" height="75" alt="Search-icon"/>
								</div>
								<div class="right">
								<h1>Search for Data</h1>
									<form id="search-form" name="search-form" action="#" method="get">
										<label for="search-box"><span class="hidden">Search</span></label><input id="search-box" name="keyword" type="text"/>
										<button class="btn btn-success" type="submit" name="submit">Go</button>
										<!-- <input id="search-go" type="submit" name="submit" value=""></input> -->
									</form>
									<p id="or">or</p>
									<a href="/xtf/search?browse-all=yes">
										<button class="btn">Browse all data</button>
										<!-- <input type="image" src="assets/img/browse.png" id="browse" alt="Browse all data"/> -->
									</a>
								</div>
							</div>
						</div>
						<div id="right-column">
							<div id="publish-data">
								<div class="left-publish">
									<img src="assets/img/world2.gif" width="75" height="73" alt="World-icon"/>
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
					</div>  <!-- end content-->
					<xsl:copy-of select="$assets.nav-footer"/>
					<xsl:copy-of select="$brand.footer"/>
				</div> <!-- end inner container -->
			</div> <!-- end outer container -->
		</div>
	</body>
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
