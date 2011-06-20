Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:41341 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752772Ab1FTDoD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 Jun 2011 23:44:03 -0400
Date: Sun, 19 Jun 2011 20:44:00 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/10 v2] Generic Watchdog Timer Driver
Message-Id: <20110619204400.d732e8aa.rdunlap@xenotime.net>
In-Reply-To: <201106182058.14702.arnd@arndb.de>
References: <20110618171946.GB3441@infomag.iguana.be>
	<201106182058.14702.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, 18 Jun 2011 20:58:14 +0200 Arnd Bergmann wrote:

> On Saturday 18 June 2011 19:19:46 Wim Van Sebroeck wrote:
> > watchdog: WatchDog Timer Driver Core - Part 1
> > 
> > The WatchDog Timer Driver Core is a framework
> > that contains the common code for all watchdog-driver's.
> > It also introduces a watchdog device structure and the
> > operations that go with it.
> > 
> > This is the introduction of this framework. This part
> > supports the minimal watchdog userspace API (or with
> > other words: the functionality to use /dev/watchdog's
> > open, release and write functionality as defined in
> > the simplest watchdog API). Extra functionality will
> > follow in the next set of patches.
> > 
> > Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> 
> Hi Wim,
> 
> Great to see the series posted again, I'm looking forward to seeing
> this included in 3.1.
> 
> I've got a few comments for stuff that can still be improved.
> 
> I noticed that your email subject lines are all the same, you should
> probably see if you mail setup can be fixed to take the one-line
> comment in each patch as the subject, and also to make all mails
> replies to the [PATCH 0/10] email.

It would also be good to include diffstat summaries with each patch.

This info in Documentation/ioctl/ioctl-number.txt does not change, correct?

'W'	00-1F	linux/watchdog.h	conflict!

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
