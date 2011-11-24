Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:55310 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753517Ab1KXQrY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Nov 2011 11:47:24 -0500
Received: from mail95.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id D5491DCD65C
	for <linux-watchdog@vger.kernel.org>; Thu, 24 Nov 2011 17:53:47 +0100 (CET)
Date: Thu, 24 Nov 2011 17:47:19 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
To: wim@iguana.be
Cc: w.sang@pengutronix.de, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, HaraldWelte@viatech.com,
	broonie@opensource.wolfsonmicro.com
Subject: Re: [PATCH RFC] watchdog: add a new driver for VIA chipsets
Message-ID: <4ece7517.LRNwqXodeJ5rvC27%marc.vertes@sigfox.com>
References: <4eccc3f0.iApQ//mCzaN3UsrB%marc.vertes@sigfox.com>
 <20111123104926.GB4063@pengutronix.de>
 <20111123121329.GM23376@infomag.iguana.be>
 <20111123122018.GA12227@opensource.wolfsonmicro.com>
 <20111123124037.GN23376@infomag.iguana.be>
 <4ecd075d.2YyTTCA13zxwZmwT%marc.vertes@sigfox.com>
 <20111123214614.GQ23376@infomag.iguana.be>
 <4ece231e./LkW+9i4Wmz+9zzn%marc.vertes@sigfox.com>
 <20111124134247.GS23376@infomag.iguana.be>
 <4ece57c9.2i1u841q3U3s+xD7%marc.vertes@sigfox.com>
 <20111124154847.GT23376@infomag.iguana.be>
In-Reply-To: <20111124154847.GT23376@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

> Hope this is clearer now.
>
Yes. All is clear now. Thanks. I was confusing WDT_HEARTBEAT and WDT_TIMEOUT.
I fully agree with the way the timer is implemented.

> I think we should change the default timeout value to 60 seconds instead of 15.
>
Agree on that too.

Thanks for your patience.
Kind regards,
--
Marc
