Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:50082 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754396AbaLVOEk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Dec 2014 09:04:40 -0500
Date: Mon, 22 Dec 2014 15:04:36 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: imx2_wdt: Add power management support.
Message-ID: <20141222140436.GA27760@spo001.leaseweb.nl>
References: <1413431055-41805-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413431055-41805-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

> Add power management operations(suspend and resume) as part of
> dev_pm_ops for IMX2 watchdog driver.
> 
> If PM will be supported, please make sure that the wdev->clk
> could disable the watchdog's counter input clock source or can
> mask watchdog's reset request to the core.
> 
> If watchdog is still used by consumers and resumes from deep
> sleep state, we need to restart the watchdog again without
> enabling the timer.
> 
> If watchdog been has started --> stopped by the consumers and
> resumes from non-deep sleep state, then start the timer again.
> 
> If watchdog has been started --> stopped by the consumers and
> resumes from deep sleep state, will do nothing. The watchdog
> will be restarted by consumers next time to be used.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
> 
> Change in V3:
> - Uses standard multi-line comments.

V1 went upstream (my mistake), diff between V1 and V3 is now in linux-watchdog-next.

Kind regards,
Wim.

