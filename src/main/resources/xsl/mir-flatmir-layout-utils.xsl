<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">
    <div id="header_box" class="clearfix container">
      <div id="options_nav_box" class="mir-prop-nav">
        <nav>
          <ul class="navbar-nav ml-auto flex-row">
            <xsl:call-template name="mir.loginMenu" />
            <xsl:call-template name="mir.languageMenu" />
          </ul>
        </nav>
      </div>
      <div id="project_logo_box" class="project_logo_box">
        <a href="https://www.mhh.de/">
          <svg class="project_logo_box__logo">
            <use href="{$WebApplicationBaseURL}images/sprite-mhh.svg#icon-mhh-logo"></use>
          </svg>
        </a>
      </div>
      <a class="mhh-bibliothek" href="https://www.mhh.de/bibliothek">
        MHH-Bibliothek
      </a>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="mir-main-nav">
      <div class="container">
        <nav class="navbar navbar-expand-lg navbar-dark">
          <button
            class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#mir-main-nav-collapse-box"
            aria-controls="mir-main-nav-collapse-box"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div
            id="mir-main-nav-collapse-box"
            class="collapse navbar-collapse mir-main-nav__entries mb-3 mb-lg-0"
          >
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
              <xsl:call-template name="project.generate_single_menu_entry">
                <xsl:with-param name="menuID" select="'brand'" />
              </xsl:call-template>
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']" />
              <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']" />
              <xsl:call-template name="mir.basketMenu" />
            </ul>
          </div>
          <form
            action="{$WebApplicationBaseURL}servlets/solr/find"
            class="searchfield_box form-inline"
            role="search">
            <xsl:choose>
              <xsl:when test="contains($isSearchAllowedForCurrentUser, 'true')">
                <input name="owner" type="hidden" value="createdby:*" />
              </xsl:when>
              <xsl:when test="not($CurrentUser='guest')">
                <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
              </xsl:when>
            </xsl:choose>
            <div class="input-group">
              <input
                name="condQuery"
                placeholder="{document('i18n:mir.navsearch.placeholder')/i18n/text()}"
                class="form-control search-query"
                id="searchInput"
                type="text"
                aria-label="Search" />
              <div class="input-group-append">
                <button type="submit" class="btn text-primary bg-white">
                  <i class="fas fa-search"></i>
                </button>
              </div>
            </div>
          </form>
        </nav>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- disable jumbotwo -->
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="container">
      <div class="row mt-3">
        <div class="col-12 col-md">
          <div class="mhh-footer-contact">
            <h4>RepoMed</h4>
            <p>
              Telefon: +49 511/532-82655
              <br />
              E-Mail:
              <a href="mailto:forschungsdaten.bibliothek@mh-hannover.de">
                forschungsdaten.bibliothek@mh-hannover.de
              </a>
            </p>
          </div>
        </div>
        <div class="col-12 col-md text-right">
          <ul class="internal_links nav navbar-nav">
            <xsl:apply-templates
              select="$loaded_navigation_xml/menu[@id='below']/*"
              mode="footerMenu"
            />
          </ul>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="document('version:full')/version/text()" />
    <div id="powered_by">
      <a href="https://www.mycore.de">
        <img
          src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_small_invert.png"
          title="{$mcr_version}"
          alt="powered by MyCoRe"
        />
      </a>
    </div>
  </xsl:template>

  <xsl:template name="project.generate_single_menu_entry">
    <xsl:param name="menuID" />
    <li class="nav-item">
      <xsl:variable name="menuItem" select="$loaded_navigation_xml/menu[@id=$menuID]/item" />
      <xsl:variable name="activeClass">
        <xsl:choose>
          <xsl:when test="$menuItem/@href = $browserAddress">
            <xsl:text>active</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>not-active</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="fullUrl">
        <xsl:call-template name="resolveFullUrl">
          <xsl:with-param name="link" select="$menuItem/@href" />
        </xsl:call-template>
      </xsl:variable>
      <a id="{$menuID}" href="{$fullUrl}" class="nav-link {$activeClass}">
        <xsl:apply-templates select="$menuItem" mode="linkText" />
      </a>
    </li>
  </xsl:template>

  <xsl:template name="resolveFullUrl">
    <xsl:param name="link" />
    <xsl:param name="appBaseUrl" select="$WebApplicationBaseURL" />
    <xsl:choose>
      <xsl:when test="starts-with($link,'http:')
                      or starts-with($link,'https:')
                      or starts-with($link,'mailto:')
                      or starts-with($link,'ftp:')">
        <xsl:value-of select="$link"/>
      </xsl:when>
      <xsl:when test="starts-with($link,'/')">
        <xsl:choose>
          <xsl:when test="substring($appBaseUrl, string-length($appBaseUrl), 1) = '/'">
            <xsl:value-of
              select="concat(substring($appBaseUrl, 1, string-length($appBaseUrl) - 1), $link)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($appBaseUrl, $link)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="substring($appBaseUrl, string-length($appBaseUrl), 1) = '/'">
            <xsl:value-of select="concat($appBaseUrl, $link)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($appBaseUrl, '/', $link)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
