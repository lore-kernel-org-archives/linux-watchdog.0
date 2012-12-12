Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:36084 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754849Ab2LLUXf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Dec 2012 15:23:35 -0500
Date: Wed, 12 Dec 2012 21:23:31 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] watchdog: imx2_wdt: Select the driver via ARCH_MXC
Message-ID: <20121212202331.GA31012@spo001.leaseweb.com>
References: <1341264782-19098-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1341264782-19098-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio,

> With device tree support in place, we should not use IMX_HAVE_PLATFORM_IMX2_WDT
> as a dependency for selecting the imx2_wdt driver.
> 
> Use ARCH_MXC symbol instead, so that the driver can be even selected by a device-tree
> only SoC, such as i.MX6. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Added to linux-watchdog-next.

Kind regards,
Wim.

