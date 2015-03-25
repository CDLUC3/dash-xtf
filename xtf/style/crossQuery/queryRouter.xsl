<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   exclude-result-prefixes="#all"
   version="2.0">
   
   <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
   <!-- Simple query router stylesheet                                         -->
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
   
   <!--
      This stylesheet implements a simple switching mechanism, allowing one to
      set up multiple distinct crossQuery domains, each with its own query parser
      and associated stylesheets.
      
      As shipped, there are two domains, "default" and "oai", which supports OAI 
      harvesting of your collections
   -->
   
   <xsl:output method="xml" indent="yes" encoding="utf-8"/>
   <xsl:strip-space elements="*"/>
   
   <!-- ====================================================================== -->
   <!-- Root Template                                                          -->
   <!-- ====================================================================== -->
   
   <xsl:param name="http.x-forwarded-host"/>
   <xsl:param name="http.URL"/>
   <xsl:template match="/">
   <xsl:choose>
<!-- OneShare -->
   <xsl:when test="contains($http.x-forwarded-host, 'oneshare')">
   		<xsl:value-of select="session:setData('brand', 'dataone')"/>
   </xsl:when>
<!-- Berkeley -->
   <xsl:when test="contains($http.x-forwarded-host, 'berkeley.edu')">
		<xsl:value-of select="session:setData('brand', 'berkeley')"/>
	</xsl:when>
<!-- Los Angeles -->
	<xsl:when test="contains($http.x-forwarded-host, 'ucla.edu')">
		<xsl:value-of select="session:setData('brand', 'ucla')"/>
	</xsl:when>
	<xsl:when test="contains($http.x-forwarded-host, 'dash-ucla-dev.cdlib.org')">
		<xsl:value-of select="session:setData('brand', 'ucla')"/>
	</xsl:when>
	<xsl:when test="contains($http.x-forwarded-host, 'dash-ucla-stg.cdlib.org')">
		<xsl:value-of select="session:setData('brand', 'ucla')"/>
	</xsl:when>
	<xsl:when test="contains($http.x-forwarded-host, 'dash-ucla.cdlib.org')">
		<xsl:value-of select="session:setData('brand', 'ucla')"/>
	</xsl:when>
<!-- Irvine -->
	<xsl:when test="contains($http.x-forwarded-host, 'uci.edu')">
		<xsl:value-of select="session:setData('brand', 'uci')"/>
	</xsl:when>
<!-- Merced -->
	<xsl:when test="contains($http.x-forwarded-host, 'ucmerced.edu')">
		<xsl:value-of select="session:setData('brand', 'ucmerced')"/>	
	</xsl:when>
<!-- Santa Cruz -->
	<xsl:when test="contains($http.x-forwarded-host, 'ucsc.edu')">
		<xsl:value-of select="session:setData('brand', 'ucsc')"/>
	</xsl:when>
<!-- San Francisco -->
	<xsl:when test="contains($http.x-forwarded-host, 'ucsf.edu')">
		<xsl:value-of select="session:setData('brand', 'ucsf')"/>
	</xsl:when>

<!-- Berkeley Lab -->
	<xsl:when test="contains($http.x-forwarded-host, 'lbl.gov')">
		<xsl:value-of select="session:setData('brand', 'lbnl')"/>
	</xsl:when>

	
	<!-- campuses to add -->
<!--
	<xsl:when test="contains($http.x-forwarded-host, 'ucr.edu')">
		<xsl:value-of select="session:setData('brand', 'ucr')"/>
	</xsl:when>
	<xsl:when test="contains($http.x-forwarded-host, 'ucsb.edu')">
		<xsl:value-of select="session:setData('brand', 'ucsb')"/>
	</xsl:when>

	<xsl:when test="contains($http.x-forwarded-host, 'ucdavis.edu')">
		<xsl:value-of select="session:setData('brand', 'ucdavis')"/>
	</xsl:when>
	<xsl:when test="contains($http.x-forwarded-host, 'ucsd.edu')">
		<xsl:value-of select="session:setData('brand', 'ucsd')"/>
	</xsl:when>
-->

	<xsl:otherwise>
		<xsl:value-of select="session:setData('brand', 'default')"/>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="contains($http.x-forwarded-host, '-dev')">
			<xsl:value-of select="session:setData('server', 'http://dash-dev.cdlib.org')"/>
		</xsl:when>
		<xsl:when test="contains($http.x-forwarded-host, '-stg')">
			<xsl:value-of select="session:setData('server', 'https://dash-stg.cdlib.org')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="session:setData('server', 'https://dash.cdlib.org')"/>
		</xsl:otherwise>
	</xsl:choose>
	<route>
         <xsl:choose>
            <!-- oai -->
            <xsl:when test="matches($http.URL,'oai\?')">
               <!-- using the redirect extension mechanism to support the OAI resumptionToken -->
               <xsl:if test="matches($http.URL,'resumptionToken=http://')">
                  <xsl:variable name="newURL" select="replace(replace($http.URL,'.+resumptionToken=(.+)','$1'),'::',';resumptionToken=')"/>
                  <redirect:send url="{$newURL}" xmlns:redirect="java:/org.cdlib.xtf.saxonExt.Redirect" xsl:extension-element-prefixes="redirect"/>
               </xsl:if>
               <queryParser path="style/crossQuery/queryParser/oai/queryParser.xsl"/>
               <errorGen path="style/crossQuery/oaiErrorGen.xsl"/>
            </xsl:when>
            <!-- default -->
            <xsl:otherwise>
               <queryParser path="style/crossQuery/queryParser/default/queryParser.xsl"/>
            </xsl:otherwise>
         </xsl:choose>
      </route>
   </xsl:template>
   
</xsl:stylesheet>
