Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:44609 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751333Ab2ITIAT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Sep 2012 04:00:19 -0400
Date: Thu, 20 Sep 2012 10:00:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Javier Martin <javier.martin@vista-silicon.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 18/34] watchdog: imx2_wdt: remove unneeded mach/hardware.h inclusion
Message-ID: <20120920080009.GB16482@spo001.leaseweb.com>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org> <1348123547-31082-19-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1348123547-31082-19-git-send-email-shawn.guo@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> The inclusion of mach/hardware.h is not used by the driver at all.
> Remove it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

