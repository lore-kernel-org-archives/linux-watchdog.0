Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58160 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab2JBPE0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Oct 2012 11:04:26 -0400
Received: by obbuo13 with SMTP id uo13so6212098obb.19
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Oct 2012 08:04:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121001130658.GG11837@lunn.ch>
References: <1349094281-28889-1-git-send-email-fabio.porcedda@gmail.com>
 <1349094281-28889-4-git-send-email-fabio.porcedda@gmail.com>
 <20121001124546.GE11837@lunn.ch> <CAHkwnC_u+bMX7REU5G3u=cm3VGmOUn+AShruw+ERkPJWtZpxUg@mail.gmail.com>
 <CAHkwnC_5wRgf-DGnUfzkrreT_E1v8i=G8U0qo_5t1DY6+L7c+w@mail.gmail.com> <20121001130658.GG11837@lunn.ch>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Tue, 2 Oct 2012 17:04:05 +0200
Message-ID: <CAHkwnC83DcKXZOtLse_xnYe7zOZ5qwGJVimLkBzDwSJ7Y5vL_Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] watchdog: at91sam9_wdt: add device tree support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 1, 2012 at 3:06 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Oct 01, 2012 at 02:54:55PM +0200, Fabio Porcedda wrote:
>> On Mon, Oct 1, 2012 at 2:48 PM, Fabio Porcedda <fabio.porcedda@gmail.com> wrote:
>> > On Mon, Oct 1, 2012 at 2:45 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> >> On Mon, Oct 01, 2012 at 02:24:39PM +0200, Fabio Porcedda wrote:
>> >>> Tested on an at91sam9260 board (evk-pro3)
>> >>>
>> >>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> >>> ---
>> >>>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>> >>>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>> >>>  2 files changed, 40 insertions(+)
>> >>>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> >>>
>> >>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> >>> new file mode 100644
>> >>> index 0000000..65c1755
>> >>> --- /dev/null
>> >>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> >>> @@ -0,0 +1,19 @@
>> >>> +* Atmel Watchdog Timers
>> >>> +
>> >>> +** at91sam9-wdt
>> >>> +
>> >>> +Required properties:
>> >>> +- compatible: must be "atmel,at91sam9260-wdt".
>> >>> +- reg: physical base address of the controller and length of memory mapped
>> >>> +  region.
>> >>> +
>> >>> +Optional properties:
>> >>> +- timeout: contains the watchdog timeout in seconds.
>> >>> +
>> >>> +Example:
>> >>> +
>> >>> +     watchdog@fffffd40 {
>> >>> +             compatible = "atmel,at91sam9260-wdt";
>> >>> +             reg = <0xfffffd40 0x10>;
>> >>> +             timeout = <10>;
>> >>> +     };
>> >>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
>> >>> index 05e1be8..c9e6bfa 100644
>> >>> --- a/drivers/watchdog/at91sam9_wdt.c
>> >>> +++ b/drivers/watchdog/at91sam9_wdt.c
>> >>> @@ -32,6 +32,7 @@
>> >>>  #include <linux/timer.h>
>> >>>  #include <linux/bitops.h>
>> >>>  #include <linux/uaccess.h>
>> >>> +#include <linux/of.h>
>> >>>
>> >>>  #include "at91sam9_wdt.h"
>> >>>
>> >>> @@ -254,6 +255,14 @@ static struct miscdevice at91wdt_miscdev = {
>> >>>       .fops           = &at91wdt_fops,
>> >>>  };
>> >>>
>> >>> +static inline void __init at91wdt_probe_dt(struct device_node *node)
>> >>> +{
>> >>> +     if (!node)
>> >>> +             return;
>> >>> +
>> >>> +     of_property_read_u32(node, "timeout", &heartbeat);
>> >>> +}
>> >>> +
>> >>
>> >> In patch #1 you add a function to do this, and then you don't make use
>> >> of it here ?
>> >>
>> >> Or am i missing something?
>> >
>> > I'm using it on the patch #2 for the orion_wdt driver.
>> > Do you think it's better to join the #1 and the #2 patch?
>> >
>> > Best regards
>> > --
>> > Fabio Porcedda
>>
>> I'm sorry, only now i understand your question.
>> The at91sam9_wdt driver don't use the watchdog core framework si i
>> can't use that function cleanly.
>
>> The patch #1 and #2 are for introducing the same property as the
>> at91sam9_wdt driver.
>
> So maybe split this up into two different patchsets. One patchset to
> add the helper function, and the use of this helper to all watchdog
> divers that can use it. I think the following drivers should be
> modified:
>
> orion_wdt.c
> pnx4008_wdt.c
> s3c2410_wdt.c
>
> In a second patchset, convert the AT91SAM9 driver over to the watchdog
> core framework, and then use the helper function.

I was thinking to add a more generic helper function like this:

static inline void watchdog_get_dttimeout(struct device_node *node,
u32 *timeout)
{
	if (node)
		of_property_read_u32(node, "timeout", &wdd->timeout);
}

This way i can use this helper function in the at91sam9_wdt driver too.
What do you think?

Best regards
-- 
Fabio Porcedda
