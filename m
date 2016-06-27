Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40098 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcF0UOn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jun 2016 16:14:43 -0400
Date: Mon, 27 Jun 2016 13:14:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Gong <b38343@freescale.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/2] watchdog: add pretimeout support to the core
Message-ID: <20160627201435.GA5891@roeck-us.net>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1466902865-14354-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <576F3E2E.7060606@roeck-us.net>
 <20160627093707.GD1602@katana>
 <57712AF4.80104@roeck-us.net>
 <20160627153356.GA3505@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160627153356.GA3505@katana>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jun 27, 2016 at 05:33:56PM +0200, Wolfram Sang wrote:
> 
> > >I liked the is_visible() change right away, so these patches are fine.
> > >Guenter, what is your take on upstreaming the softdog pretimeout
> > >support? I'd think it would be good to have for testing purposes. It
> > >would also help me to upstream the busybox patch for the watchdog
> > >applet.
> > >
> > 
> > Sure, but the current patch series doesn't include watchdog_notify_pretimeout(),
> > or am I missing something ?
> 
> It would be hardcoded to "panic" for now and later converted.
> 

sgtm

Guenter
