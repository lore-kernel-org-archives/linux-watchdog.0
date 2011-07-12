Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41201 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752188Ab1GLJV0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Jul 2011 05:21:26 -0400
Date: Tue, 12 Jul 2011 10:24:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 01/11] watchdog: WatchDog Timer Driver Core - Add basic
 framework
Message-ID: <20110712102410.2ba3834f@lxorguk.ukuu.org.uk>
In-Reply-To: <4E1B8089.90103@metafoo.de>
References: <1310392522-9949-1-git-send-email-wim@iguana.be>
	<4E1B8089.90103@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > +	/* stop the watchdog */
> > +	err = wdd->ops->stop(wdd);
> Does it really make sense to allow stop() to fail? Will this ever happen, and
> if yes do we gain anything by sending a additional ping?

It gives user space more time to react - or would do if the err was
propogated.

