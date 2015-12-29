Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36521 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbL2AIt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 19:08:49 -0500
Date: Mon, 28 Dec 2015 16:08:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151229000848.GC2346@roeck-us.net>
References: <20151228152335.GA18627@roeck-us.net>
 <20151228152710.GA31482@spo001.leaseweb.nl>
 <20151228215709.GA30595@roeck-us.net>
 <20151228225427.GA2018@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151228225427.GA2018@spo001.leaseweb.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 28, 2015 at 11:54:27PM +0100, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
> > On Mon, Dec 28, 2015 at 04:27:11PM +0100, Wim Van Sebroeck wrote:
> > > Hi Guneter,
> > > 
> > > > I have a number of patches pending in my watchdog-next branch which are not
> > > > in your watchdog-next repository. Below is a summary, rebased onto your
> > > > repository. This does not include the patches I had submitted.
> > > > 
> > > > Please consider those patches for v4.5.
> > > 
> > > I'm still working on those. Will be for this evening. I left those because they are all new drivers. I wanted to have all fixes and other patches first.
> > > So not finished yet :-) I will also add your dev fixes (V2 patchset containing 5 patches).
> > > 
> > Thanks!
> 
> No problem. I think we now have all patches that should go in for v4.5 .
> 
> There is off course still other stuff that I need to look at:
> SBSA, pretimeout, bcm63xx, stmp3xxx GETBOOTSTATUS (although I have the impression that this patch is a dead end because you cannot really tell what the reboot reason is with the patch), soft timer's moving into the core, mei watchdog code, ...
Hi Wim,

I'll have to look into those again as well. Most will now conflict
with the new watchdog core code.

Any thoughts on the other patch series I sent out, to create the watchdog
device in watchdog_dev.c, and to handle reference counting in the watchdog
core ? That would be a prerequisite for me to rebase (and rework) the soft
timer handling core. I had hoped that the changes to handle reference
counting in the core could make it into 4.5.

Thanks,
Guenter
