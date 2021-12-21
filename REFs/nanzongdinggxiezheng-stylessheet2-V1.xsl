<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        <xsl:variable name="main-root" select="/tei:TEI"/>
        <html>
            <head>
                <title><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@xml:lang='zho-Hant']"/></title>
                <link rel="stylesheet" type="text/css" href="mystyle (2).css"/>
            </head>
            <body>
                <h1><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@xml:lang='zho-Hant']"/></h1>
                <!--xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div[@xml:id='wrap-S-2679-0001r-0018r']"/-->
                <!-- 新增，讓結果不受限某個檔案 -->
                <table>
                    <thead><tr><th>orig</th><th>data</th></tr></thead>
                        <!-- 改為迴圈，因為要控制順序 -->
                        <!-- xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div//tei:orig"/ -->
                    <xsl:for-each select="/tei:TEI/tei:text/tei:body/tei:div//tei:orig">
                        <xsl:sort select="@reg"></xsl:sort>
                        <tr>
                                <xsl:apply-templates select="."/>
                        </tr>
                    </xsl:for-each>
                    
                </table>
                <!-- 新增結束 -->
            </body>
        </html>
    </xsl:template>


    <!-- 修正orig Template
    <xsl:template match="tei:orig">
                <xsl:value-of select="@reg"/>
                <font color="#FF3333"  size="1"> [<xsl:apply-templates/>]</font>      
    </xsl:template>
    -->

    <xsl:template match="tei:orig">
        <td>
            <xsl:value-of select="@reg"/>
        </td>
        <td>
                <font color="#FF3333"  size="1"> [<xsl:apply-templates/>], </font>      
        </td>
    </xsl:template>
    
    <xsl:template match="tei:g">        
         <span class="g">        
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>nanzongdingxiezheng-S-2679_files/</xsl:text>
                    <xsl:value-of select="substring(@ref,2)"/>
                    <xsl:text>.png</xsl:text>
                </xsl:attribute>
                [<xsl:value-of select="@ref"/>]
            </xsl:element>        
        </span>
    </xsl:template>
   
</xsl:stylesheet>