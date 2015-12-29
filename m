Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53305 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbbL2VUg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Dec 2015 16:20:36 -0500
Date: Tue, 29 Dec 2015 13:20:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151229212035.GA21387@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
 <20151228152710.GA31482@spo001.leaseweb.nl>
 <20151228215709.GA30595@roeck-us.net>
 <20151228225427.GA2018@spo001.leaseweb.nl>
 <20151229000848.GC2346@roeck-us.net>
 <20151229072108.GB6292@spo001.leaseweb.nl>
 <20151229160208.GA30405@roeck-us.net>
 <20151229200158.GB12170@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151229200158.GB12170@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Tue, Dec 29, 2015 at 09:01:58PM +0100, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
> > > > 
> > > > Any thoughts on the other patch series I sent out, to create the watchdog
> > > > device in watchdog_dev.c, and to handle reference counting in the watchdog
> > > > core ? That would be a prerequisite for me to rebase (and rework) the soft
> > > > timer handling core. I had hoped that the changes to handle reference
> > > > counting in the core could make it into 4.5.
> > > 
> > > Need to review this 6-part patchset still. But probably still possible for 4.5 .
> > 
> > That would be great.
> 
> It's reviewed and added. I'm actually glad to have a nicer way than the ref/unref
> code that we had.
> 
Great - thanks a lot!

Guenter
