Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45058 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbEARt6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 13:49:58 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoF4X-000LHK-Rt
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 17:49:58 +0000
Date: Fri, 1 May 2015 10:49:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
Message-ID: <20150501174953.GB7712@roeck-us.net>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
 <5542F33D.2020206@roeck-us.net>
 <5543A6E9.1090203@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5543A6E9.1090203@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 01, 2015 at 11:16:41AM -0500, Timur Tabi wrote:
> On 04/30/2015 10:30 PM, Guenter Roeck wrote:
> 
> >>+/* Watchdog Refresh Frame */
> >>+struct arm_sbsa_watchdog_refresh {
> >>+    uint32_t wrr;        /* Watchdog Refresh Register */
> >>+    uint8_t res1[0xFCC - 0x004];
> >>+    struct arm_sbsa_watchdog_ident ident;
> >>+};
> >>+
> >>+/* Watchdog Control Frame */
> >>+struct arm_sbsa_watchdog_control {
> >>+    uint32_t wcs;
> >>+    uint32_t res1;
> >>+    uint32_t wor;
> >>+    uint32_t res2;
> >>+    uint64_t wcv;
> >>+    uint8_t res3[0xFCC - 0x018];
> >>+    struct arm_sbsa_watchdog_ident ident;
> >>+};
> >>+
> >
> >Why not just use defines instead of all those structures ?
> 
> I like structures.  I think hardware register blocks should be defined with
> structures that provide type checking.
> 
Matter of personal opinion, I guess. Also prone to introducing errors,
and potentially resulting in more complex code. Just my personal opinion,
though, so I'll let that pass.

[ ... ]

