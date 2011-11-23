Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:36643 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753261Ab1KWLnp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Nov 2011 06:43:45 -0500
Received: from mail621.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 477A5DCC2E9
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Nov 2011 12:50:06 +0100 (CET)
Date: Wed, 23 Nov 2011 12:43:41 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: w.sang@pengutronix.de
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, HaraldWelte@viatech.com,
	broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <4eccdc6d.wleutgRbV7hZJdby%marc.vertes@sigfox.com>
References: <4ecb84b9.48rmEWqC3D6x18iE%marc.vertes@sigfox.com>
 <20111122112212.GD2734@pengutronix.de>
 <4ecbd66c.8a87vIwdu0Z+quuZ%marc.vertes@sigfox.com>
 <20111122173227.GK6624@sirena.org.uk>
 <20111122184051.GA30941@pengutronix.de>
 <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com>
 <20111123104926.GB4063@pengutronix.de>
In-Reply-To: <20111123104926.GB4063@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Wolfram Sang <w.sang@pengutronix.de> wrote:

> (BTW I removed a few duplicates from the CC list)
Yes, thanks.
>
> @Wim: Would you accept drivers which can only ping a watchdog but
> neither start/stop it?
>
> @Marc: If he does, would you be interested in updating the watchdog-core
> so that no start()/stop() will also be accepted if there is a ping()?
>
Yes, it looks reasonable to me. Watchdogs settable by BIOS only and not
cancelable (as VIA) are simple hard watchdogs for which ping() is the
only necessary operation. I'm preparing a new update.

Regards,
--
Marc
