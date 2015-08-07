Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43473 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbHGKRy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 06:17:54 -0400
Message-ID: <1438942673.3638.16.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] watchdog: da9063: Ping watchdog only during allowed
 time window
From: Philipp Zabel <p.zabel@pengutronix.de>
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Date: Fri, 07 Aug 2015 12:17:53 +0200
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB569C3B@SW-EX-MBX01.diasemi.com>
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
	 <2E89032DDAA8B9408CB92943514A0337AB569C3B@SW-EX-MBX01.diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Adam,

Am Freitag, den 07.08.2015, 10:13 +0000 schrieb Opensource [Adam
Thomson]:
> On August 06, 2015 17:37, Philipp Zabel wrote:
> 
> > There is a cooldown period after watchdog timer setup, and also after each
> > watchdog ping. If a ping is issued too early, the watchdog triggers the
> > watchdog error condition and causes a system reset.
> > 
> > The 256 ms period length is a best guess based on the same value being used
> > for the DA9053 predecessor PMIC and experiments that have shown 200 ms are
> > not enough to avoid the error.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> My colleague Stephen is out of office for the next two weeks, but really I
> think he should review these two patches given his knowledge of the device. If
> you can hold off until then, he should be able to provide feedback.

Absolutely, thank you for the heads-up.

regards
Philipp

