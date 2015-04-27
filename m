Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>, linux-watchdog@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-rpi-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling to the WDT driver.
Date: Mon, 27 Apr 2015 14:48:09 +0200
Message-ID: <2465337.STuvDNQht6@wuerfel>
In-Reply-To: <553E2F1E.5070909@roeck-us.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net> <2979294.WseZH0BUZW@wuerfel> <553E2F1E.5070909@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Monday 27 April 2015 05:44:14 Guenter Roeck wrote:
> On 04/27/2015 02:18 AM, Arnd Bergmann wrote:
> > On Sunday 26 April 2015 08:35:57 Guenter Roeck wrote:
> >> On 04/25/2015 01:11 PM, Arnd Bergmann wrote:
> >>> On Friday 24 April 2015 12:08:54 Eric Anholt wrote:
> >>>> +/*
> >>>> + * We can't really power off, but if we do the normal reset scheme, and
> >>>> + * indicate to bootcode.bin not to reboot, then most of the chip will be
> >>>> + * powered off.
> >>>> + */
> >>>> +static void bcm2835_power_off(void)
> >>>> +{
> >>>> +       struct device_node *np =
> >>>> +               of_find_compatible_node(NULL, NULL, "brcm,bcm2835-pm-wdt");
> >>>> +       struct platform_device *pdev = of_find_device_by_node(np);
> >>>> +       struct bcm2835_wdt *wdt = platform_get_drvdata(pdev);
> >>>> +       u32 val;
> >>>> +
> >>>
> >>> Instead of doing the lookup again here, I'd suggest using a static variable
> >>> in the driver to store the device pointer for the device used on power_off.
> >>>
> >>> Make sure that the device remove callback assigns it back to NULL though
> >>> and that the function checks for NULL pointer.
> >>>
> >>
> >> Why would that be needed ?
> >
> > devices can be unbound from drivers through sysfs, or using dynamic DT
> > updates. If one does that, the watchdog driver will correctly destroy
> > all information it has about the device, so if the power_off function
> > still uses that pointer, it will crash.
> >
> Without calling its remove function ? That sounds odd. Lots of drivers
> would break if that was really the case.

I'm not sure what you mean now. The remove function gets called to
do the final cleanup, and afterwards the device is deleted, so the
remove function should make sure that no global variables point to
the device any more.

This is not a concern for most other drivers, because they do not
keep global pointers to device structures.

	Arnd
