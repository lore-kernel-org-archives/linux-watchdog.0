Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0103.outbound.protection.outlook.com ([65.55.169.103]:3232
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752485AbaILIBQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Sep 2014 04:01:16 -0400
Date: Fri, 12 Sep 2014 15:45:12 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Lu Jingchang-B35083 <jingchang.lu@freescale.com>
CC: Guenter Roeck <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] watchdog: imx2_wdt: add restart handler support
Message-ID: <20140912074510.GJ18566@dragon>
References: <1410421661-15298-1-git-send-email-jingchang.lu@freescale.com>
 <20140911155522.GB13052@roeck-us.net>
 <299ae9bd88c049ea833e964e4b5f54a0@BL2PR03MB467.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <299ae9bd88c049ea833e964e4b5f54a0@BL2PR03MB467.namprd03.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 12, 2014 at 10:42:10AM +0800, Lu Jingchang-B35083 wrote:
> >> @@ -77,6 +81,31 @@ static const struct watchdog_info imx2_wdt_info = {
> >>  	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
> >>  };
> >>
> >> +static int imx2_restart_handler(struct notifier_block *this, unsigned
> >long mode,
> >> +				void *cmd)
> >> +{
> >> +	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
> >
> >In the original code this value is conditional depending on cpu_is_mx1().
> >Are there any implications for this reset mechanism ? Does mx1 have a
> >different watchdog driver ?
> >
> Hi, Shawn, is this driver also used by the mx1 SoC? 
> The imx2_wdt.c says it is for IMX2 and later processors, so when moving the
> restart function, I removed the cpu_is_mx1() condition determination, Thanks.

I think the driver only works for i.MX2 and later ones.

Shawn
