Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:41534 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab3L3JBY (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Dec 2013 04:01:24 -0500
Date: Mon, 30 Dec 2013 11:01:15 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH] watchdog: dw_wdt: remove build dependencies
Message-ID: <20131230090115.GA3930@tarshish>
References: <230543f28a66b7bf4c4ebb63e4ac2a3000299ce4.1388387430.git.baruch@tkos.co.il>
 <20131230083755.GM10136@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131230083755.GM10136@spo001.leaseweb.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Mon, Dec 30, 2013 at 09:37:55AM +0100, Wim Van Sebroeck wrote:
> If this is ARM hardware, then this should have the dependency "depends on 
> ARM".
> Only if other architectures start using this watchdog device, then the 
> "depends on ARM" can go.

Well, we intend to use this driver on Xtensa platform, does this count?

As a general rule wouldn't it be better to have the widest possible build 
coverage, and encourage arch neutral driver coding?

baruch

> > There is nothing ARM specific in this driver. Also, clk.h now includes 
> > stubs
> > for !CONFIG_HAVE_CLK, so the driver should build anyway.
> > 
> > Cc: Jamie Iles <jamie@jamieiles.com>
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > ---
> >  drivers/watchdog/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 5be6e91..5ffac39 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -214,7 +214,6 @@ config SA1100_WATCHDOG
> >  
> >  config DW_WATCHDOG
> >  	tristate "Synopsys DesignWare watchdog"
> > -	depends on ARM && HAVE_CLK
> >  	help
> >  	  Say Y here if to include support for the Synopsys DesignWare
> >  	  watchdog timer found in many ARM chips.

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
