Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:33795 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755370Ab1KXLFr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Nov 2011 06:05:47 -0500
Received: from mail95.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 67761DCD641
	for <linux-watchdog@vger.kernel.org>; Thu, 24 Nov 2011 12:04:01 +0100 (CET)
Date: Thu, 24 Nov 2011 11:57:34 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: wim@iguana.be
Cc: w.sang@pengutronix.de, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, HaraldWelte@viatech.com,
	broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <4ece231e./LkW+9i4Wmz+9zzn%marc.vertes@sigfox.com>
References: <20111122112212.GD2734@pengutronix.de>
 <4ecbd66c.8a87vIwdu0Z+quuZ%marc.vertes@sigfox.com>
 <20111122173227.GK6624@sirena.org.uk>
 <20111122184051.GA30941@pengutronix.de>
 <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com>
 <20111123104926.GB4063@pengutronix.de>
 <20111123121329.GM23376@infomag.iguana.be>
 <20111123122018.GA12227@opensource.wolfsonmicro.com>
 <20111123124037.GN23376@infomag.iguana.be>
 <4ecd075d.2YyTTCA13zxwZmwT%marc.vertes@sigfox.com>
 <20111123214614.GQ23376@infomag.iguana.be>
In-Reply-To: <20111123214614.GQ23376@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

>
> I adapted my example on to your diff and below the result.
> Can you test it? Could you also add some comments about the issues
> with the datasheet as proposed earlier?
>
I have tested your version and it works fine. I saw that you enforced
the NO_WAY_OUT bit and implemented the KEEPALIVEPING and MAGICCLOSE
features properly. Many thanks.

Regarding the timer, the driver can not read the timeout value set in
the BIOS, so there is still a risk of reboot if the BIOS value is lower
than driver one. I assume that other drivers may be in the same case,
and that is required for user compatibility anyway.

Here is the comment block that I propose to insert regarding register
programming issues:

/*
 * Caveat: the only known way to activate the watchdog timer or to set
 * its period is through BIOS configuration, when the hardware supports it.
 * It seems that the watchdog control registers are locked and disabled if
 * the watchdog is not exposed or enabled by BIOS, and that writing them is
 * useless. No public documentation is available regarding this limitation.
 */

Regards,
--
Marc
