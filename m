Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:39679 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757920AbcB1QYN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 11:24:13 -0500
Date: Sun, 28 Feb 2016 17:24:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the WinSystems EBC-C384
Message-ID: <20160228162404.GB7577@spo001.leaseweb.nl>
References: <20160125190942.GA6824@sophia> <20160125192810.2487661b@lxorguk.ukuu.org.uk> <20160228140739.GA7577@spo001.leaseweb.nl> <56D30BFE.7060805@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56D30BFE.7060805@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On 02/28/2016 06:07 AM, Wim Van Sebroeck wrote:
> >>>+static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, 
> >>>unsigned t)
> >>>+{
> >>>+	/* resolution is in minutes for timeouts greater than 255 seconds */
> >>>+	if (t > 255) {
> >>>+		/* truncate second resolution to minute resolution */
> >>>+		t /= 60;
> >>>+		wdev->timeout = t * 60;
> >>>+
> >>>+		/* set watchdog timer for minutes */
> >>>+		outb(0x00, CFG_ADDR);
> >>
> >>If ask for 299 seconds surely I should get 300 not 240 ?
> >>(Whether to round off or round up is an interesting question for the
> >>middle range - does it go off early or late - I'd have said late but...)
> >
> >This is my preference:
> >	if (t > 255)
> >		t = (((t - 1) / 60) + 1) * 60;
> >
> 
> In case I am missing something: Why not just use DIV_ROUND_UP() ?

That's indeed also usable (from kernel.h: #define DIV_ROUND_UP(n,d) (((n) + (d) -1) / (d)) which is the same) and indeed preferable.

Kind regards,
Wim.

