Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53555 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbdF1PGu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Jun 2017 11:06:50 -0400
Date: Wed, 28 Jun 2017 08:06:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/watchdog: Add optional ASPEED device tree
 properties
Message-ID: <20170628150646.GD30968@roeck-us.net>
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
 <20170627211734.60477-2-cbostic@linux.vnet.ibm.com>
 <20170627213216.GA4132@roeck-us.net>
 <6f2a77e0-e64c-70b7-812a-6a5e8a0b5e6f@linux.vnet.ibm.com>
 <20170627220740.GA19461@roeck-us.net>
 <ec4a255f-6052-0ad7-32e7-7a86b57e5283@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4a255f-6052-0ad7-32e7-7a86b57e5283@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 28, 2017 at 09:55:41AM -0500, Christopher Bostic wrote:
> 
> 
> On 6/27/17 5:07 PM, Guenter Roeck wrote:
> >On Tue, Jun 27, 2017 at 04:42:24PM -0500, Christopher Bostic wrote:
> >>
> >>On 6/27/17 4:32 PM, Guenter Roeck wrote:
> >>>On Tue, Jun 27, 2017 at 04:17:33PM -0500, Christopher Bostic wrote:
> >>>>Describe device tree optional properties:
> >>>>
> >>>>   * aspeed,arm-reet - ARM CPU reset on signal
> >>>>   * aspeed,soc-reset - SOC reset on signal
> >>>>   * aspeed,sys-reset - System reset on signal
> >>>>           Disabling system reset may be required in situations where
> >>>>           one of the other watchdog engines in the system is responsible
> >>>>           for this.
> >>>>   * aspeed,interrupt - Interrupt CPU on signal
> >>>>   * aspeed,external-signal - Generate external signal (WDT1 and WDT2 only)
> >>>>   * aspeed,alt-boot - Boot from alternate block on signal
> >>>>
> >>>>Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> >>>>---
> >>>>v2 - Add 'aspeed,' prefix to all optional properties
> >>>>    - Add arm-reset, soc-reset, interrupt, alt-boot properties
> >>>>---
> >>>>  .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 25 ++++++++++++++++++++++
> >>>>  1 file changed, 25 insertions(+)
> >>>>
> >>>>diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >>>>index c5e74d7..555b8b4 100644
> >>>>--- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >>>>+++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> >>>>@@ -8,9 +8,34 @@ Required properties:
> >>>>   - reg: physical base address of the controller and length of memory mapped
> >>>>     region
> >>>>+Optional properties:
> >>>>+   Signal behavior - Whenever a timeout occurs, the watchdog can be programmed
> >>>>+   to generate 6 types of signals:
> >>>>+
> >>>>+ - aspeed,arm-reset:  If property is present then reset ARM CPU only.
> >>>>+
> >>>>+ - aspeed,soc-reset:  If property is present then reset SOC.
> >>>>+
> >>>>+ - aspeed,sys-reset:  If property is present then reset the entire chip.
> >>>>+                      In cases where one of the other watchdog engines
> >>>>+                      in the system is responsible for system reset it
> >>>>+                      may be required to not specify this property.
> >>>>+
> >>>>+ - aspeed,interrupt:  If property is present then interrupt CPU.
> >>>>+
> >>>>+ - aspeed,external-signal: If property is present then signal is sent to
> >>>>+                           external reset counter (only WDT1 and WDT2).
> >>>>+ - aspeed,alt-boot:    If property is present then boot from alternate block.
> >>>>+
> >>>>  Example:
> >>>>  	wdt1: watchdog@1e785000 {
> >>>>  		compatible = "aspeed,ast2400-wdt";
> >>>>  		reg = <0x1e785000 0x1c>;
> >>>>+		aspeed,arm-reset;
> >>>>+		aspeed,soc-reset;
> >>>>+		aspeed,sys-reset;
> >>>>+		aspeed,interrupt;
> >>>>+		aspeed,external-signal;
> >>>>+		aspeed,alt-boot;
> >>>Is that a bit mask or a value ? I would have thought that,
> >>>for example, a complete system reset would include the SoC reset,
> >>>and a SoC reset would include the ARM reset. Generating an
> >>>interrupt while at the same time resetting the system (or
> >>>part of it) doesn't seem to make much sense either.
> >>No these aren't bitmasks.   The example was intended to indicate what could
> >>be used.
> >>In practice only a subset of each of these properties would make any sense.
> >>How
> >>would you suggest the example be formatted to convey that? Multiple examples
> >>I suppose.
> >>
> >I would just pick one (which is perfectly fine). After all, it is an example.
> >
> >Reminds me: Is there a default (eg the chip's default configuration) ?
> >In other words, what is expected to happen if none of the properties
> >is specified ?
> Default was to enable SOC reset (parameter aspeed,soc-reset)  and system
> reset (aspeed,sys-reset).  Based on your comments in patch v2 2/2 it would
> be necessary for backwards compatibility to preserve that default behavior.
> So it seems the optional parameters should be inverted for these:
> no-soc-reset, no-sys-reset.
> 
I don't really understand what you are trying to say, sorry. no-sys-reset would
enable everything but sys-reset, and one would have to specify a lot of no-xxx
to select the one that is needed ? And not specifying anything would select
everything ? That sounds just weird.

I still don't see the problem with having a default.

Guenter
