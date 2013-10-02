Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:43752 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab3JBR7r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Oct 2013 13:59:47 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so1229260pbb.13
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Oct 2013 10:59:47 -0700 (PDT)
Date: Wed, 2 Oct 2013 10:59:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Rob Landley <rob@landley.net>,
	Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Dinh Nguyen <dinguyen@altera.com>,
	Pavel Machek <pavel@denx.de>, Jamie Iles <jamie@jamieiles.com>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	John Crispin <blogic@openwrt.org>,
	Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Felipe Balbi <balbi@ti.com>
Subject: New watchdog and watchdog-next branches to augment the existing ones
Message-ID: <20131002175937.GA4811@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

to support Wim in his efforts to maintain the watchdog subsystem,
I created two new branches in my repository at kernel.org
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

The two branches are
	watchdog	for watchdog patches I believe should be applied
			to the current upstream kernel
	watchdog-next	for patches I believe are ready to be pushed upstream
			in the next commit window.

Both branches may and will be rebased from time to time as I see fit. watchdog
will in general be based on a recent upstream tag, and watchdog-next will be
based on watchdog. As of today, the watchdog branch is based on v3.12-rc3.

The new branches are not supposed to replace Wim's repository, but to augment it.
It enables me to run my own automated build tests (see
http://server.roeck-us.net:8010/builders for current build results), and it will
hopefully trigger builds by Fengguang's build robots with the various patches
applied.

I also set up patchwork to track the watchdog mailing lists at
http://server.roeck-us.net/project/linux-watchdog/list/. This is mostly for
myself to ensure that patches don't get lost, but it is accessible for others
as well.

I hope this will help Wim in deciding if and when to push patches upstream; at
the very least it will provide additional test coverage. Note that I don't plan
to add the watchdog-next branch to linux-next, as the decision if and when
to push patches upstream is up to Wim to make.

Thanks,
Guenter

---
P.s.: If you are on the Cc: list, it is most likely because you signed off
at least one of the patches in one of the branches.