> >>+static struct platform_device *arm_sbsa_wdt_pdev;
> >>+
> >>+static int __init arm_sbsa_wdt_parse_gtdt(struct acpi_subtable_header
> >>*header,
> >>+    const unsigned long end)
> >>+{
> >>+    struct acpi_gtdt_watchdog *wdg = (struct acpi_gtdt_watchdog
> >>*)header;
> >>+    struct platform_device *arm_sbsa_wdt_pdev;
> >
> >That is an interesting one. Makes me wonder if you ever tried to unload
> >this driver.
> >Did you ?
> 
> The driver can only be compiled in-kernel.
> 
And that makes it valid to have both a global and a local variable named
arm_sbsa_wdt_pdev ? Please explain the rationale.

> >>+    struct resource res[3] = {};
> >>+    int trigger, polarity;
> >>+    int ret;
> >>+
> >>+    if (!header ||
> >
> >That error check is kind of weird. Sure, 0 is an invalid address, but so
> >are many other
> >addresses. Is there any reason to believe that acpi_get_table_with_size
> >would return
> >a NULL pointer (but not some other invalid address) ?
> 
> If the table is uninitialized, then all the values are probably zero.  I was
> trying to come up with something.  These are the only tests I could come up
> with I know work.
> 
How would it be uninitialized ? A quick glance to other code seems to suggest
that this isn't needed elsewhere. Why is it needed here ?

> >>+        (unsigned long)header + sizeof(*wdg) > end ||
> >>+        header->length < sizeof(*wdg)) {
> >
> >So I really wonder how this is supposed to work.
> >
> >struct acpi_subtable_header {
> >         u8 type;
> >         u8 length;
> >};
> >
> >struct acpi_gtdt_watchdog {
> >         struct acpi_gtdt_header header;
> >...
> >
> >struct acpi_gtdt_header {
> >         u8 type;
> >         u16 length;
> >};
> >
> >Either the length is 16 bit or 8 bit. But both ???
> >Or is it just luck and the value happens to be stored as little endian
> >value and the length is less than 256 bytes ?
> >
> >I understand this seems to be copied from BAD_MADT_ENTRY or similar code,
> >but it is still odd.
> 
> It's the best I could come up with.  Sure it seems weird, but it works, and
> since it's copied from BAD_MADT_ENTRY, I figured it was acceptable.
> 
That doesn't explain if length is supposed to be 16 or 8 bit, if the length
is supposed to be stored as big or little endian value, and what would happen
if it was stored as big endian value on some system and is 16 bit wide.

If the length is in fact 16 bit, you could just check its value directly,
instead of doing all the typecasting. And if it is 16 bit and has a fixed
endianness (not host byte order), you should convert it to host byte order
before validating it. Alternatively, something appears to be wrong with
acpi_gtdt_header and/or with acpi_gtdt_watchdog.

> >
> >>+        pr_err("malformed subtable entry\n");
> >>+        return -EINVAL;
> >>+    }
> >>+
> >>+    if (!wdg->control_frame_address || !wdg->refresh_frame_address) {
> >>+        pr_err("invalid control or refresh address\n");
> >>+        return -ENXIO;
> >>+    }
> >>+
> >>+    arm_sbsa_wdt_pdev = platform_device_alloc(DRV_NAME, 0);
> >>+    if (!arm_sbsa_wdt_pdev)
> >>+        return -ENOMEM;
> >>+
> >>+    res[0].name = "control";
> >>+    res[0].flags = IORESOURCE_MEM;
> >>+    res[0].start = wdg->control_frame_address;
> >>+    res[0].end = res[0].start + sizeof(struct
> >>arm_sbsa_watchdog_control);
> >
> >Really ? Or should there be a -1 somewhere ?
> 
> You're right.
> 
> >>+
> >>+    res[1].name = "refresh";
> >>+    res[1].flags = IORESOURCE_MEM;
> >>+    res[1].start = wdg->refresh_frame_address;
> >>+    res[1].end = res[1].start + sizeof(struct
> >>arm_sbsa_watchdog_refresh);
> >
> >Same here.
> 
> Ok.
> 
> >>+    trigger = (wdg->timer_flags & ACPI_GTDT_WATCHDOG_IRQ_MODE) ?
> >>+        ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
> >>+
> >>+    polarity = (wdg->timer_flags & ACPI_GTDT_WATCHDOG_IRQ_POLARITY) ?
> >>+        ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> >>+
> >>+    /* This should be the WS0 interrupt */
> >>+    ret = acpi_register_gsi(&arm_sbsa_wdt_pdev->dev,
> >>wdg->timer_interrupt,
> >>+        trigger, polarity);
> >>+    if (ret <= 0) {
> >
> >0 is not an error (the interrupt number could be 0).
> 
> Ok.
> 
> >>+static int __init arm_sbsa_wdt_init(void)
> >>+{
> >>+    struct acpi_table_header *table;
> >>+    acpi_size tbl_size;
> >>+    acpi_status status;
> >>+    int count;
> >>+
> >>+    pr_info("ARM Server Base System Architecture watchdog driver\n");
> >>+
> >This seems to assume that the watchdog is always supported, which is
> >quite unlikely.
> 
> I'll make it a pr_debug.
> 
> >>+    status = acpi_get_table_with_size(ACPI_SIG_GTDT, 0, &table,
> >>&tbl_size);
> >>+    if (ACPI_FAILURE(status)) {
> >>+        pr_err("cannot locate GTDT table\n");
> >>+        return -EINVAL;
> >>+    }
> >
> >I am kind of completely unhappy with the noisiness here and below.
> >Is this how acpi detection is supposed to happen ?
> >And is it really an _error_ if the device isn't there,
> >or does it just mean that the device isn't there ?
> 
> I think the GTDT is required.  Most likely, the kernel will fail to boot
> long before we get to this point if the GTDT is missing or corrupt.

ACPI, the center of the universe ;-). Is ACPI support on arm64 now mandatory ?
I thought it also supports devicetree ?

Assuming that there can be an image which boots both with ACPI and devicetree
based configurations, I can understand that this driver would only load on ACPI
based arm64 systems, but that doesn't mean it should dump an error message
if the system does not use ACPI (or if its ACPI tables do not include an entry
for the watchdog, for that matter).

> 
> However, I'm not an ACPI expert by any means.  I'm hoping that someone who
> knows a lot more than I do will review it.  This driver was reviewed and
> approved by some of our internal ACPI experts, so I presume that it is
> correct.
> 
> >>+    count = acpi_parse_entries(ACPI_SIG_GTDT, sizeof(struct
> >>acpi_table_gtdt),
> >>+        arm_sbsa_wdt_parse_gtdt, table, ACPI_GTDT_TYPE_WATCHDOG, 0);
> >>+    if (count <= 0) {
> >>+        pr_err("no watchdog subtables found\n");
> >>+        return -EINVAL;
> >>+    }
> >>+
> >>+    return platform_driver_probe(&arm_sbsa_wdt_driver,
> >>arm_sbsa_wdt_probe);
> >
> >Another oddity. Is this how acpi device instantiation is supposed to
> >happen ?
> >
> >I thought there are functions to register acpi drivers, such as
> >acpi_bus_register_driver().
> >Why doesn't this work here ?
> 
> I can't use acpi_bus_register_driver() because there are no ACPI IDs to
> probe on.  Watchdog information is stored as a subtable of the GTDT table,
> and there's nothing in the ACPI layer that automatically creates platforms
> from subtables.  I have to create the platform from scratch, which is why
> the code looks so messy.
> 
Weird. I'll really want to know from some ACPI experts if this is really
how ACPI drivers are supposed to be instantiated. Can you give me some
other examples where this is done ?

Thanks,
Guenter
