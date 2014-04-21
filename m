Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56433 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaDUSQ4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Apr 2014 14:16:56 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so3916834pdj.17
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Apr 2014 11:16:56 -0700 (PDT)
Date: Mon, 21 Apr 2014 11:16:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Ernst <eric.ernst@intel.com>
Cc: linux-watchdog@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Intel MID vs. Intel SCU watchdog
Message-ID: <20140421181652.GA31616@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

with the recent submission of an Intel MID watchdog driver, we now have

config INTEL_SCU_WATCHDOG
        bool "Intel SCU Watchdog for Mobile Platforms"
	depends on X86_INTEL_MID
	---help---
	  Hardware driver for the watchdog time built into the Intel SCU
	  for Intel Mobile Platforms.


config INTEL_MID_WATCHDOG
        tristate "Intel MID Watchdog Timer"
	depends on X86_INTEL_MID
	--help--
	  Watchdog timer driver built into the Intel SCU for Intel MID Platforms.

	  This driver currently supports only the watchdog evolution
	  implementation in SCU, available for Merrifield generation.

Furthermore, in the SCU watchdog driver initialization code, we have

	...
	 * If it isn't an intel MID device then it doesn't have this watchdog
         */
         if (!intel_mid_identify_cpu())
                  return -ENODEV;

I must admit I find this very confusing. Both watchdogs have the same
dependencies. The MID watchdog driver only instantiates for Tangier,
while the SCU watchdog driver instantiates for all MID CPUs (specfically
including Tangier, but also Penwell and Cloverview and, from earlier
commit logs, Moorsetown).

I understand I was told earlier that the supported devices would be
"sufficiently different" to warrant separate drivers, but this doesn't
really make sense to me, at least not without further explanation.

Can someone please clarify which driver is supposed to work on which device,
and why there are now two watchdog drivers for Tangier (or at least two
watchdog drivers which instantiate on Tangier) ? Does the SCU driver work
on Tangier, or does it not ? If not, why is there no code in the SCU driver
which would cause it to fail to instantiate on Tangier, and why is this
limitation not mentioned in Kconfig ? If yes, why do we need separate drivers
in the first place ?

Thanks,
Guenter
