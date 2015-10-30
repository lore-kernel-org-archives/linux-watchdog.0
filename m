Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:35168 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbJ3O1Z (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 10:27:25 -0400
Date: Fri, 30 Oct 2015 10:27:19 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, kernel@savoirfairelinux.com
Subject: Re: [PATCH 2/4] watchdog: ts4800: add new driver for TS-4800 watchdog
Message-ID: <20151030142719.GB7403@localhost>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <6804900.txcGkbUFcL@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6804900.txcGkbUFcL@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 30, 2015 at 01:53:00PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 October 2015 16:33:39 Damien Riegel wrote:
> > +static void ts4800_write_feed(struct ts4800_wdt *wdt, u16 val)
> > +{
> > +       __raw_writew(val, wdt->base + TS4800_WTD_FEED);
> > +}
> > +
> > 
> 
> Using __raw_writew() is broken when you run a big-endian kernel. Better always
> use the normal writew() in device drivers.

Noted for future work. Anyway, this has changed in v2 and the driver now
uses regmap_write instead of __raw_writew, so the endianess issue should
already be taken care of.

Damien
