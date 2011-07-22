Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:45843 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755166Ab1GVT0M (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jul 2011 15:26:12 -0400
Date: Fri, 22 Jul 2011 21:26:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/11] watchdog: WatchDog Timer Driver Core - Add
	WDIOC_SETOPTIONS ioctl
Message-ID: <20110722192610.GK31767@infomag.iguana.be>
References: <1310392522-9949-1-git-send-email-wim@iguana.be> <1310392522-9949-4-git-send-email-wim@iguana.be> <20110711213259.GE5811@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110711213259.GE5811@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

> > @@ -168,7 +233,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
> >  		goto out;
> >  
> >  	/* start the watchdog */
> > -	err = wdd->ops->start(wdd);
> > +	err = watchdog_start(wdd);
> 
> I think we still might need open- and close-callbacks here. Some drivers turn
> on/off clocks on these operations and we can't simply move them to the
> start/stop callbacks, because the clock might be turned off via DISABLECARD
> which calls stop. And without the clock, a simple register access via
> set_timeout might lock up the machine.

I consider that an extension on the basic framework.
After these patches are accepted we can work on this.

Kind regards,
Wim.

