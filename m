Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:34170 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755607Ab3BGW3b (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Feb 2013 17:29:31 -0500
Date: Thu, 7 Feb 2013 23:29:27 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-watchdog@vger.kernel.org, zajec5@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
Message-ID: <20130207222927.GA28281@spo001.leaseweb.com>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hauke

> This patch series improves the functions for setting the watchdog 
> driver for bcm47xx based SoCs using ssb and bcma. This makes the 
> watchdog driver use the platform device provided by bcma or ssb.
> 
> This code is currently based on the linux-watchdog/master tree by 
> Wim Van Sebroeck.

V5 patches have been added to linux-watchdog-next.

Kind regards,
Wim.

