Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43971 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752566AbbL1Wy2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 17:54:28 -0500
Date: Mon, 28 Dec 2015 23:54:27 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Additional patches in my watchdog-next branch
Message-ID: <20151228225427.GA2018@spo001.leaseweb.nl>
References: <20151228152335.GA18627@roeck-us.net> <20151228152710.GA31482@spo001.leaseweb.nl> <20151228215709.GA30595@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151228215709.GA30595@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On Mon, Dec 28, 2015 at 04:27:11PM +0100, Wim Van Sebroeck wrote:
> > Hi Guneter,
> > 
> > > I have a number of patches pending in my watchdog-next branch which are not
> > > in your watchdog-next repository. Below is a summary, rebased onto your
> > > repository. This does not include the patches I had submitted.
> > > 
> > > Please consider those patches for v4.5.
> > 
> > I'm still working on those. Will be for this evening. I left those because they are all new drivers. I wanted to have all fixes and other patches first.
> > So not finished yet :-) I will also add your dev fixes (V2 patchset containing 5 patches).
> > 
> Thanks!

No problem. I think we now have all patches that should go in for v4.5 .

There is off course still other stuff that I need to look at:
SBSA, pretimeout, bcm63xx, stmp3xxx GETBOOTSTATUS (although I have the impression that this patch is a dead end because you cannot really tell what the reboot reason is with the patch), soft timer's moving into the core, mei watchdog code, ...

Kind regards,
Wim.

