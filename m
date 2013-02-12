Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49563 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab3BLKDF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Feb 2013 05:03:05 -0500
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Congatec CGEB base, i2c and watchdog driver support
Date: Tue, 12 Feb 2013 11:02:51 +0100
Message-Id: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I'd like to come back to this topic. I have sent patches last year
already, changes to the last time I posted this is mainly that
I moved the CGEB base support from drivers/mfd/ to arch/x86/platform/
like suggested by Samuel Ortiz back then.

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

Also added are two users of this interface, a i2c master driver
and a watchdog driver.

Comments very appreciated.

Sascha

