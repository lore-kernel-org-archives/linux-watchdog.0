Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41345 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab2AYBC1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Jan 2012 20:02:27 -0500
Date: Tue, 24 Jan 2012 17:02:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH RESEND 0/3] watchdog: new driver for STMP3xxx/MX23/MX28
Message-Id: <20120124170226.fa6386a1.akpm@linux-foundation.org>
In-Reply-To: <1327347185-620-1-git-send-email-w.sang@pengutronix.de>
References: <1327347185-620-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 23 Jan 2012 20:33:02 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> The first patch adds an accessor routine to the RTC-driver which can hopefully
> go via the watchdog-tree as well (asking for Andrew's ack here).  The second
> patch adds the new driver, the third removes the old one.

I had a few little issues.

> After missing the last merge window, I really hope we can get it into 3.4. The
> old driver was broken (= not compilable) anyhow, so there cannot be any
> regression.  Tested on a MX28EVK.

Well, people out could still be using the old driver after applying
local fixups.

How compatible is the new driver with the old one?  Same module
parameters?  Will it just transparently work?  IOW, if people out there
are using the old driver now, how much will this sudden removal impact
them?

