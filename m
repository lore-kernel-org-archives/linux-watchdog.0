Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55897 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab3JVQ23 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 12:28:29 -0400
Date: Tue, 22 Oct 2013 09:28:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"dinguyen@altera.com" <dinguyen@altera.com>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCHv5] watchdog: dw: Enable OF support for DW watchdog timer
Message-ID: <20131022162819.GA29349@roeck-us.net>
References: <1382452727-20685-1-git-send-email-dinguyen@altera.com>
 <20131022150201.GB4691@kartoffel>
 <52669BB0.3060601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52669BB0.3060601@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 22, 2013 at 10:37:20AM -0500, Dinh Nguyen wrote:
> Hi Mark,
> 
> On 10/22/13 10:02 AM, Mark Rutland wrote:
> >On Tue, Oct 22, 2013 at 03:38:47PM +0100, dinguyen@altera.com wrote:
> >>From: Dinh Nguyen <dinguyen@altera.com>
> >>
> >>Add device tree support to the DW watchdog timer.
> >>
> >>Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> >>Acked-by: Jamie Iles <jamie@jamieiles.com>
> >>Reviewed-by: Pavel Machek <pavel@denx.de>
> >>Cc: Guenter Roeck <linux@roeck-us.net>
> >>Cc: Jamie Iles <jamie@jamieiles.com>
> >>Cc: Viresh Kumar <viresh.linux@gmail.com>
> >>Cc: Wim Van Sebroeck <wim@iguana.be>
> >>Cc: Pavel Machek <pavel@denx.de>
> >>Cc: Rob Herring <rob.herring@calxeda.com>
> >>Cc: Pawel Moll <pawel.moll@arm.com>
> >>Cc: Mark Rutland <mark.rutland@arm.com>
> >>Cc: Stephen Warren <swarren@wwwdotorg.org>
> >>Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >>Cc: devicetree@vger.kernel.org
> >>Cc: linux-watchdog@vger.kernel.org
> >>---
> >>v5:
> >>- Add documentation for clocks property
> >>v4:
> >>- Add interrupts as an optional property, use "should contain".
> >>v3:
> >>- Clean up documentation
> >>v2:
> >>- Use of_match_ptr() for of_match_table
> >>---
> >>  .../devicetree/bindings/watchdog/dw_wdt.txt        |   20 ++++++++++++++++++++
> >>  drivers/watchdog/dw_wdt.c                          |    8 ++++++++
> >>  2 files changed, 28 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> >>new file mode 100644
> >>index 0000000..3af5c13
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> >>@@ -0,0 +1,20 @@
> >>+Synopsys Designware Watchdog Timer
> >>+
> >>+Required Properties:
> >>+
> >>+- compatible	: Should contain "snps,dw-wdt"
> >>+- reg		: Base address and size of the watchdog timer register.
> >s/register/registers/ ?
> >
> >>+- clocks	: phandle to the clock that drives the watchdog timer.
> >Nit: clocks aren't necessarily described by just a phandle.
> >
> >How about:
> >
> >- clocks: phandle + clock-specifier for the clock that drives the watchdog
> >           timer.
> >
> >Otherwise, given previous comments this looks fine to me.
> >
> >Acked-by: Mark Rutland <mark.rutland@arm.com>
> Fixed with above and added your Ack. So now the question is can take
> this through the
> arm-soc tree or through Wim Van Sebroeck's drivers/watchdog tree?
> 
Guess that depends on Wim as the maintainer. There are other patches
pending for the same driver, so it would be good if they are all merged
through the same tree.

Can you send the final version of your patch so I can add it to my
watchdog-next tree for tracking ?

Thanks,
Guenter
