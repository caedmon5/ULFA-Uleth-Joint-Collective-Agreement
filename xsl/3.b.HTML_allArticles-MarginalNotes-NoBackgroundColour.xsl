<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common"
   xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:htm="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei htm ext" version="2.0">
   <xsl:output encoding="utf-8" indent="yes" method="html" xml:space="default"/>
   <xsl:strip-space elements="*"/>
   <!-- Document metadata -->
   <xsl:template name="docTitle" match="//tei:titleStmt/tei:title">
      <xsl:value-of select="//tei:title"/>
   </xsl:template>
   <xsl:template name="attID">
      <xsl:attribute name="id">
         <xsl:value-of select="@xml:id"/>
      </xsl:attribute>
   </xsl:template>
   <xsl:template name="targetFactory">
      <xsl:choose>
         <xsl:when test="../@xml:id">
            <xsl:value-of select="../@xml:id"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="generate-id(.)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:variable name="newline">
      <xsl:text> </xsl:text>
   </xsl:variable>
   <!--  <xsl:template match="*[rend = 'hide']"/> -->


   <xsl:template match="/">
      <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
      <html>
         <xsl:apply-templates/>
      </html>
   </xsl:template>
   <xsl:template match="tei:list/tei:item/tei:hi" mode="toc-short">
      <!--      <xsl:choose>
         <xsl:when test="../attribute::rend = 'hide'"/>
         <xsl:otherwise> -->
      <xsl:for-each select=".">
         <li>
            <a>
               <xsl:attribute name="href">
                  <xsl:text>#</xsl:text>
                  <xsl:call-template name="targetFactory"/>
               </xsl:attribute>
               <xsl:value-of select="../@n"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="."/>
            </a>
            <xsl:value-of select="$newline"/>
            <xsl:text> (</xsl:text>
            <a>
               <xsl:attribute name="href">
                  <xsl:text>#detailed-</xsl:text>
                  <xsl:call-template name="targetFactory"/>
               </xsl:attribute>detailed contents</a>
            <xsl:text>)</xsl:text>
         </li>
      </xsl:for-each>
      <!--        </xsl:otherwise>
      </xsl:choose> -->
   </xsl:template>
   <xsl:template match="tei:list/tei:item/tei:hi" mode="toc-long">
      <!--      <xsl:choose>
         <xsl:when test="../attribute::rend = 'hide'"/>
         <xsl:otherwise> -->
      <xsl:for-each select=".">
         <li class="list-group-item" title="Click to expand">
            <a>
               <xsl:attribute name="id">
                  <xsl:text>detailed-</xsl:text>
                  <xsl:call-template name="targetFactory"/>
               </xsl:attribute>
               <xsl:attribute name="href">
                  <xsl:text>#</xsl:text>
                  <xsl:call-template name="targetFactory"/>
               </xsl:attribute>
               <xsl:value-of select="../@n"/>
               <xsl:text> </xsl:text>
               <xsl:value-of select="."/>
            </a>
            <xsl:value-of select="$newline"/>
            <xsl:if test="following-sibling::tei:list/tei:item/tei:hi">
               <ul class="collapse toc">
                  <xsl:value-of select="$newline"/>
                  <xsl:for-each select="following-sibling::tei:list/tei:item/tei:hi">
                     <li class="list-group-item">
                        <a>
                           <xsl:attribute name="href">
                              <xsl:text>#</xsl:text>
                              <xsl:call-template name="targetFactory"/>
                           </xsl:attribute>
                           <xsl:value-of select="../@n"/>
                           <xsl:text> </xsl:text>
                           <xsl:value-of select="."/>
                        </a>
                        <xsl:value-of select="$newline"/>
                        <xsl:if test="following-sibling::tei:list/tei:item/tei:hi">
                           <ul class="collapse toc">
                              <xsl:value-of select="$newline"/>
                              <xsl:for-each select="following-sibling::tei:list/tei:item/tei:hi">
                                 <li class="list-group-item">
                                    <a>
                                       <xsl:attribute name="href">
                                          <xsl:text>#</xsl:text>
                                          <xsl:call-template name="targetFactory"/>
                                       </xsl:attribute>
                                       <xsl:value-of select="../@n"/>
                                       <xsl:text> </xsl:text>
                                       <xsl:value-of select="."/>
                                    </a>
                                    <xsl:value-of select="$newline"/>
                                    <xsl:if test="following-sibling::tei:list/tei:item/tei:hi">
                                       <ul class="collapse toc">
                                          <xsl:value-of select="$newline"/>
                                          <xsl:for-each
                                             select="following-sibling::tei:list/tei:item/tei:hi">
                                             <li class="list-group-item">
                                                <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:text>#</xsl:text>
                                                  <xsl:call-template name="targetFactory"/>
                                                  </xsl:attribute>
                                                  <xsl:value-of select="../@n"/>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of select="."/>
                                                </a>
                                                <xsl:value-of select="$newline"/>
                                                <xsl:if
                                                  test="following-sibling::tei:list/tei:item/tei:hi">
                                                  <ul class="collapse toc">
                                                  <xsl:value-of select="$newline"/>
                                                  <xsl:for-each
                                                  select="following-sibling::tei:list/tei:item/tei:hi">
                                                  <li class="list-group-item">
                                                  <a>
                                                  <xsl:attribute name="href">
                                                  <xsl:text>#</xsl:text>
                                                  <xsl:call-template name="targetFactory"/>
                                                  </xsl:attribute>
                                                  <xsl:value-of select="../@n"/>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of select="."/>
                                                  </a>
                                                  </li>
                                                  <xsl:value-of select="$newline"/>
                                                  </xsl:for-each>
                                                  </ul>
                                                </xsl:if>
                                             </li>
                                          </xsl:for-each>
                                       </ul>
                                    </xsl:if>
                                 </li>
                              </xsl:for-each>
                           </ul>
                        </xsl:if>
                     </li>
                  </xsl:for-each>
               </ul>
            </xsl:if>
         </li>
      </xsl:for-each>
      <!--        </xsl:otherwise>
      </xsl:choose> -->
   </xsl:template>
   <!--   <xsl:template match="tei:seg">
      <xsl:choose>
         <xsl:when test="@corresp">
            <span class="movedText" title="Moved text; click to see in original context">
               <a>
                  <xsl:attribute name="href">
                     <xsl:value-of select="@corresp"/>
                  </xsl:attribute>
                  <xsl:apply-templates/>
               </a>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <span class="newText" title="New or edited text">
               <xsl:apply-templates/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="tei:add">
      <span class="newText" title="New or edited text">
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="tei:note">
      <div class="note">
         <p>
            <xsl:apply-templates/>
         </p>
      </div>
   </xsl:template> -->
   <!-- 
    <xsl:template match="tei:text//tei:note">/
        <xsl:variable name="notenum" select="count(preceding::tei:note[ancestor::tei:text]) + 1"/>
        <xsl:variable name="linklabel" select="normalize-space($notenum)"/>
        <sup>
            <a>
                <xsl:attribute name="name">refpoint-<xsl:value-of select="$linklabel"
                /></xsl:attribute>
                <xsl:attribute name="href">#note-<xsl:value-of select="$linklabel"/></xsl:attribute>
                <span class="hideme">[</span>
                <xsl:value-of select="normalize-space($notenum)"/>
                <span class="hideme">]</span>
            </a>
        </sup>
    </xsl:template>
    
    <xsl:template match="tei:text//tei:note" mode="shownotes">
        <xsl:variable name="notenum" select="count(preceding::tei:note[ancestor::tei:text]) + 1"/>
        <xsl:variable name="linklabel" select="normalize-space($notenum)"/>
        <div class="footnote">
            <xsl:value-of select="$newline"/>
            <xsl:if test="tei:p[position() = 1]">
                <p>
                    <a>
                        <xsl:attribute name="id">note-<xsl:value-of select="$linklabel"
                        /></xsl:attribute>
                        <xsl:attribute name="href">#refpoint-<xsl:value-of select="$linklabel"
                        /></xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:text>Link to insertion point of note in main text.</xsl:text>
                        </xsl:attribute>
                        <span class="hideme">[</span>
                        <xsl:value-of select="$notenum"/>
                        <span class="hideme">]</span>
                    </a>
                    <xsl:text>. </xsl:text>
                    <xsl:apply-templates select="tei:p[position() = 1]"/>
                </p>
            </xsl:if>
            <xsl:for-each select="tei:p[not(position() = 1)]">
                <p>
                    <xsl:apply-templates select="."/>
                </p>
            </xsl:for-each>
        </div>
        <xsl:value-of select="$newline"/>
    </xsl:template>
    
