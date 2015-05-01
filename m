Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Timur Tabi <timur@codeaurora.org>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Vipul Gandhi <vgandhi@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
Date: Fri, 01 May 2015 21:24:01 +0200
Message-ID: <28676294.hhciQCjd9F@wuerfel>
In-Reply-To: <5543C921.9050800@codeaurora.org>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <20150501174953.GB7712@roeck-us.net> <5543C921.9050800@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday 01 May 2015 13:42:41 Timur Tabi wrote:
> 
> >> I think the GTDT is required.  Most likely, the kernel will fail to boot
> >> long before we get to this point if the GTDT is missing or corrupt.
> >
> > ACPI, the center of the universe ;-). Is ACPI support on arm64 now mandatory ?
> > I thought it also supports devicetree ?
> 
> Yes, ACPI for ARM64 *servers* is mandatory.  ARM64 servers are not 
> supposed to use device tree.
> 
> And since this is a driver for SBSA systems (SBSA = Server Base System 
> Architecture), this driver will only ever be used on an ARM64 server 
> system with ACPI and no device tree at all.

No, that is not a reasonable assumption to make. All the ARM64 server
systems we have today are using DT only and we will of course keep
supporting systems like that. 

Nothing prevents you from using the same register set on a platform
that is not SBSA compliant, or using DT on a machine that is SBSA
compliant, and we will definitely see that happen for chips that are
shared between products, e.g. a SBSA+SCPI system in a server targeted
market and the same hardware with devicetree for e.g. networking
equipment.

This means we need a DT binding for the driver, and the ACPI portion
that creates the platform device should be split out from the main
driver.

	Arnd
