Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46690 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932132Ab1LEMZO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Dec 2011 07:25:14 -0500
Date: Mon, 5 Dec 2011 12:26:49 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfgang Denk <wd@denx.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Heiko Schocher <hs@denx.de>,
	linux-watchdog@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] RFC, watchdog: add generic wdt driver API
Message-ID: <20111205122649.6fc6aed2@lxorguk.ukuu.org.uk>
In-Reply-To: <20111204170810.8370625EA22@gemini.denx.de>
References: <1322992423-21683-1-git-send-email-hs@denx.de>
	<20111204125928.GB5788@pengutronix.de>
	<20111204170810.8370625EA22@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> that we have a number of customers who consider the existing wdt
> support unsufficient for their use cases.  We've been using it on all
> kinds on PPC systems, and now on ARM as well.
> 
> We will not fight for inclusion of this driver, we just wat to know if
> it's worth investing efforts to get it accepted or if this is a lost
> case.

I think it would be better to start from the needed feature list than the
implementation of an old and wildly different pile of code. Then discuss
adding those features that are relevant to the current framework - which
ought to be relatively easy now each watchdog is a set of methods.

Alan
