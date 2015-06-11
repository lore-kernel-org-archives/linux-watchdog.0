Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35179 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbbFKUtR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Jun 2015 16:49:17 -0400
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sameo@linux.intel.com, lee.jones@linaro.org, wsa@the-dreams.de,
	jdelvare@suse.de, linux-i2c@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, jingoohan1@gmail.com
Subject: [PATCH 0/4] Add support for Congatec CGEB BIOS interface 
Date: Thu, 11 Jun 2015 22:48:50 +0200
Message-Id: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The following series adds support for the Congatec CGEB interface
found on some Congatec x86 boards. The CGEB interface is a BIOS
interface which provides access to onboard peripherals like I2C
busses and watchdogs. It works by mapping BIOS code and searching
for magic values which specify the entry points to the CGEB call.
The CGEB call is an API provided by the BIOS which provides access
to the functions in an ioctl like fashion.

This series is based on patches from Sascha Hauer, which can be found
here:

http://patchwork.ozlabs.org/patch/219756/
http://patchwork.ozlabs.org/patch/219755/
http://patchwork.ozlabs.org/patch/219757/

I really want to get this patches into mainline, as I am carry them
for too long.