-->
   <xsl:template match="tei:hi">
      <span style="font-weight:bold">
         <!-- this attribute is an alternative to the choose below. If you use the choose, remove this -->
         <xsl:attribute name="class">head</xsl:attribute>
         <!-- 
            <xsl:choose>
                <xsl:when test="./parent::tei:item/parent::tei:list/parent::tei:body">
                    <xsl:attribute name="class">head</xsl:attribute>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>-->
         <xsl:attribute name="id">
            <xsl:call-template name="targetFactory"/>
         </xsl:attribute>
         <xsl:apply-templates/>
      </span>
   </xsl:template>

   <xsl:template match="tei:seg">
      <xsl:choose>
         <xsl:when test="attribute::rend = 'mutual'">
            <span style="color:green">
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="attribute::rend = 'new'">
                  <span style="color:red">
                     <xsl:apply-templates/>
                  </span>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="tei:item">
      <!--      <xsl:choose>
         <xsl:when test="attribute::rend = 'hide'"/>
         <xsl:otherwise>
-->
      <xsl:choose>
         <xsl:when test="parent::tei:list/parent::tei:body">
            <hr/>
            <h2>
               <xsl:if test="@ana">
                  <div class="note">
                     <a>
                        <xsl:if test="@corresp">
                           <xsl:attribute name="href">
                              <xsl:value-of select="@corresp"/>
                           </xsl:attribute>
                           <xsl:attribute name="title">
                              <xsl:text>Click to see in original context</xsl:text>
                           </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="@ana"/>
                     </a>
                  </div>
               </xsl:if>
               <a>
                  <xsl:attribute name="href">#<xsl:value-of select="@xml:id"/>
                  </xsl:attribute>
                  <xsl:attribute name="title"
                        ><xsl:text>Click to get link to this item (ID = #</xsl:text><xsl:value-of
                        select="@xml:id"/>)</xsl:attribute>
                  <xsl:call-template name="attID"/>
                  <xsl:choose>
                     <xsl:when test="../attribute::type = 'prologue'"/>
                     <xsl:otherwise>
                        <xsl:choose>
                           <xsl:when test="../attribute::type = 'schedule'">Schedule <xsl:value-of
                                 select="@n"/>: </xsl:when>
                           <xsl:otherwise>Article <xsl:value-of select="@n"/>: </xsl:otherwise>
                        </xsl:choose>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:if test="child::tei:hi">
                     <!-- <xsl:value-of select="child::tei:hi"/> -->
                     <xsl:apply-templates select="child::tei:hi"/>
                  </xsl:if>
               </a>
            </h2>
            <xsl:choose>
               <xsl:when test="child = tei:hi">
                  <xsl:apply-templates select="tei:hi" mode="hide"/>
                  <xsl:choose>
                     <xsl:when test="child[2] = tei:list">
                        <xsl:apply-templates select="tei:list"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:choose>
                           <xsl:when test="child[2] = tei:p">
                              <xsl:apply-templates select="tei:p"/>
                              <xsl:if test="child[3] = tei:list">
                                 <xsl:apply-templates select="tei:list"/>
                              </xsl:if>
                           </xsl:when>
                        </xsl:choose>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates select="tei:p | tei:list"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <li>
               <xsl:if test="child::tei:hi">
                  <xsl:attribute name="class">head</xsl:attribute>
                  <xsl:attribute name="style"> margin-top:1em; </xsl:attribute>
               </xsl:if>
               <xsl:call-template name="attID"/>
               <xsl:if test="@ana">
                  <div class="note">
                     <a>
                        <xsl:if test="@corresp">
                           <xsl:attribute name="href">
                              <xsl:value-of select="@corresp"/>
                           </xsl:attribute>
                           <xsl:attribute name="title">
                              <xsl:text>Click to see in original context</xsl:text>
                           </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="@ana"/>
                     </a>
                  </div>
               </xsl:if>
               <a>
                  <xsl:attribute name="href">#<xsl:value-of select="@xml:id"/>
                  </xsl:attribute>
                  <xsl:attribute name="title"
                        ><xsl:text>Click to get link to this item (ID = #</xsl:text><xsl:value-of
                        select="@xml:id"/>)</xsl:attribute>
                  <xsl:value-of select="@n"/>
               </a>
               <xsl:text> </xsl:text>
               <xsl:apply-templates/>
            </li>
         </xsl:otherwise>
      </xsl:choose>
      <!--        </xsl:otherwise>
      </xsl:choose> -->
   </xsl:template>
   <xsl:template match="tei:ref">
      <a>
         <xsl:attribute name="href">
            <xsl:value-of select="@target"/>
         </xsl:attribute>
         <xsl:apply-templates/>
      </a>
      <xsl:text> </xsl:text>
   </xsl:template>
   <!-- suppress tei elements -->
   <xsl:template match="tei:TEI">
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="tei:body">
      <h1>
         <xsl:call-template name="docTitle"/> (with marginal notes) </h1>
      <h2 class="toc">Table of Contents</h2>
      <ul class="toc">
         <li>
            <a href="#summary">Summary Contents</a>
         </li>
         <li>
            <a href="#detailed">Detailed Contents</a>
         </li>
         <li>
            <a href="#body">
               <xsl:call-template name="docTitle"/>
            </a>
         </li>
      </ul>
      <h3 id="summary" class="toc">Summary Contents</h3>
      <ul class="toc">
         <xsl:apply-templates mode="toc-short" select="tei:list/tei:item/tei:hi"/>
      </ul>
      <h3 id="detailed" class="toc">Detailed Contents</h3>
      <ul class="toc">
         <xsl:apply-templates mode="toc-long" select="tei:list/tei:item/tei:hi"/>
      </ul>
      <hr class="toc"/>
      <a id="body"/>
      <xsl:apply-templates/>
   </xsl:template>
   <xsl:template match="tei:table">
      <table>
         <xsl:apply-templates/>
      </table>
   </xsl:template>
   <xsl:template match="tei:row">
      <tr>
         <xsl:apply-templates/>
      </tr>
   </xsl:template>
   <xsl:template match="tei:cell">
      <td>
         <xsl:apply-templates/>
      </td>
   </xsl:template>
   <xsl:template match="tei:list">
      <xsl:choose>
         <xsl:when test="attribute::type = 'unordered'">
            <ul>
               <xsl:apply-templates/>
            </ul>
         </xsl:when>
         <xsl:otherwise>
            <ul>
               <xsl:apply-templates/>
            </ul>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template match="tei:p[rend = 'head']">
      <span class="heading">
         <xsl:apply-templates/>
      </span>
   </xsl:template>
   <xsl:template match="tei:p">
      <!-- <span class="paragraph"> -->
      <p>
         <xsl:apply-templates/>
      </p>
      <!-- </span> -->
   </xsl:template>
   <xsl:template match="tei:lb">
      <br/>
   </xsl:template>
   <xsl:template match="tei:head">
      <p>
         <xsl:attribute name="class">head</xsl:attribute>
         <xsl:apply-templates/>
      </p>
   </xsl:template>
   <xsl:template match="tei:teiHeader">
      <head>
         <title> Version showing corresponding articles in old handbook <xsl:call-template
               name="docTitle"/>
         </title>
         <meta name="viewport" content="width=device-width, initial-scale=1"/>
         <!-- <link rel="stylesheet"
                href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"/>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"/> -->
         <!-- <style type="text/css" title="Default">
           @import 
            url(../css/core.css);</style>
         <style type="text/css" media="screen" title="Default">
            @import 
            url(core.css); </style>-->

         <style type="text/css" media="print">
            body {
                width: 40em;
            }
            .toc {
                display: none;
            }</style>
         <style type="text/css" title="Default">
            .note a[href]:link {
                color: gray;
            }
            
            
            .movedText a[href]:link,
            .newText a[href]:link,
            .movedText a[href]:visited,
            .newText a[href]:visited {
            }
            .note a[href]:visited {
                color: gray;
            }
            
            a[href]:link {
                color: purple;
                text-decoration: none;
                /* font-weight:bold; */
            }
            
            a:visited {
                color: purple;
            }
            
            a[href]:hover {
                cursor: pointer;
                text-decoration: underline;
                background-color: #FFEFD5;
                color: red;
                /* font-family: sans-serif;
            font-weight: bold; */
            }
            
            a[href]:focus {
                /* font-weight: bold;
            background-color: yellow; */
            }
            
            
            body {
                max-width: 50em;
                margin-left: auto;
                margin-right: auto;
                font-size: 120%;
                line-height: 1.2;
            }
            
            h2,
            span.head {
                font-weight: bold;
            }
            
            h2,
            .head {
                margin-top: 3em;
            }
            
            p {
                text-indent: 0;
                padding-left: 2em;
                margin-bottom: 0.5em;
                margin-top: 0.5em;
            }
            li {
                list-style: none;
                text-indent: -3em;
                padding-left: 3em;
                margin-bottom: 0.5em;
                margin-top: 0.5em;
            }
            li.toc {
                list-style-type: none;
                margin-bottom: 0em;
                margin-top: 0em;
                line-height: 1;
            }
            span.head {
                font-weight: bold;
            }
            table,
            tr,
            td {
                border-collapse: collapse;
                border: 1px solid black;
                text-indent: 0;
                padding: 1em
            }
            
            
            .newText {
                text-decoration: underline;
                /* font-weight:bold; */
                font-style: normal;
                color: blue;
                cursor: help;
                background-color: yellow;
            }
            
            .movedText {
                font-style: oblique;
                color: blue;
                background-color: lightgray;
            }
            
            .note {
                font-size: small;
                color: gray !important;
                font-style: oblique;
                position: absolute;
                text-align: right;
                width: 90pt;
                min-width: 5em;
                /* background-clip:content-box;*/
                float: left;
                clear: right;
                /* background: yellow; */
                /*  border:double; */
                position: relative;
                margin-left: -120pt;
                padding-right: 5em;
                /* margin-top: -50%*/
            }
            }</style>
      </head>
   </xsl:template>
   <xsl:template match="tei:text">
      <body>
         <div>
            <xsl:apply-templates select="tei:body"/>
         </div>
      </body>
   </xsl:template>
</xsl:stylesheet>
