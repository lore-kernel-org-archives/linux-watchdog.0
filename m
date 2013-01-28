Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:32906 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754074Ab3A1Vfq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Jan 2013 16:35:46 -0500
Date: Mon, 28 Jan 2013 22:35:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-watchdog@vger.kernel.org, zajec5@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
Message-ID: <20130128213544.GB3338@spo001.leaseweb.com>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de> <51016C4D.40707@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51016C4D.40707@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hauke,

> what is the status of these patches?

First reading/checking (v4+v5) seems OK.
1 small remark allready: the settimeout functions seem to check the min and max timeout values.
Can't you use the min and max values of the watchdog structure for this?

Kind regards,
Wim.

