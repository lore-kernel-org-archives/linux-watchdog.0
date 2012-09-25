Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:35767 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753808Ab2IYO3h (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Sep 2012 10:29:37 -0400
Received: from mail404.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 4A1B5FFADEC
	for <linux-watchdog@vger.kernel.org>; Tue, 25 Sep 2012 12:57:32 +0200 (CEST)
Date: Tue, 25 Sep 2012 12:49:01 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>,
	devicetree-discuss@lists.ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Victor <linux@maxim.org.za>
Subject: Re: [PATCH v3 1/2] watchdog: at91sam9_wdt: add device tree support
Message-ID: <20120925104901.GI17667@game.jcrosoft.org>
References: <1348558114-31750-1-git-send-email-fabio.porcedda@gmail.com>
 <1348558114-31750-2-git-send-email-fabio.porcedda@gmail.com>
 <20120925081057.GH17667@game.jcrosoft.org>
 <CAHkwnC_=i7mEv99xU6HcFpEfC6eeumcZDWrBq2_qdv=rDf3E1g@mail.gmail.com>
 <506180BE.6000603@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506180BE.6000603@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12:00 Tue 25 Sep     , Nicolas Ferre wrote:
> On 09/25/2012 11:45 AM, Fabio Porcedda :
> > On Tue, Sep 25, 2012 at 10:10 AM, Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> wrote:
> >> On 09:28 Tue 25 Sep     , Fabio Porcedda wrote:
> >>> Tested on an at91sam9260 board (evk-pro3)
> >>>
> >>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> >>> ---
> >>>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
> >>>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
> >>>  2 files changed, 40 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>> new file mode 100644
> >>> index 0000000..724fad1
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >>> @@ -0,0 +1,19 @@
> >>> +* Atmel Watchdog Timers
> >>> +
> >>> +** at91sam9-wdt
> >>> +
> >>> +Required properties:
> >>> +- compatible: must be "atmel,at91sam9-wdt".
> >>> +- reg: physical base address of the controller and length of memory mapped
> >>> +  region.
> >>> +
> >>> +Optional properties:
> >>> +- heartbeat: contains the watchdog heartbeats in seconds.
> >>> +
> >>> +Example:
> >>> +
> >>> +     watchdog@fffffd40 {
> >>> +             compatible = "atmel,at91sam9-wdt";
> >> for the secind time atmel,at91sam9260-watchdog
> > 
> > Ok, i will fix this.
> > 
> >> you need to put the first soc that use it in the compatible
> >>> +             reg = <0xfffffd40 0x10>;
> >>> +             heartbeat = <10>;
> >> need put second in the property name so need to read the doc
> > 
> > I didn't found any example about a property with "second" in the name.
> > Which It's best "heartbeat-seconds", "heartbeat-sec" or "heartbeat-s" ?
> 
> I think that, as it is indicated in the documentation, we should not
> worry too much about that... but "heartbeat" and "heartbeat-s" is ok
> with me.
> 
> Maybe people @ devicetree-discuss have an advice for this?
for i2c-gpio mandatory as example cf discussion with Jean and Russell

Best Regards,
J.
