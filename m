Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55329 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab2BAN04 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Feb 2012 08:26:56 -0500
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
	kernel@pengutronix.de
Subject: [RESEND] Congatec CGEB base, i2c and watchdog driver support
Date: Wed,  1 Feb 2012 14:26:30 +0100
Message-Id: <1328102793-4313-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a resend of the series I posted in january, only difference
is that this time I have included the i2c and watchdog lists. To
minimize dependencies I suggest pushing this via the mfd tree, given
I get acks on the I2C and watchdog part.

The following series adds support for the Congatec CGEB interface
found on some Congatec x86 boards. The CGEB interface is a BIOS
interface which provides access to onboard peripherals like I2C
busses and watchdogs. It works by mapping BIOS code and searching
for magic values which specify the entry points to the CGEB call.
The CGEB call is an API provided by the BIOS which provides access
to the functions in an ioctl like fashion.

For more information about the CGEB API have a look at:

http://www.congatec.com/single_news+M5d58c9cd155.html

This document only describes the C API, unfortunately not the
underlying BIOS interface.

Comments very appreciated.

Sascha

Sascha Hauer (3):
      mfd: Add basic support for the Congatec CGEB BIOS interface
      i2c: Add Congatec CGEB I2C driver
      watchdog: Add Congatec CGEB watchdog driver

 drivers/i2c/busses/Kconfig                |    7 +
 drivers/i2c/busses/Makefile               |    1 +
 drivers/i2c/busses/i2c-congatec-cgeb.c    |  206 ++++++++++
 drivers/mfd/Kconfig                       |   10 +
 drivers/mfd/Makefile                      |    1 +
 drivers/mfd/congatec-cgeb.c               |  590 +++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig                  |    9 +
 drivers/watchdog/Makefile                 |    1 +
 drivers/watchdog/congatec_cgeb_watchdog.c |  181 +++++++++
 include/linux/mfd/congatec-cgeb.h         |  105 +++++
 10 files changed, 1111 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-congatec-cgeb.c
 create mode 100644 drivers/mfd/congatec-cgeb.c
 create mode 100644 drivers/watchdog/congatec_cgeb_watchdog.c
 create mode 100644 include/linux/mfd/congatec-cgeb.h

