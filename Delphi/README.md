Delphi Developer's Guide to XML
Chapter 20 - Applying XSL Transformations

Previous   Next   Listings
Use XSLT to convert your XML documents into other formats, including HTML, plain text, and XML, before sending them out to the user.

StyleView.dpr	  	A utility for applying XSL transformations to XML documents using Microsoft's DOM
StyleView1.pas
StyleView1.dfm	  	The main viewer form
movie-watcher.xml	  	The XML document to be manipulated
movie-watcher.dtd	  	Its DTD
movie-watcher-mono.xsl	  	A monolithic XSLT stylesheet to display the XML as HTML
movie-watcher-tmplt.xsl	  	A template-based version of the preceeding XSLT stylesheet
movie-watcher-csv.xsl	  	An XSLT stylesheet to display the XML as comma-separated values
movie-watcher-rtf.xsl	  	An XSLT stylesheet to display the XML as a rich-text formatted document