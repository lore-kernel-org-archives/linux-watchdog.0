Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:56282 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753912Ab2JBWHT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Oct 2012 18:07:19 -0400
Received: from mail181.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 361F3FF8CBE
	for <linux-watchdog@vger.kernel.org>; Tue,  2 Oct 2012 21:11:34 +0200 (CEST)
Date: Tue, 2 Oct 2012 21:00:20 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v6 3/5] watchdog: at91sam9_wdt: add device tree support
Message-ID: <20121002190020.GD5117@game.jcrosoft.org>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
 <1349094281-28889-4-git-send-email-fabio.porcedda@gmail.com>
 <20121001124546.GE11837@lunn.ch>
 <CAHkwnC_u+bMX7REU5G3u=cm3VGmOUn+AShruw+ERkPJWtZpxUg@mail.gmail.com>
 <CAHkwnC_5wRgf-DGnUfzkrreT_E1v8i=G8U0qo_5t1DY6+L7c+w@mail.gmail.com>
 <20121001130658.GG11837@lunn.ch>
 <CAHkwnC83DcKXZOtLse_xnYe7zOZ5qwGJVimLkBzDwSJ7Y5vL_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC83DcKXZOtLse_xnYe7zOZ5qwGJVimLkBzDwSJ7Y5vL_Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 17:04 Tue 02 Oct     , Fabio Porcedda wrote:
> On Mon, Oct 1, 2012 at 3:06 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Mon, Oct 01, 2012 at 02:54:55PM +0200, Fabio Porcedda wrote:
> >> On Mon, Oct 1, 2012 at 2:48 PM, Fabio Porcedda <fabio.porcedda@gmail.com> wrote:
> >> > On Mon, Oct 1, 2012 at 2:45 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> >> >> On Mon, Oct 01, 2012 at 02:24:39PM +0200, Fabio Porcedda wrote:
> >> >>> Tested on an at91sam9260 board (evk-pro3)
> >> >>>
> >> >>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> >> >>> ---
> >> >>>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
> >> >>>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
> >> >>>  2 files changed, 40 insertions(+)
> >> >>>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >> >>>
> >> >>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >> >>> new file mode 100644
> >> >>> index 0000000..65c1755
> >> >>> --- /dev/null
> >> >>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> >> >>> @@ -0,0 +1,19 @@
> >> >>> +* Atmel Watchdog Timers
> >> >>> +
> >> >>> +** at91sam9-wdt
> >> >>> +
> >> >>> +Required properties:
> >> >>> +- compatible: must be "atmel,at91sam9260-wdt".
> >> >>> +- reg: physical base address of the controller and length of memory mapped
> >> >>> +  region.
> >> >>> +
> >> >>> +Optional properties:
> >> >>> +- timeout: contains the watchdog timeout in seconds.
> >> >>> +
> >> >>> +Example:
> >> >>> +
> >> >>> +     watchdog@fffffd40 {
> >> >>> +             compatible = "atmel,at91sam9260-wdt";
> >> >>> +             reg = <0xfffffd40 0x10>;
> >> >>> +             timeout = <10>;
> >> >>> +     };
> >> >>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> >> >>> index 05e1be8..c9e6bfa 100644
> >> >>> --- a/drivers/watchdog/at91sam9_wdt.c
> >> >>> +++ b/drivers/watchdog/at91sam9_wdt.c
> >> >>> @@ -32,6 +32,7 @@
> >> >>>  #include <linux/timer.h>
> >> >>>  #include <linux/bitops.h>
> >> >>>  #include <linux/uaccess.h>
> >> >>> +#include <linux/of.h>
> >> >>>
> >> >>>  #include "at91sam9_wdt.h"
> >> >>>
> >> >>> @@ -254,6 +255,14 @@ static struct miscdevice at91wdt_miscdev = {
> >> >>>       .fops           = &at91wdt_fops,
> >> >>>  };
> >> >>>
> >> >>> +static inline void __init at91wdt_probe_dt(struct device_node *node)
> >> >>> +{
> >> >>> +     if (!node)
> >> >>> +             return;
> >> >>> +
> >> >>> +     of_property_read_u32(node, "timeout", &heartbeat);
> >> >>> +}
> >> >>> +
> >> >>
> >> >> In patch #1 you add a function to do this, and then you don't make use
> >> >> of it here ?
> >> >>
> >> >> Or am i missing something?
> >> >
> >> > I'm using it on the patch #2 for the orion_wdt driver.
> >> > Do you think it's better to join the #1 and the #2 patch?
> >> >
> >> > Best regards
> >> > --
> >> > Fabio Porcedda
> >>
> >> I'm sorry, only now i understand your question.
> >> The at91sam9_wdt driver don't use the watchdog core framework si i
> >> can't use that function cleanly.
> >
> >> The patch #1 and #2 are for introducing the same property as the
> >> at91sam9_wdt driver.
> >
> > So maybe split this up into two different patchsets. One patchset to
> > add the helper function, and the use of this helper to all watchdog
> > divers that can use it. I think the following drivers should be
> > modified:
> >
> > orion_wdt.c
> > pnx4008_wdt.c
> > s3c2410_wdt.c
> >
> > In a second patchset, convert the AT91SAM9 driver over to the watchdog
> > core framework, and then use the helper function.
> 
> I was thinking to add a more generic helper function like this:
> 
> static inline void watchdog_get_dttimeout(struct device_node *node,
> u32 *timeout)
> {
> 	if (node)
> 		of_property_read_u32(node, "timeout", &wdd->timeout);
> }
> 
> This way i can use this helper function in the at91sam9_wdt driver too.
> What do you think?
timeout_sec and this can be move at of.h level

as this is not watchdog framework secific

Best Regards,
J.
