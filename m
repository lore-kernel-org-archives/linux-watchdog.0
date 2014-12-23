Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0136.outbound.protection.outlook.com ([65.55.169.136]:18800
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753913AbaLWDBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Dec 2014 22:01:49 -0500
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v3] watchdog: imx2_wdt: Add power management support.
Date: Tue, 23 Dec 2014 02:28:50 +0000
Message-ID: <BY2PR0301MB0613089E00A5780B55A01C979B570@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1413431055-41805-1-git-send-email-Li.Xiubo@freescale.com>
 <20141222140436.GA27760@spo001.leaseweb.nl>
In-Reply-To: <20141222140436.GA27760@spo001.leaseweb.nl>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

Get it.

Thanks very much.

BRs
Xiubo


> -----Original Message-----
> From: wimvs@spo001.leaseweb.nl [mailto:wimvs@spo001.leaseweb.nl] On Behalf Of
> Wim Van Sebroeck
> Sent: Monday, December 22, 2014 10:05 PM
> To: Xiubo Li-B47053
> Cc: linux@roeck-us.net; linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH v3] watchdog: imx2_wdt: Add power management support.
> 
> Hi,
> 
> > Add power management operations(suspend and resume) as part of
> > dev_pm_ops for IMX2 watchdog driver.
> >
> > If PM will be supported, please make sure that the wdev->clk
> > could disable the watchdog's counter input clock source or can
> > mask watchdog's reset request to the core.
> >
> > If watchdog is still used by consumers and resumes from deep
> > sleep state, we need to restart the watchdog again without
> > enabling the timer.
> >
> > If watchdog been has started --> stopped by the consumers and
> > resumes from non-deep sleep state, then start the timer again.
> >
> > If watchdog has been started --> stopped by the consumers and
> > resumes from deep sleep state, will do nothing. The watchdog
> > will be restarted by consumers next time to be used.
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >
> > Change in V3:
> > - Uses standard multi-line comments.
> 
> V1 went upstream (my mistake), diff between V1 and V3 is now in linux-
> watchdog-next.
> 
> Kind regards,
> Wim.

