Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:35852 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756133Ab3BRULs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Feb 2013 15:11:48 -0500
Date: Mon, 18 Feb 2013 21:11:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: Re: [PATCH v9 0/8]  watchdog: dt: add support for the timeout-sec dt property
Message-ID: <20130218201144.GP7867@spo001.leaseweb.com>
References: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1360829670-10418-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

> Hi all,
> this patchset add the timeout-sec property to the watchdog core,
> to the at91sam9_wdt driver and on all framework enabled watchdog driver
> with dt support.
> The at91sam9_wdt is tested on evk-pr3,
> the other drivers are compile tested only.
> 
> Hi Wim,
> because the first two patches are fixes for the
> patch 433bf8dc344c0eacb3ff5bbc1aea42f75b170a72 already included in 
> watchdog-next feel free to squash them.

added to linux-watchdog-next.

Kind regards,
Wim.

