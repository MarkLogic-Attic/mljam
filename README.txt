MLJAM is an open source library that enables the evaluation of Java code from
the MarkLogic Server environment.  MLJAM gives XQuery programs access to the
vast libraries and extensive capabilities of Java, without any difficult glue
coding.  Example uses for MLJAM:

* Extracting image metadata
* Resizing and reformatting an image
* Running an XSLT transformation
* Generating a PDF from XSL-FO
* Calculating an MD5 hash
* Interfacting into a user authentication system
* Accessing a credit card purchasing system
* Connecting to a secure HTTPS web site
* Re-encoding content as UTF-8

The MLJAM Tutorial has more information:
http://xqzone.marklogic.com/howto/tutorials/2006-05-mljam.xqy


Source Components
-----------------

The "client" directory holds the jam.xqy library module.  That's the only file
needed from XQuery.

The "server" directory holds the servlet with which the XQuery communicates.
The Java code is straightforward: it listens for requests from the XQuery
client, transmits the request to a BeanShell interpreter held within, and
returns any result to the XQuery client.

The "utils" directory holds jam-utils.xqy, containing utility functions for
PDF generation using Apache FOP, image resizing and conversion, image metadata
extraction, MD5 hashing, and XSLT transformation.  The "utils/lib" directory
holds JARs needed by the server to support the jam-utils.xqy client.


Building
--------

Just run "ant".  It produces zip files under the "distribution" directory and
a "buildtmp" support directory.


Installation
------------

The tutorial above explains the basic steps of an install.

