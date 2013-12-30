Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:41673 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610Ab3L3MQe (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Dec 2013 07:16:34 -0500
Date: Mon, 30 Dec 2013 14:16:30 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] watchdog: dw_wdt: remove build dependencies
Message-ID: <20131230121630.GB4361@tarshish>
References: <230543f28a66b7bf4c4ebb63e4ac2a3000299ce4.1388387430.git.baruch@tkos.co.il>
 <20131230083755.GM10136@spo001.leaseweb.com>
 <20131230090115.GA3930@tarshish>
 <20131230110336.GN10136@spo001.leaseweb.com>
 <20131230113024.GA4361@tarshish>
 <20131230120820.GP10136@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131230120820.GP10136@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Mon, Dec 30, 2013 at 01:08:20PM +0100, Wim Van Sebroeck wrote:
> > > > > If this is ARM hardware, then this should have the dependency 
> > > > > "depends on ARM".
> > > > > Only if other architectures start using this watchdog device, then the 
> > > > > "depends on ARM" can go.
> > > > 
> > > > Well, we intend to use this driver on Xtensa platform, does this count?
> > > 
> > > Xtensa is indeed another Platform, but then I expect the patch to:
> > > 1) make this clear in the Kconfig file
> > 
> > OK. So should I add a dependency on CONFIG_XTENSA, or just add a comment 
> > saying that this driver is cross platform.
> 
> The help text references only designware on ARM platforms, So the text needs
> to be changed.

Ah, I see that now. I'll also update the comment at the beginning of dw_wdt.c 
file likewise.

> > > 2) have a commit-message that also explains this.
> > 
> > Will do.
> > 
> > > 
> > > > As a general rule wouldn't it be better to have the widest possible build 
> > > > coverage, and encourage arch neutral driver coding?
> > > 
> > > We try to have as much arch neutral driver encoding (see the Kconfig & 
> > > Makefile in the drivers/watchdog directory and you will see that we have 
> > > drivers that are not depending on a specific hardware architecture), but we 
> > > should not forget that certain hardware is only available in a certain 
> > > architecture and that it thus does not make any sense to compile kernels 
> > > with drivers that never will be used. So the general rule still is: use 
> > > common sense and look at the broader picture.
> > 
> > This watchdog is part of the DesignWare family of IP blocks. These IP block 
> > are being reused on many platforms. The kernel already has drivers for 
> > DesignWare SPI, I2C, USB, and hopefully also GPIO soon. None of these drivers 
> > depend on any specific architecture. IMO it makes sense to drop arch 
> > dependency entirely in this case.
> 
> Correct.

Thanks for reviewing.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
