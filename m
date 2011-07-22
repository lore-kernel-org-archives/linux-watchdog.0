Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:59555 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754573Ab1GVS2K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jul 2011 14:28:10 -0400
Date: Fri, 22 Jul 2011 20:28:08 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 7/7] at91sam9/wdt: move register header to drivers
Message-ID: <20110722182808.GD31767@infomag.iguana.be>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com> <1310687525-22486-7-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1310687525-22486-7-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean-Christophe,

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-watchdog@vger.kernel.org
> ---
>  drivers/watchdog/at91sam9_wdt.c                    |    2 +-
>  .../at91_wdt.h => drivers/watchdog/at91sam9_wdt.h  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/mach-at91/include/mach/at91_wdt.h => drivers/watchdog/at91sam9_wdt.h (96%)

Added this patch to the linux-2.6-watchdog-next tree.

Kind regards,
Wim.

