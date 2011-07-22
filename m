Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:15636 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753830Ab1GVRyR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jul 2011 13:54:17 -0400
Date: Fri, 22 Jul 2011 19:54:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/3] watchdog: remove empty pms
Message-ID: <20110722175406.GB31767@infomag.iguana.be>
References: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> While checking what watchdog drivers usually do in suspend/resume to
> spot common behaviour for the watchdog framework, I found these drivers
> which do nothing but add some cruft. Remove it, it is superfluous. New
> approaches should probably be done with pm_ops anyway.
> 
> Wolfram Sang (3):
>   watchdog: at91: remove empty pm-functions
>   watchdog: iTCO: remove empty pm-functions
>   watchdog: sch311x: remove empty pm-functions
> 
>  drivers/watchdog/at91sam9_wdt.c |   19 -------------------
>  drivers/watchdog/iTCO_wdt.c     |    5 -----
>  drivers/watchdog/sch311x_wdt.c  |    5 -----
>  3 files changed, 0 insertions(+), 29 deletions(-)

All 3 patches added as a single patch into linux-2.6-watchdog-next.

Kind regards,
Wim.

