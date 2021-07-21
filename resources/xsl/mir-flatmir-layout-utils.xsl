<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:param name="piwikID" select="'0'" />

  <xsl:template name="mir.navigation">

    <div id="header_box" class="clearfix container">
      <div id="options_nav_box" class="mir-prop-nav">

        <!-- do not show on startpage -->
        <xsl:if test="not(//div/@class='jumbotwo')">
          <div class="searchfield_box">
            <form action="{$WebApplicationBaseURL}servlets/solr/find" class="navbar-form navbar-left pull-right" role="search">
              <div class="form-group">
                <input name="condQuery" placeholder="{i18n:translate('mir.navsearch.placeholder')}" class="form-control search-query" id="searchInput" type="text" />
                <xsl:choose>
                  <xsl:when test="mcrxsl:isCurrentUserInRole('admin') or mcrxsl:isCurrentUserInRole('editor')">
                    <input name="owner" type="hidden" value="createdby:*" />
                  </xsl:when>
                  <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
                    <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                  </xsl:when>
                </xsl:choose>
              </div>
              <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
            </form>
          </div>
        </xsl:if>

        <nav>
          <ul class="nav navbar-nav navbar-right">
            <xsl:call-template name="mir.loginMenu" />
            <!-- xsl:call-template name="mir.languageMenu" / -->
          </ul>
        </nav>
        <br />
        <a href="https://www.mhh.de/bibliothek" id="mhh-bibliothek"><xsl:value-of select="i18n:translate('mhh.mhhLibrary')" /></a>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar navbar-default mir-main-nav">
      <div class="container">

        <div class="navbar-header">
          <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".mir-main-nav-entries">
            <span class="sr-only"> Toggle navigation </span>
            <span class="icon-bar">
            </span>
            <span class="icon-bar">
            </span>
            <span class="icon-bar">
            </span>
          </button>
          <div id="project_logo_box">
            <a href="https://www.mhh.de/"
               class="">
              <img src="{$WebApplicationBaseURL}images/logo_schriftzug.gif" alt="Medizinischen Hochschule Hannover (MHH)" title="zur Startseite" />
            </a>
          </div>
        </div>

        <nav class="collapse navbar-collapse mir-main-nav-entries">
          <ul class="nav navbar-nav pull-left">
            <xsl:for-each select="$loaded_navigation_xml/menu">
              <xsl:choose>
                <xsl:when test="@id='main'"/> <!-- Ignore some menus, they are shown elsewhere in the layout -->
                <xsl:when test="@id='brand'">
                  <xsl:apply-templates select="./*" />
                </xsl:when>
                <xsl:when test="@id='below'"/>
                <xsl:when test="@id='user'"/>
                <xsl:otherwise>
                  <xsl:apply-templates select="." />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
            <xsl:call-template name="mir.basketMenu" />
          </ul>
        </nav>

      </div><!-- /container -->
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing special -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row">
        <div class="col-xs-12 col-sm-4">
          <p>
            Kontakt<br />
            Telefon: 0511/532-3326<br />
            E-Mail: <span class="madress">information.bibliothek [at] mh-hannover.de</span>
            
          </p>
        </div>
        <div class="hiddeb-xs col-sm-4">
          <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
          <div id="powered_by">
            <a id="mycore_logo" href="http://www.mycore.de">
              <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png" title="{$mcr_version}" alt="powered by MyCoRe" />
            </a>
          </div>
        </div>
        <div class="col-xs-12 col-sm-4">
          <ul class="internal_links nav navbar-nav">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
          </ul>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <!-- Piwik -->
    <xsl:if test="$piwikID &gt; 0">
      <script type="text/javascript">
        var _paq = _paq || [];
        _paq.push(['setDoNotTrack', true]);
        _paq.push(['trackPageView']);
        _paq.push(['enableLinkTracking']);
        (function() {
        var u="https://matomo.gbv.de/";
        var objectID = '<xsl:value-of select="//site/@ID" />';
        if(objectID != "") {
        _paq.push(["setCustomVariable",1, "object", objectID, "page"]);
        }
        _paq.push(['setTrackerUrl', u+'piwik.php']);
        _paq.push(['setSiteId', '<xsl:value-of select="$piwikID" />']);
        _paq.push(['setDownloadExtensions', '7z|aac|arc|arj|asf|asx|avi|bin|bz|bz2|csv|deb|dmg|doc|exe|flv|gif|gz|gzip|hqx|jar|jpg|jpeg|js|mp2|mp3|mp4|mpg|mpeg|mov|movie|msi|msp|odb|odf|odg|odp|ods|odt|ogg|ogv|pdf|phps|png|ppt|qt|qtm|ra|ram|rar|rpm|sea|sit|tar|tbz|tbz2|tgz|torrent|txt|wav|wma|wmv|wpd|z|zip']);
        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
        g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
        })();
      </script>
      <noscript><p><img src="https://matomo.gbv.de/piwik.php?idsite={$piwikID}" style="border:0;" alt="" /></p></noscript>
    </xsl:if>
    <!-- End Piwik Code -->
  </xsl:template>
  
</xsl:stylesheet>