<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title><xsl:value-of select="/rss/channel/title"/> — RSS Feed</title>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
          :root { color-scheme: light dark; }
          body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Sarabun", system-ui, sans-serif;
            max-width: 800px; margin: 2rem auto; padding: 0 1rem;
            line-height: 1.7; color: #333; background: #fff;
          }
          h1 { font-size: 1.5rem; margin-bottom: .25rem; }
          .subtitle { color: #666; margin-bottom: 1.5rem; }
          .callout {
            background: #f6f6f6; border-left: 4px solid #0066cc;
            padding: 1rem; border-radius: 6px; margin-bottom: 2rem;
          }
          .callout code {
            background: #fff; padding: .2rem .5rem; border-radius: 4px;
            font-size: .9rem; word-break: break-all;
          }
          .item { padding: 1.25rem 0; border-top: 1px solid #e5e5e5; }
          .item h2 { font-size: 1.15rem; margin: 0 0 .25rem; }
          .item a { color: #0066cc; text-decoration: none; }
          .item a:hover { text-decoration: underline; }
          .meta { color: #888; font-size: .875rem; margin-bottom: .5rem; }
          @media (prefers-color-scheme: dark) {
            body { background: #1a1a1a; color: #e5e5e5; }
            .callout { background: #242424; border-left-color: #4aa8ff; }
            .callout code { background: #1a1a1a; }
            .item { border-top-color: #333; }
            .item a { color: #4aa8ff; }
            .subtitle { color: #aaa; }
          }
        </style>
      </head>
      <body>
        <div class="callout">
          <strong>📡 RSS Feed</strong><br/>
          คัดลอก URL นี้ไปใช้ใน RSS Reader ของคุณ:<br/>
          <code><xsl:value-of select="/rss/channel/atom:link/@href"/></code>
        </div>
        <h1><xsl:value-of select="/rss/channel/title"/></h1>
        <p class="subtitle"><xsl:value-of select="/rss/channel/description"/></p>
        <xsl:for-each select="/rss/channel/item">
          <div class="item">
            <h2><a href="{link}"><xsl:value-of select="title"/></a></h2>
            <div class="meta"><xsl:value-of select="pubDate"/></div>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
