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
   <xsl:variable name="brand" select="session:getData('brand')"/>
   
   <!-- ====================================================================== -->
   <!-- Form Templates                                                         -->
   <!-- ====================================================================== -->
   
   <!-- main form page -->
<xsl:template match="crossQueryResult" mode="form" exclude-result-prefixes="#all">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
		<head>
			<title>Dash: Open data for the global research community</title>
			<xsl:copy-of select="$assets.htmlhead"/>
		</head>
		<xsl:if test="matches($smode,'simple')">
			<xsl:call-template name="simpleForm"/>
		</xsl:if>
	</html>
</xsl:template>

<xsl:template name="simpleFormBkp" exclude-result-prefixes="#all">
	<div class="content content-home">
		<div class="main-row">
	   		<div class="find-data">
			  <h2><img src="assets/img/search.png" alt=""/> Find data</h2>
			    <div class="home-search-block">
					<form method="get" action="/xtf/search">
							<input type="text" placeholder="e.g. HIV, radiology" name="keyword"/>
				            <xsl:text>&#160;</xsl:text>
				            <input type="submit" value="Search"/>
					  </form>
			    </div>
			    <div class="browse-options">
			      <h3>Browse by:</h3>
			      <h4><a href="/xtf/search?browse-all=yes">All Records</a></h4>
			      <h4><a href="/xtf/search?browse-labs=all">Lab/Department</a></h4>
			      <h4><a href="/xtf/search?browse-researchers=all">Researcher</a></h4>
			    </div>
			</div>	
			<div class="share-data">
			  <h2><img src="assets/img/upload.png"  alt=""/> Share data</h2>
			  <div class="upload-link"><a href="/xtf/search?smode=uploadPage">Upload research data</a></div>
			  <div class="help-options">
			    <h3>Learn more:</h3>
			    <h4><a href="/xtf/search?smode=aboutPage">About Dash</a></h4>
			    <h4><a href="/xtf/search?smode=whyShareDataPage">Why share research data?</a></h4>
			    <h4><a href="/xtf/search?smode=faqPage">FAQ</a></h4>
				</div>
			</div>
		</div>
		<div class="promo-row">
			<div class="featured-data">
				<div class="promo-box">
				<h3>Recently uploaded research data</h3>
					<ul>
						<xsl:for-each select="document('../../../../static/brand/featured.xml')//featured">
							<xsl:for-each select="./dataset">
								<li>
									<a href="{./link}">
									<xsl:value-of select="string(./title)" />
									</a>
								</li>
							</xsl:for-each>
						</xsl:for-each>
					</ul>
				</div>
			</div>
			<div class="featured-sharer">
				<div class="promo-box">
					<h3>Researcher voices</h3>
					<xsl:copy-of select="$brand.promo-img"/>
					<br/>
					<xsl:copy-of select="$brand.promo-quote"/>
				</div>
			</div>
		</div>
	</div>
</xsl:template>
   
<xsl:template name="simpleForm">
	<body>
		<div id="terms-of-use">
			<!-- begin outer container -->  
			<div id="outer-container"> 
				<!-- begin inner container -->
				<div id="inner-container"> 
					<!-- begin header -->
					<div class="header">
						<xsl:copy-of select="$brand.header"/>
						<div id="navbar">
							<xsl:copy-of select="$assets.nav-header"/>
							<xsl:copy-of select="$brand.homelink"/>
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
										<button class="btn">Learn more</button>
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

  
</xsl:stylesheet>
