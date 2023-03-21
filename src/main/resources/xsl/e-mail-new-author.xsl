<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="DefaultLang" />
  <xsl:param name="WebApplicationBaseURL" />
  <xsl:param name="ServletsBaseURL" />
  <xsl:param name="MCR.mir-module.MailSender" />
  <xsl:variable name="newline" select="'&#xA;'" />

  <xsl:template match="/">
    <email>
      <from><xsl:value-of select="$MCR.mir-module.MailSender" /></from>
      <xsl:apply-templates select="/*" mode="email" />
    </email>
  </xsl:template>

  <xsl:template match="user" mode="email">
    <to>
      <xsl:value-of select="eMail/text()" />
    </to>
    <subject>
      <xsl:value-of select="'Benutzerkennung wurde angelegt; Your useraccout has been created'"/>
    </subject>
    <body>
      You found the englisch Version at the and of the mail.
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Liebe Benutzerin,'"/>
      <xsl:value-of select="'lieber Benutzer,'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'vielen Dank für Ihre Anmeldung bei „RepoMed“, dem Repositorium der '"/> 
      <xsl:value-of select="'Medizinischen Hochschule Hannover.'"/>  
      <xsl:value-of select="'Bitte benutzen Sie den folgenden Link um Ihre E-Mail-Adresse zu bestätigen und die Registrierung abzuschließen.'"/>
      <xsl:value-of select="$newline" /> 
      <xsl:value-of
        select="concat('&lt;', $ServletsBaseURL, 'MirSelfRegistrationServlet?action=verify&amp;user=', @name, '&amp;realm=', @realm, '&amp;token=', attributes/attribute[@name='mailtoken']/@value, '&gt;')" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Anschließend haben Sie als „Leser“ den Zugriff auf die Forschungsdaten '"/>
      <xsl:value-of select="'der Restriktionsstufe „lediglich für angemeldete Nutzer“.'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Mit freundlichen Grüßen'"/>
      <xsl:value-of select="$newline" /> 
      <xsl:value-of select="'Ihr Team Forschungsdatenmanagement der MHH'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'--'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Bibliothek, Team Forschungsdatenmanagement'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Medizinische Hochschule Hannover (MHH)'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'OE 8900, Carl-Neuberg-Str. 1, 30625 Hannover, Deutschland'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Tel.: +49 511-532-5578'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Forschungsdaten.Bibliothek@mh-hannover.de'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'https://www.mhh.de/bibliothek'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Dear user, '"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Thank you for registering with „RepoMed“, the repository of Hannover Medical School. Please use the following link to confirm your e-mail address and complete the registration.'"/>
      <xsl:value-of select="$newline" /> 
      <xsl:value-of
        select="concat('&lt;', $ServletsBaseURL, 'MirSelfRegistrationServlet?action=verify&amp;user=', @name, '&amp;realm=', @realm, '&amp;token=', attributes/attribute[@name='mailtoken']/@value, '&gt;')" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Afterwards you will have access to the research data of the restriction level „only for registered users“ as a „reader“.'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'With kind regards,'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Your Team Research Data Management of the MHH'"/>
      <xsl:value-of select="$newline" /> 
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'--'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Library, Team Research Data Management'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Hannover Medical School (MHH)'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'OE 8900, Carl-Neuberg-Str. 1, 30625 Hanover, Germany'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Tel.: +49 511-532-5578'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'Forschungsdaten.Bibliothek@mh-hannover.de'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="'https://www.mhh.de/en/library'"/>
      <xsl:value-of select="$newline" />
      <xsl:value-of select="$newline" />
    </body>
  </xsl:template>
</xsl:stylesheet>
