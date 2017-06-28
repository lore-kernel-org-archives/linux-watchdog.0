Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38447 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdF1Oyz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Jun 2017 10:54:55 -0400
Date: Wed, 28 Jun 2017 07:54:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: wim@iguana.be, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drivers/watchdog: ASPEED reference dev tree
 properties for config
Message-ID: <20170628145452.GA30968@roeck-us.net>
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
 <20170627211734.60477-3-cbostic@linux.vnet.ibm.com>
 <606a2e11-2d43-5204-0bb6-9c4415ee03df@roeck-us.net>
 <de0dc054-0813-fab1-d7ac-2f1d7ba61fd8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0dc054-0813-fab1-d7ac-2f1d7ba61fd8@linux.vnet.ibm.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 28, 2017 at 09:29:50AM -0500, Christopher Bostic wrote:
> 
> 
> On 6/28/17 6:31 AM, Guenter Roeck wrote:
> >On 06/27/2017 02:17 PM, Christopher Bostic wrote:
> >>Reference the system device tree when configuring the watchdog
> >>engines.  Set external signal mode on timeout if specified.
> >>Set system reset on timeout if specified.
> >>
> >>Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> >>---
> >>v2 - Change of_get_property() to of_property_read_bool()
> >>    - Remove redundant check for NULL struct device_node pointer
> >>    - Optional property names now start with prefix 'aspeed,'
> >>---
> >>  drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/watchdog/aspeed_wdt.c
> >>b/drivers/watchdog/aspeed_wdt.c
> >>index 1c65258..71ce5f5 100644
> >>--- a/drivers/watchdog/aspeed_wdt.c
> >>+++ b/drivers/watchdog/aspeed_wdt.c
> >>@@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device
> >>*pdev)
> >>  {
> >>      struct aspeed_wdt *wdt;
> >>      struct resource *res;
> >>+    struct device_node *np;
> >>      int ret;
> >>        wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> >>@@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device
> >>*pdev)
> >>       * the SOC and not the full chip
> >>       */
> >>      wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
> >>-        WDT_CTRL_1MHZ_CLK |
> >>-        WDT_CTRL_RESET_SYSTEM;
> >>+        WDT_CTRL_1MHZ_CLK;
> >>+
> >>+    np = pdev->dev.of_node;
> >>+    if (of_property_read_bool(np, "aspeed,sys-reset"))
> >>+        wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
> >>+
> >
> >For backward compatibility, this should default to WDT_CTRL_RESET_SYSTEM
> >if no optional property is provided.
> >
> I had the logic inverted for this property in a previous patch.  The
> property was 'no-system-reset' so that when not present the default was to
> set WDT_CTRL_RESET_SYSTEM.   As it is in this patch, the only way to
> indicate that no system reset is to be done is to not specify the property.
> No system reset is desired under circumstances when another wdt engine is to
> be responsible for this.   Given the issue with backward compatibility
> that's not a solution.  Given this, would creating a property
> 'no-system-reset' be acceptable?
> 
Sorry, I fail to see the problem. There are half a dozen properties. What is the
problem with having a default if no property is specified ? Your default is "do
nothing", which does not really make any sense to me. If the user wants the
watchdog to do nothing, the simple means to accomplish that would be to not
instantiate it.

Sure, that means specifying "system-reset" is redundant, but I don't see a
problem with that either. But I do see a problem with loading a watchdog driver
that doesn't do anything.

If there is really some use case where it makes sense to load a watchdog driver
and have it do nothing, please explain and provide a respective devicetree
property. "aspeed,do-nothing" (or whatever similar) doesn't sound good, but
at least makes it obvious that the driver isn't doing anything besides
creating a false sense of "the system is watchdog protected".

Thanks,
Guenter


> Thanks,
> Chris
> 
> >>+    if (of_property_read_bool(np, "aspeed,external-signal"))
> >>+        wdt->ctrl |= WDT_CTRL_WDT_EXT;
> >>+
> >>+    writel(wdt->ctrl, wdt->base + WDT_CTRL);
> >>        if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
> >>          aspeed_wdt_start(&wdt->wdd);
> >>
> >
> 
