Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:47414 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751376Ab2I0RWG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 13:22:06 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 22195FFAAC4
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2012 19:28:08 +0200 (CEST)
Date: Thu, 27 Sep 2012 19:19:34 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] watchdog: at91sam9_wdt: add device tree support
Message-ID: <20120927171934.GS17667@game.jcrosoft.org>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-2-git-send-email-fabio.porcedda@gmail.com>
 <20120927055636.GP17667@game.jcrosoft.org>
 <CAHkwnC_R4DMaRfjQHO=+K1DO62-iH70B2_QsipLD5D4xRznouw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC_R4DMaRfjQHO=+K1DO62-iH70B2_QsipLD5D4xRznouw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 16:59 Thu 27 Sep     , Fabio Porcedda wrote:
> On Thu, Sep 27, 2012 at 7:56 AM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
> >> Tested on an at91sam9260 board (evk-pro3)
> >>
> >> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> >> ---
> >>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
> >>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
> >>  2 files changed, 40 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >> new file mode 100644
> >> index 0000000..5947929
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >> @@ -0,0 +1,19 @@
> >> +* Atmel Watchdog Timers
> >> +
> >> +** at91sam9-wdt
> >> +
> >> +Required properties:
> >> +- compatible: must be "atmel,at91sam9260-wdt".
> >> +- reg: physical base address of the controller and length of memory mapped
> >> +  region.
> >> +
> >> +Optional properties:
> >> +- heartbeat: contains the watchdog heartbeats in seconds.
> > more I read this binding more it's seems wrong
> >
> > Today we do not use yet the watchdog framework which we will so we need to
> > use the same binding as the watchdog framework
> 
> What is the binding of the heartbeat value in the watchdog framework?
> I didn't found any binding of the heartbeat in other dt enabled drivers.
when you read the new watchdog framework cf watchdog_dev.c and watchdog_core.c

you will see that we can set a timeout which have the same meaning as
heartbeat

the key point here is you try to solve the DT the wrong way -> drivers
specific

the binding need to be framwork specific os here we need to do the binding of
the watchdog framework first and then use it in the at91sam9 driver evenif we
do not switch yet. Because in the DT we describe the hw not a drvier
implementation

Best Regards,
J.
