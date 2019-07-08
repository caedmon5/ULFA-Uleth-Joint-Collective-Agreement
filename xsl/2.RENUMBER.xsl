<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="tei ext xsl xs" version="2.0">
    <xsl:output doctype-public="-//TEI P5" encoding="utf-8" indent="yes" method="xml"
        xml:space="default"/>
    <xsl:strip-space elements="*"/>

    <!-- This is a two-pass stylesheet that converts TEI XML to TEI XML and does the following:
        
        1) adds IDREFs to tei:items that don't have an ID
        2) Adds legal style numbering to the @n attribute of any tei:item that 
           doesn't have a number
        3) Build tei:refs from existing tei:ptr by searching for the target by 
           ID and then getting the number created from (2) above 
    
    REQUIRED INPUT: a valid TEI document
    OUTPUT: a valid TEI document
    
    -->

    <!-- T1 match the root and start building the variable -->
    <xsl:template match="/">

        <!-- build the variable by cycling through all the mode 1 templates-->
        <xsl:variable name="Transform1Results">
            <xsl:apply-templates/>
        </xsl:variable>

        <!-- when the template is done, move into mode 2 and apply the templates to the virtual tree -->
        <xsl:apply-templates select="ext:node-set($Transform1Results)" mode="pass2"/>
    </xsl:template>

    <!-- T2 match the nodes 1:1 and then apply any relevant mode1 
        templates until you loop through everything and fill the variable -->

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <!-- T3 match tei:item and add an ID ref if it doesn't have one and the position number to the n attribute-->

    <xsl:template match="tei:item">
        <xsl:copy>
            <!-- check if there's an ID and if not create one -->
            <xsl:choose>
                <xsl:when test="@xml:id"/>
                <xsl:otherwise>
                    <xsl:attribute name="xml:id">
                        <xsl:text>f-</xsl:text>
                        <xsl:value-of select="generate-id(.)"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <!-- count the location and add legal numbering to @n -->
            <xsl:choose>
                <!--if there isn't a number attribute, create a legal number -->
                <xsl:when test="not(@n)">
                    <xsl:choose>
                        <!-- check if the list is unordered or not -->
                        <xsl:when test="not(ancestor::tei:list[@type = 'unordered'])">
                            <xsl:variable name="itemType">
                                <xsl:choose>
                                    <xsl:when test="ancestor::tei:list[@type = 'schedule']"
                                        >schedule</xsl:when>
                                    <xsl:otherwise>article</xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="itemLevel" select="count(ancestor::*)"/>
                            <!-- if the item has 10 ancestors use a level 4 n -->
                            <xsl:if test="$itemLevel = 16">
                                <xsl:attribute name="n">
                                    <xsl:number level="single" format="[i]"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">seventh-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A.01.1(a)(i)[a][i]"
                                            />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1.01.1(a)(i)[a][i]"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="$itemLevel = 14">
                                <xsl:attribute name="n">
                                    <xsl:number level="single" format="[a]"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">sixth-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A.01.1(a)(i)[a]"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1.01.1(a)(i)[a]"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="$itemLevel = 12">
                                <xsl:attribute name="n">
                                    <xsl:number level="single" format="(i)"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">fifth-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A.01.1(a)(i)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1.01.1(a)(i)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="$itemLevel = 10">
                                <xsl:attribute name="n">
                                    <xsl:number level="single" format="(a)"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">fourth-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A.01.1(a)"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1.01.1(a)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="$itemLevel = 8">
                                <xsl:variable name="level">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A.01.1"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1.01.1"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:attribute name="n">
                                    <xsl:value-of select="$level"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">third-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:value-of select="$level"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="$itemLevel = 6">
                                <xsl:variable name="level">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A.01"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1.01"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:attribute name="n">
                                    <xsl:value-of select="$level"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">second-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:value-of select="$level"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="$itemLevel = 4">
                                <xsl:variable name="level">
                                    <xsl:choose>
                                        <xsl:when test="$itemType = 'schedule'">
                                            <xsl:number level="multiple" format="A"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:number level="multiple" format="1"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:attribute name="n">
                                    <xsl:value-of select="$level"/>
                                </xsl:attribute>
                                <xsl:attribute name="rendition">first-level</xsl:attribute>
                                <xsl:attribute name="sortkey">
                                    <xsl:value-of select="$level"/>
                                </xsl:attribute>
                            </xsl:if>
                        </xsl:when>
                        <!-- if the list was unordered, do nothing -->
                        <xsl:otherwise/>
                    </xsl:choose>
                </xsl:when>
                <!-- if the list had an n attribte do nothing -->
                <xsl:otherwise/>
            </xsl:choose>
            <!-- apply the templates to loop through the tree -->
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- this is to add the pointer stuff -->

    <!-- <xsl:key name="items-by-id" match="tei:item" use="@xml:id"/> -->

    <xsl:template match="tei:ptr" mode="pass2">
        <xsl:choose>
            <xsl:when test="attribute::type = 'external'">
                <ref xmlns="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="target">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="@target"/>
                </ref>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select=".">
                    <xsl:variable name="target2ID">
                        <xsl:value-of select="substring-after(@target, '#')"/>
                    </xsl:variable>
                    <ref xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="target">
                            <xsl:value-of select="@target"/>
                        </xsl:attribute>
                        <xsl:for-each select="id($target2ID)">
                            <!-- <xsl:value-of select="@n"/> -->
                            <xsl:value-of select="@sortkey"/>
                        </xsl:for-each>
                    </ref>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="node() | @*" mode="pass2">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="pass2"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="comment()" priority="5"/>

</xsl:stylesheet>
