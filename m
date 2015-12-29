Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:44024 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752881AbbL2HRg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Dec 2015 02:17:36 -0500
Date: Tue, 29 Dec 2015 08:17:32 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151229071732.GA6292@spo001.leaseweb.nl>
References: <20151228152335.GA18627@roeck-us.net> <20151228152710.GA31482@spo001.leaseweb.nl> <20151228215709.GA30595@roeck-us.net> <20151228225427.GA2018@spo001.leaseweb.nl> <5681C2FE.7070100@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5681C2FE.7070100@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Vladimir,

> Hi Wim,
> 
> On 29.12.2015 00:54, Wim Van Sebroeck wrote:
> > Hi Guenter,
> > 
> >> On Mon, Dec 28, 2015 at 04:27:11PM +0100, Wim Van Sebroeck wrote:
> >>> Hi Guneter,
> >>>
> >>>> I have a number of patches pending in my watchdog-next branch which are not
> >>>> in your watchdog-next repository. Below is a summary, rebased onto your
> >>>> repository. This does not include the patches I had submitted.
> >>>>
> >>>> Please consider those patches for v4.5.
> >>>
> >>> I'm still working on those. Will be for this evening. I left those because they are all new drivers. I wanted to have all fixes and other patches first.
> >>> So not finished yet :-) I will also add your dev fixes (V2 patchset containing 5 patches).
> >>>
> >> Thanks!
> > 
> > No problem. I think we now have all patches that should go in for v4.5 .
> > 
> > There is off course still other stuff that I need to look at:
> > SBSA, pretimeout, bcm63xx, stmp3xxx GETBOOTSTATUS (although I have the impression that this patch is a dead end because you cannot really tell what the reboot reason is with the patch), soft timer's moving into the core, mei watchdog code, ...
> > 
> 
> please let me know, if you want to see the proposed pretimeout change rebased earlier, at the moment it may have merge conflicts with your watchdog/master branch. In any case I would appreciate to get your review comments :)

Pretimeout will not go in during the next merge window. It's for 4.6 at the earliest.
But I will come back on this.

SBSA: What should be done is to create a correct driver without pretimeout and with just the normal watchdog (=reboot if we aren't kicked fast enough) behaviour and get that in.

Kind regards,
Wim.

