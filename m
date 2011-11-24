Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:55441 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753730Ab1KXOmV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Nov 2011 09:42:21 -0500
Received: from mail95.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id CBA71DCDC4B
	for <linux-watchdog@vger.kernel.org>; Thu, 24 Nov 2011 15:48:44 +0100 (CET)
Date: Thu, 24 Nov 2011 15:42:17 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: wim@iguana.be
Cc: w.sang@pengutronix.de, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, HaraldWelte@viatech.com,
	broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <4ece57c9.2i1u841q3U3s+xD7%marc.vertes@sigfox.com>
References: <20111122173227.GK6624@sirena.org.uk>
 <20111122184051.GA30941@pengutronix.de>
 <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com>
 <20111123104926.GB4063@pengutronix.de>
 <20111123121329.GM23376@infomag.iguana.be>
 <20111123122018.GA12227@opensource.wolfsonmicro.com>
 <20111123124037.GN23376@infomag.iguana.be>
 <4ecd075d.2YyTTCA13zxwZmwT%marc.vertes@sigfox.com>
 <20111123214614.GQ23376@infomag.iguana.be>
 <4ece231e./LkW+9i4Wmz+9zzn%marc.vertes@sigfox.com>
 <20111124134247.GS23376@infomag.iguana.be>
In-Reply-To: <20111124134247.GS23376@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wim Van Sebroeck <wim@iguana.be> wrote:

> > Regarding the timer, the driver can not read the timeout value set in
> > the BIOS, so there is still a risk of reboot if the BIOS value is lower
> > than driver one. I assume that other drivers may be in the same case,
> > and that is required for user compatibility anyway.
>
> The driver assumes 1 second as heartbeat of the watchdog device.
> It thus takes half of this time do actually 'tickle' the watchdog. (or 500ms).
> We should set this 1 second value to the smallest time that is possible (either
> the smallest value that can be set in the BIOS or the smallest value that is
> listed in the datasheets).
>
The smallest possible value is 1 second, both in BIOS and datasheet. For
info, the maximum value is 1023 seconds, approx. 17 min.

I think it is dangerous to set the timer to 1s, both in BIOS, obviously
as the boot is still in progress when it expires, and even in the driver,
where you loose a chance to avoid mandatory reboot after only 1 second
of latency, even if the hardware timer is higher.

The value you have set, 15 seconds, is reasonable to me, and should not
be lowered. If the BIOS was well designed, it should also not allow less
than, say 1 minute.

Kind regards,
--
Marc
