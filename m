Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59596 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755400Ab3H3TOR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Aug 2013 15:14:17 -0400
Date: Fri, 30 Aug 2013 21:14:13 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	maxime.ripard@free-electrons.com, henrik@henriknordstrom.net,
	linux@roeck-us.net
Subject: Re: [PATCH v7] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130830191413.GA27703@spo001.leaseweb.com>
References: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
> 
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/watchdog/Kconfig     |  10 ++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/sunxi_wdt.c | 237 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/watchdog/sunxi_wdt.c

Added to linux-watchdog-next.

Kind regards,
Wim.

