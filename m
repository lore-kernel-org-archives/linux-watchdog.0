Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:42247 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136Ab0KDOxT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Nov 2010 10:53:19 -0400
Date: Thu, 4 Nov 2010 15:53:17 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-watchdog@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH] m68knommu,watchdog: Add MCF548x watchdog driver.
Message-ID: <20101104145317.GO4046@infomag.iguana.be>
References: <20101103140728.GA25556@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101103140728.GA25556@frolo.macqel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Philippe,

> 
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> ---
>  arch/m68k/include/asm/m548xgpt.h |    2 +
>  drivers/watchdog/Kconfig         |    7 +-
>  drivers/watchdog/Makefile        |    3 +-
>  drivers/watchdog/m548x_wdt.c     |  227 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/watchdog/m548x_wdt.c

Will look at this after I looked at some other patches and after review of 2 other new watchdog drivers.
So expect something within 2 weeks.

Kind regards,
Wim.

