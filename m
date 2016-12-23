Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([85.17.2.162]:60912 "EHLO spo001.leaseweb.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751340AbcLWKfu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Dec 2016 05:35:50 -0500
Date: Fri, 23 Dec 2016 11:07:54 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL REQUEST] watchdog - v4.10 merge window
Message-ID: <20161223100754.GA19660@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Due to time constraints and personal issues Guenter and I decided that this window will be a pull from another location.
So please pull from 'watchdog-for-linus-v4.10' branch of
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

It contains the following patches:
* Add da9062/61 watchdog driver
* Add Loongson1 SoC watchdog driver
* Add IT8620E watchdog device
* module load /uload fixes for bcm7083_wdt, max77620_wdt and jz4740
* intel-mid_wdt fixes
* and other fixes and cleanups 

Greetings,
Wim.

