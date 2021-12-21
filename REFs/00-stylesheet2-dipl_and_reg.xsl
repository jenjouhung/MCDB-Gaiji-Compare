<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
 
 <!-- This stylesheet outputs a more or less aligned HTML view of the diplomatic and regularized versions of a single Ms witness. Do not use on the wrapper files, but on the single Ms XML files. -->
 
    <xsl:strip-space elements="*"/>
    
    <!-- These named templates use recursion to insert as many spaces as needed in the html.
    Adapted from "Loop with recursion in XSLT" http://www.ibm.com/developerworks/xml/library/x-tiploop/index.html -->
    <xsl:template name="spaces">        
        <xsl:param name="count" select="1"/>        
        <xsl:if test="$count > 0">
            <xsl:text> _&#160;</xsl:text><!--  &#160; = $nbsp; -->
            <xsl:call-template name="spaces">
                <xsl:with-param name="count" select="$count - 1"/>
            </xsl:call-template>
        </xsl:if>        
    </xsl:template>    
    <xsl:template name="gaps">
        <xsl:param name="count" select="1"/>
        <xsl:if test="$count > 0">
            <xsl:text>&#x25AF;</xsl:text> <!--  = ▯ white vertical rectangle  -->
            <xsl:call-template name="gaps">
                <xsl:with-param name="count" select="$count - 1"/>
            </xsl:call-template>
        </xsl:if>        
    </xsl:template>
    
    <!-- HTML CONSTRUCTOR  ____________________________________________________  -->
    
    <xsl:template match="/">        
        <html>
            <head>
                <title>test 敦煌遺書數位化</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>   
                <style type="text/css">
                    <!-- abbreviated from CSS found at www.scientificpsychic.com/etc/css-mouseover.html  (class name there: dropt)-->
                    span.choice-orig {border-bottom: thin dotted; background: #fed;}
                    span.choice-orig:hover {text-decoration: none; background: #fff; z-index: 6; }
                    
                    span.choice-orig span {position: absolute; left: -9999px; top: 20px;}
                    span.choice-orig:hover span {position: fixed; left: 80%; background: #fff; padding: 3px 3px 3px 3px;
                    border:1px solid black; background: #fff; z-index:6;}
                    span.pop-up img {width:5em;}
                    
                    span.choice-reg {color:blue}
                    
                    span.choice-abbr {color: red;}
                    span.choice-expan {color: magenta;}
                    
                    span.choice-corr {color: green;}
                    
                    span.subst-del {color: 966;text-decoration: line-through;}
                    span.del-notSubst {color: 933;text-decoration: line-through;}
                    
                    span.subst-add  {color: 696;}
                    span.add-notSubst {color: 933;}
                    
                    span.unclear {border-bottom: 1px dotted #ba0000;}
                    span.taisho-ref {font-size:50%}
                    
                    span.inparaNote {font-size:70%; color: 696;}
                    
                    span.handPunct {color: red;}
                </style>
            </head>
            
            <body style="font-family:HanaMinA,HanaMinB">
                <div>
                    <h2> <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title[@xml:lang='zho-Hant']"/></h2>
                        <!-- different headers according to different projects -->
                        <xsl:if test="/TEI/teiHeader/fileDesc/titleStmt/principal[text() = 'Marcus Bingenheimer 馬德偉']">
                            <p>謄寫，標記，行政: Chang, Po-Yung 張伯雍<br/>
                                專案主持人， 程式設計:  Marcus Bingenheimer<br/>
                                主辦單位: Chung-hwa Institute of Buddhist Studies 中華佛學研究所<br/>
                                協助單位: Dharma Drum Institute of Liberal Arts 法鼓文理學院<br/>
                                版本：<xsl:value-of select="adjust-date-to-timezone(current-date(),())"/></p>
                        </xsl:if>
                        
                        <xsl:if test="/TEI/teiHeader/fileDesc/titleStmt/principal[text() = 'Christoph Anderl']">                       
                            <p>謄寫，標記， 顧問， 程式設計:  <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/respStmt[1]/name"/>，<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/respStmt[2]/name"/>，<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/respStmt[5]/name"/><br/>
                                  專案主持人: <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/principal"/> <br/>
                        Funder and Sponsors: <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/funder"/>, <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/sponsor[1]"/> <br/>
                                  版本：<xsl:value-of select="adjust-date-to-timezone(current-date(),())"/></p>
                        </xsl:if>
                    
                </div>
                <hr/>
                <div>
                    <table>
                        <tr>
                            <td><b>DIPLOMATIC TRANSCRIPTION 數位文字摹本</b></td>
                            <td><b>REGULARIZED TRANSCRIPTION 標準字體化版</b></td>
                        </tr>
                        <tr>
                            <td> 
                                <span class="choice-abbr">Abbreviations</span> are red. <span class="choice-abbr">紅色</span>為省書。<br/>
                                Mouse-over <span class="choice-orig">Non-Unicode Characters</span> to see an image. Unicode Extension A-D characters are displayed as they are fonted. Extentions E-F can be viewed with if a font is installed that contains those characters (e.g.HanaMinB). 指標滑過<span class="choice-orig">非萬國碼字</span>會跳出字圖。萬國碼 A-D 字集，以讀者已安裝字型呈現。部分文獻已更新至 E、F 字集，需安裝 HanaMinB 字型。<br/>
                                Legible [[damaged text]] is marked by two angular brackets. 兩層方括號表示字體[[破損]]。<br/>
                                Deleted text appears <span class="del-notSubst">like this</span>. 刪除字以<span class="del-notSubst">這樣</span>表示。<br/>
                                Deleted text for which there is a substitution appears <span class="subst-del">like this</span>. The substitutions appear in <span class="subst-add">this color</span>. 取代文字以'<span class="subs-add">這個顏色</span>'表示，被取代文字以<span class="subst-del">這樣</span>表示。<br/>                                
                                Unclear characters are marked by <span class="unclear">thin dotted underline</span>. 文字不清在字下劃<span class="unclear">虛線</span>。<br/>
                                Illegible damaged text is marked by one &#x25AF; (vertical rectangle) for each presumed missing character. 難辨、破損字以 ▯（豎長方形）表示每一個字。<br/>
                                Extra spaces are marked by "_&#160;" (underline and space) for each character-size unit. 空字以"_"（底線加空格）表示。<br/>
                                Errors in the text are given as is (&lt;sic&gt;). 錯誤文字均保留原文。
                            </td>
                            <td>
                                Abbreviations are <span class="choice-expan">resolved</span>. 省書已<span class="choice-expan">推定</span>。<br/>
                                Unicode Extension A-D characters and Non-Unicode characters (attested or not) are replaced with their <span class="choice-reg">common form 通用字 in this color</span>. 萬國碼擴充 A-F 字集與非萬國碼（識別與否）皆以<span class="choice-reg">此色的通用字體</span>取代。<br/>
                                Legible damaged text is unmarked. 可知之破損字不另標示。<br/>
                                Unclear characters are unmarked. 可知之難辨字不另標示。<br/> 
                                Illegible damaged text is marked by one &#x25AF; (vertical rectangle) per missing character (est.). 難辨、破損字以 ▯（豎長方形）表示每一個字。<br/>
                                Extra spaces are unmarked. 不保留空格。<br/>
                                <span class="choice-corr">Presumed errors in the text</span> are corrected (&lt;corr&gt;), where possible. 顯示<span class="choice-corr">編者更正的字</span>。
                            </td>
                        </tr>
                        <tr><!-- Divide in diplomatic and regularized mode -->
                            <td style="width:46%"><xsl:apply-templates select="TEI/text/body/div/ab" mode="diplomatic"/></td>
                            <td style="width:52%"><xsl:apply-templates select="TEI/text/body/div/ab" mode="regularized"/>
                            </td>
                        </tr>
                        <tr>  <td><hr/><p>註解 / NOTES:</p>
                            <xsl:apply-templates mode="regularized-notes" select="TEI/text/body/div//ptr"/></td></tr>
                    </table>
                    </div>
            </body>
        </html>        
    </xsl:template>  
    
    <!-- only match linebreaks with line nos, not "empty" lbs within 雙行 glosses-->
    <xsl:template match="lb[@xml:id]" mode="diplomatic">
        <br/><br/><xsl:value-of select="@xml:id"/><xsl:text> : </xsl:text>
    </xsl:template>
    <xsl:template match="lb[@xml:id]" mode="regularized">
        <br/><br/><xsl:value-of select="@xml:id"/><xsl:text> : </xsl:text>
    </xsl:template>
    
    
    <!--   DELETIONS  __________________________________________________ -->
      
    <!-- Deletions within substitutions are marked in the diplomatic transcription. -->
    <xsl:template match="subst/del" mode="diplomatic">
        <xsl:choose>
            <xsl:when test="not(*) and not(normalize-space())"/> <!-- deletions that are illegible when overwritten go untreated -->
            <xsl:otherwise> <!-- deletions that are legible appear with strikethrough  -->
                <span class="subst-del" title="substitution-deletion"><xsl:apply-templates mode="diplomatic"/></span>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>    
    
    
    <!-- Deletions outside of substitutions are marked in the diplomatic transcription. -->
    <xsl:template match="del[not(parent::subst)]" mode="diplomatic">
        <xsl:choose>
            <xsl:when test="not(*) and not(normalize-space())">  <!-- deletions that are illegible appear as ▯ white vertical rectangle when not overwritten -->
                <xsl:variable name="noChar" select="@extent"/>
                <span class="del-notSubst" title="deleted-illegible (del)">
                    <xsl:call-template name="gaps">
                    <xsl:with-param name="count" select="$noChar"/>
                </xsl:call-template></span>
            </xsl:when>                
            <xsl:otherwise> <!-- deletions that are legible appear with strikethrough  -->
                <span class="del-notSubst" title="deletion"><xsl:apply-templates mode="diplomatic"/></span>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    <!-- Deletions inside or outside of substitutions do not appear in the regularized transcription. -->
    <xsl:template match="del" mode="regularized"/>
         
    
    
    <!--   ADDITIONS  __________________________________________________ -->
    
    <!-- Additions within and without substitutions. Diplomatic mode models insertion \ /. Regularized mode just adds them. -->
    <xsl:template match="subst/add" mode="diplomatic">
        <span class="subst-add" title="substitution-addition">`<xsl:apply-templates mode="diplomatic"/>´</span>
    </xsl:template>
    <xsl:template match="subst/add" mode="regularized">
        <xsl:apply-templates mode="regularized"/>
    </xsl:template>
    
    <xsl:template match="add[not(parent::subst)]" mode="diplomatic">
        <span class="add-notSubst" title="next to line - addition"><sup>\<xsl:apply-templates mode="diplomatic"/>/</sup></span>
    </xsl:template>
    <xsl:template match="add[not(parent::subst)]" mode="regularized">
        <xsl:apply-templates  mode="regularized"/>
    </xsl:template>
    
    <!--   OUR CORRECTIONS  __________________________________________________ -->
    
    <!-- sic appears in the diplomatic transcription and corr in the regularized version -->
    <xsl:template match="sic" mode="diplomatic">
        <xsl:apply-templates  mode="diplomatic"/>
    </xsl:template>
    <xsl:template match="sic" mode="regularized"/>
    
    <xsl:template match="corr" mode="diplomatic"/>
    
    <xsl:template match="corr" mode="regularized">
        <span class="choice-corr"><xsl:apply-templates  mode="regularized"/></span>
    </xsl:template>
    
    
    
    <!--   NOTES  __________________________________________________ -->
    
    <!--  Notes inserted by us have no @resp and appear in the regularized text as footnote markers, below the text as footnotes-->
    
    <xsl:template match="ptr" mode="regularized">
        <xsl:variable name="refNo" select="count(preceding::ptr)+1"/>
        <a id="{$refNo}" href="#end{$refNo}">[<xsl:value-of select="$refNo"/>]</a>
    </xsl:template>
    
    <!--note text at the bottom-->
    <xsl:template match="ptr" mode="regularized-notes">
        <!-- pulls the notes from the XXX-00notes.xml files and puts them under the text-->
        <xsl:variable name="textname">
            <!-- get the text name from the file name of the XML file, first parse the BASE-URI tokenizing by '/' and get the last item, then tokenize the filename by '-' and get the first item -->
            <xsl:value-of select="tokenize(tokenize(base-uri(), '/')[last()],'-')[1]"/> 
        </xsl:variable>
        <xsl:variable name="target" select="substring-after(@target,'#')"/>
        <xsl:variable name="refNo" select="count(preceding::ptr)+1"/>
        <p class="endNote">
            <a class="endRefNo" id="end{$refNo}" href="#{$refNo}"><xsl:value-of select="$refNo"/><xsl:text>  </xsl:text></a>
            <xsl:value-of select="doc(concat($textname,'-00notes.xml'))/div/note[@xml:id = $target]"/>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Notes inserted by previous scribes are marked. In the diplomatic view we differentiate between gloss like notes and inline additions. In regularized mode we put them in brackets-->
    <xsl:template match="note[@resp]" mode="diplomatic">
        <xsl:choose>
            <xsl:when test="@rendition='#inline-para'">
                <span class="inparaNote"  title="noteInTheMs"><xsl:apply-templates mode="diplomatic"/></span>
            </xsl:when>
            <xsl:when test="@rendition= '#inline-right' or @rendition= '#inline-left'">
                <span class="add-notSubst"  title="noteInlineLeftInTheMs"><sup>\<xsl:apply-templates mode="diplomatic"/>/</sup></span>
            </xsl:when>
            <xsl:when test="@rendition='#margin-top'">
                <span class="inparaNote" title="noteInTheUpperMargin"><xsl:apply-templates mode="diplomatic"/></span>
            </xsl:when>
            <xsl:when test="@rendition='#margin-bottom'">
                <span class="inparaNote" title="noteInTheBottomMargin"><xsl:apply-templates mode="diplomatic"/></span>
            </xsl:when>
            <xsl:otherwise>
                <apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="note[@resp]" mode="regularized">
        <span class="inparaNote">(<xsl:apply-templates mode="regularized"/>)</span>
     </xsl:template>
    
    
    <!--   VARIANT CHARACTERS __________________________________________________ -->
    
    <!-- character variants in diplomatic mode show the version closest to the original; in regularized mode show the regularization-->
    <xsl:template match="orig" mode="diplomatic">
        <!-- highlight the regularized, non-unicode characters which are identified in the 教育部異體字字典, pull in an image via a CCS pop-up -->
           
        <xsl:choose>  <xsl:when test="g">
                <xsl:variable name="charId" select="g/substring-after(@ref, '#')"/>
                <xsl:variable name="MoEdictID" select="/TEI/teiHeader/encodingDesc/charDecl/glyph[@xml:id = $charId]/charProp/value/text()"/>
                <xsl:if test="/TEI/teiHeader/encodingDesc/charDecl/glyph[@xml:id = $charId][charProp/localName/text() = '教育部異體字字典']">
                    <xsl:element name="span">
                        <xsl:attribute name="class">choice-orig</xsl:attribute>            
                        <xsl:attribute name="title">Variant Non-Unicode character identified in the 教育部異體字字典 (No: <xsl:value-of select="$MoEdictID"/>)</xsl:attribute>
                        <xsl:value-of select="@reg"/>  
                        <xsl:element name="span">
                            <xsl:attribute name="class">pop-up</xsl:attribute>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="concat('../gaiji/png/',$MoEdictID,'.png')"/>
                                </xsl:attribute>
                            </xsl:element>
                            <br/><xsl:value-of select="$MoEdictID"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="/TEI/teiHeader/encodingDesc/charDecl/glyph[@xml:id = $charId][charProp/localName/text() = '專案新增']">
                    <xsl:element name="span">
                        <xsl:attribute name="class">choice-orig</xsl:attribute>            
                        <xsl:attribute name="title">Recurring Variant Non-Unicode character not attested in the 教育部異體字字典</xsl:attribute>
                        <xsl:value-of select="@reg"/>  
                        <xsl:element name="span">
                            <xsl:attribute name="class">pop-up</xsl:attribute>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="concat('../gaiji/png/',$MoEdictID,'.png')"/>
                                </xsl:attribute>
                            </xsl:element>
                            <br/><xsl:value-of select="$MoEdictID"/>
                        </xsl:element>                        
                    </xsl:element>
                </xsl:if>
                <xsl:if test="/TEI/teiHeader/encodingDesc/charDecl/glyph[@xml:id = $charId][charProp/localName/text() = '全字庫']">
                    <xsl:element name="span">
                        <xsl:attribute name="class">choice-orig</xsl:attribute>            
                        <xsl:attribute name="title">Recurring Variant Non-Unicode character attested in the CNS 11643 Chinese Standard Interchange Code (全字庫)</xsl:attribute>
                        <xsl:value-of select="@reg"/>  
                        <xsl:element name="span">
                            <xsl:attribute name="class">pop-up</xsl:attribute>
                            <xsl:element name="img">
                                <xsl:attribute name="src">
                                    <xsl:value-of select="concat('../gaiji/png/',$MoEdictID,'.png')"/>
                                </xsl:attribute>
                            </xsl:element>
                            <br/><xsl:value-of select="$MoEdictID"/>
                        </xsl:element>                        
                    </xsl:element>
                </xsl:if>
            </xsl:when> 
            <!-- give unicode character where possible. apply-templates instead of  value-of takes care of e.g. orig within orig (P-2187 l.117) />-->
            <xsl:otherwise>
                <xsl:apply-templates  mode="diplomatic"/>
            </xsl:otherwise>
        </xsl:choose>        

    </xsl:template>
    
    <xsl:template match="orig" mode="regularized">
        <!-- give 通用字 where possible -->        
        <span  class="choice-reg" title="Regularized character {if (@type) then (concat(', Ms has ',@type, ' character')) else (', Ms has attested Non-Unicode variant')}"><xsl:value-of select="@reg"/></span>
    </xsl:template>
    
    <!-- Unattested non-Unicode variants which are not in a <choice> are simply marked <reg> -->
    <xsl:template match="reg" mode="diplomatic"> 
        <span class="choice-reg" title="Regularized. Ms has unattested Non-Unicode Variant"><xsl:value-of select="text()"/></span>
    </xsl:template>
    <xsl:template match="reg" mode="regularized"> 
        <span class="choice-reg" title="Regularized. Ms has unattested Non-Unicode Variant"><xsl:value-of select="text()"/></span>
    </xsl:template>
    
    <!--   ABBREVIATIONS  __________________________________________________ -->
    
    <!-- In diplomatic mode show abbreviation give expansion with mouseover. In regularized mode the abbreviations are resolved without further marking. -->
    <xsl:template match="choice[abbr]"  mode="diplomatic">
        <span class="choice-abbr" title="abbreviation for {expan}"><xsl:apply-templates select="abbr" mode="diplomatic"/></span>
    </xsl:template>
    <xsl:template match="choice[abbr]"  mode="regularized">
        <span  class="choice-expan" title="normalization of {abbr}"><xsl:apply-templates select="expan"   mode="regularized"/></span>
    </xsl:template>
    
    
    <!--   GAP , DAMAGE and UNCLEAR __________________________________________________ -->
       
    <xsl:template match="gap" mode="diplomatic">
        <xsl:choose>
            <xsl:when test="@reason='missingPothiLeaf'">
                [[...缺頁...]]
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="noChar" select="@extent"/>
        <span title="illegible (gap)"><xsl:call-template name="gaps">
            <xsl:with-param name="count" select="$noChar"/>
        </xsl:call-template></span>
            </xsl:otherwise>
        </xsl:choose>           
    </xsl:template>
    
    <xsl:template match="gap" mode="regularized">
        <xsl:variable name="noChar" select="@extent"/>
        <span title="illegible (gap)"><xsl:call-template name="gaps">
            <xsl:with-param name="count" select="$noChar"/>
        </xsl:call-template></span>
    </xsl:template>
    
    <xsl:template match="damage" mode="diplomatic">
        <xsl:if test="not(*)">
        <xsl:variable name="noChar" select="@extent"/>
        <span title="damaged"><xsl:call-template name="gaps">
            <xsl:with-param name="count" select="$noChar"/>
        </xsl:call-template></span>
        </xsl:if>
        <xsl:if test="*|text()">
           <span title="damaged"> [[<xsl:apply-templates mode="diplomatic"/>]]</span>
        </xsl:if>
    </xsl:template>
    <xsl:template match="damage" mode="regularized">
        <xsl:if test="not(*)">
            <xsl:variable name="noChar" select="@extent"/>
            <span title="damaged"><xsl:call-template name="gaps">
                <xsl:with-param name="count" select="$noChar"/>
            </xsl:call-template></span>
        </xsl:if>
        <xsl:if test="*|text()">
            <xsl:apply-templates mode="regularized"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="unclear" mode="diplomatic">
        <span class="unclear" title="unclear"><xsl:apply-templates  mode="diplomatic"/></span>
    </xsl:template>
    <xsl:template match="unclear" mode="regularized">
        <xsl:apply-templates  mode="regularized"/>
    </xsl:template>
    
    
    <!--   SPACES AND ANCHORS  __________________________________________________ -->
    
    <!-- Most Spaces are replaced by  "_ " in the diplomatic mode, but not in the regularized mode (often they are used where a regularized  transcription uses punctuation), since it is an empty element no template is necessary -->
    <xsl:template match="space[not(@type ='verseSpacing')]" mode="diplomatic">
        <xsl:variable name="noSp" select="@extent"/>
        <span title="extra space">
            <xsl:call-template name="spaces">
            <xsl:with-param name="count" select="$noSp"/>
        </xsl:call-template>
        </span>
    </xsl:template>  
    
    <!-- With spaces of @type="verseSpacing" inserts tab spaces (&#9;) between lines and half-lines of verse passages -->
    <xsl:template match="space[@type ='verseSpacing']" mode="diplomatic">
        <xsl:text>&#9;</xsl:text>        
    </xsl:template>
    <xsl:template match="space[@type ='verseSpacing']" mode="regularized">
        <xsl:text>&#9;</xsl:text>        
    </xsl:template>  
        
    
    <!-- Reference to Taisho page does not need to appear in diplomatic  form, since <anchor> is an empty element no template is necessary -->
    <xsl:template match="anchor[@corresp]" mode="regularized">
        <span class="taisho-ref">[<xsl:value-of select="@corresp"/>]</span>
    </xsl:template>
    
    <!-- PUNCTUATION________________________________________________________________ -->
    
    <!-- Tests if there is one or more resps, meaning the punctuation was in the MS. If so give it in the diplomatic transcription. Use our punctuation (not marked with @resp) only in the regularized output -->
    <xsl:template match="pc" mode="diplomatic"> 
        <xsl:choose>
            <xsl:when test="string-length(replace(normalize-space(@resp), ' ', '')) &gt; 0">
                <span class="handPunct"> <xsl:value-of select="."/></span>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="pc" mode="regularized">
        <xsl:choose>
            <xsl:when test="string-length(replace(normalize-space(@resp), ' ', '')) &gt; 0"/>
            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>

    <!-- STAGE ___________________________________________________________________________-->
    
    <xsl:template match="stage" mode="diplomatic">
        <xsl:apply-templates mode="diplomatic"/>
    </xsl:template>
    <xsl:template match="stage" mode="regularized">
        <xsl:text>(</xsl:text><xsl:apply-templates mode="regularized"/><xsl:text>)</xsl:text>  
    </xsl:template>
    
    
</xsl:stylesheet>
