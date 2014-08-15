<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- Error page generation stylesheet                                       -->
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

<xsl:stylesheet version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xtf="http://cdlib.org/xtf"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   xmlns:editURL="http://cdlib.org/xtf/editURL"
   xmlns="http://www.w3.org/1999/xhtml"> 

	<xsl:import href="./docFormatter/common/docFormatterCommon.xsl"/>

	<xsl:output method="xhtml" indent="no" 
		encoding="UTF-8" media-type="text/html; charset=UTF-8" 
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
		exclude-result-prefixes="#all"
		omit-xml-declaration="yes"/>
      
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Dash: Error Page</title>
				<xsl:copy-of select="$assets.htmlhead"/> 
			</head>
			<body>
				<!-- begin page id -->
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
							<div id="content"> 	
								<div id="terms-content">
									<h1>Error - Page Not Found</h1>
									<div class="text-container">
										<p>Sorry, Dash is unable to locate the page you have requested.</p>
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
</xsl:stylesheet>
