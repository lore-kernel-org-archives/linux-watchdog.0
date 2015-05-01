Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Timur Tabi <timur@codeaurora.org>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
Date: Fri, 01 May 2015 21:19:18 +0200
Message-ID: <2851853.hEtA2CtVGn@wuerfel>
In-Reply-To: <5543A6E9.1090203@codeaurora.org>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday 01 May 2015 11:16:41 Timur Tabi wrote:
> On 04/30/2015 10:30 PM, Guenter Roeck wrote:
> 
> >> +/* Watchdog Refresh Frame */
> >> +struct arm_sbsa_watchdog_refresh {
> >> +    uint32_t wrr;        /* Watchdog Refresh Register */
> >> +    uint8_t res1[0xFCC - 0x004];
> >> +    struct arm_sbsa_watchdog_ident ident;
> >> +};
> >> +
> >> +/* Watchdog Control Frame */
> >> +struct arm_sbsa_watchdog_control {
> >> +    uint32_t wcs;
> >> +    uint32_t res1;
> >> +    uint32_t wor;
> >> +    uint32_t res2;
> >> +    uint64_t wcv;
> >> +    uint8_t res3[0xFCC - 0x018];
> >> +    struct arm_sbsa_watchdog_ident ident;
> >> +};
> >> +
> >
> > Why not just use defines instead of all those structures ?
> 
> I like structures.  I think hardware register blocks should be defined 
> with structures that provide type checking.

You should use endian-annotations in the structure if you do this,
and mark the members as __le32 or __be32, depending on how the
hardware is defined.

> >> +static struct platform_device *arm_sbsa_wdt_pdev;
> >> +
> >> +static int __init arm_sbsa_wdt_parse_gtdt(struct acpi_subtable_header
> >> *header,
> >> +    const unsigned long end)
> >> +{
> >> +    struct acpi_gtdt_watchdog *wdg = (struct acpi_gtdt_watchdog
> >> *)header;
> >> +    struct platform_device *arm_sbsa_wdt_pdev;
> >
> > That is an interesting one. Makes me wonder if you ever tried to unload
> > this driver.
> > Did you ?
> 
> The driver can only be compiled in-kernel.

That should be fixed, we want normal drivers to be loadable modules.

	Arnd
