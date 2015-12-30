Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:45049 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754175AbbL3KGU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Dec 2015 05:06:20 -0500
Date: Wed, 30 Dec 2015 11:06:18 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151230100618.GA30927@spo001.leaseweb.nl>
References: <20151228152335.GA18627@roeck-us.net> <20151228152710.GA31482@spo001.leaseweb.nl> <20151228215709.GA30595@roeck-us.net> <20151228225427.GA2018@spo001.leaseweb.nl> <20151229000848.GC2346@roeck-us.net> <20151229072108.GB6292@spo001.leaseweb.nl> <20151229160208.GA30405@roeck-us.net> <20151229200158.GB12170@spo001.leaseweb.nl> <20151229212035.GA21387@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151229212035.GA21387@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On Tue, Dec 29, 2015 at 09:01:58PM +0100, Wim Van Sebroeck wrote:
> > Hi Guenter,
> > 
> > > > > 
> > > > > Any thoughts on the other patch series I sent out, to create the watchdog
> > > > > device in watchdog_dev.c, and to handle reference counting in the watchdog
> > > > > core ? That would be a prerequisite for me to rebase (and rework) the soft
> > > > > timer handling core. I had hoped that the changes to handle reference
> > > > > counting in the core could make it into 4.5.
> > > > 
> > > > Need to review this 6-part patchset still. But probably still possible for 4.5 .
> > > 
> > > That would be great.
> > 
> > It's reviewed and added. I'm actually glad to have a nicer way than the ref/unref
> > code that we had.
> > 
> Great - thanks a lot!

No problem. :-)

Just to clarify to all others: the ref/unref code was added because we needed to
address the issue of (let's call it) "hotswapping" of a watchdog device while it
was still running. That issue (off-course) remains but this code moves the complexity
in the watchdog core code instead of in the drivers. Which basically simplifies live
for everyone.

Kind regards,
Wim.

