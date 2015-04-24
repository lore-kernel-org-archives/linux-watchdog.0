Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45613 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757949AbbDXTLE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 15:11:04 -0400
Date: Fri, 24 Apr 2015 21:10:59 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Felipe Balbi <balbi@ti.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Lokesh Vutla <lokeshvutla@ti.com>, kernel@pengutronix.de,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: omap: put struct watchdog_device into
 driver data
Message-ID: <20150424191059.GW19431@pengutronix.de>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150424144448.GC5692@saruman.tx.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150424144448.GC5692@saruman.tx.rr.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Felipe,

On Fri, Apr 24, 2015 at 09:44:48AM -0500, Felipe Balbi wrote:
> On Fri, Apr 24, 2015 at 11:48:32AM +0200, Uwe Kleine-König wrote:
> > This way only a single allocation is needed (per device). Also this
> > stops making use of watchdog_{set,get}_drvdata.
> 
> And this is better because ... ?
a single allocation is better because AFAIK it takes less memory to
allocate a + b bytes in a single piece than in two.

watchdog_{set,get}_drvdata seems ugly to me. Judging from the other
frameworks I know better than wdog I'd say there is no need for these
functions. I didn't know if I should be more explicit about my view in
the commitlog and if so how.

Also I didn't check other wdog drivers, but using this style of
embedding the "framework struct" into driver data is a common idiom for
uart and gpio drivers for example.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
