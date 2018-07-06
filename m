Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:13371
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933947AbeGFRzF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Jul 2018 13:55:05 -0400
From: David Frey <DFrey@sierrawireless.com>
To: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Should gpio_wdt be enhanced?
Date: Fri, 6 Jul 2018 17:55:01 +0000
Message-ID: <CY1PR0201MB143533F5A15F861611445319C7470@CY1PR0201MB1435.namprd02.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I am working on a board that contains a Texas Instruments TPS3851-Q1 which =
is described by the datasheet (http://www.ti.com/lit/ds/symlink/tps3851-q1.=
pdf) as "High-Accuracy Voltage Supervisor with Integrated Watchdog Timer". =
 The operation of the watchdog feature of the chip is quite simple.

1. Use a GPIO of your system to write the SET1 pin of the TPS3851-Q1 high t=
o enable the watchdog
2. Use a GPIO of your system to produce a falling edge to kick the watchdog=
.  The rate at which this must occur depends upon hardware pin strapping op=
tions and whether the chosen part uses "standard" or "extended" timing.
3. If you don't kick the watchdog, the WDO output of the TPS3851-Q1 will go=
 low.  In the case of the board that I am working on, this is tied to the b=
oard reset
4. You may write 0 to SET1 to disable the watchdog

I discovered gpio_wdt.c in the Linux kernel and it seems like this driver i=
s mostly compatible with this device.  What seems to be missing is the abil=
ity to control the SET1 pin to enable/disable the watchdog hardware.  Would=
 it be sensible to define an optional devicetree property "enable-gpio" whi=
ch if defined, is written high in gpio_wdt_probe() and low in gpio_wdt_remo=
ve().

I also don't think I understand the "always_running" option of the driver. =
 If this option is false, then a call to gpio_wdt_stop() produces a call to=
 gpio_wdt_disable().  The gpio_wdt_disable() function sets the watchdog sig=
nal GPIO to 1 and then reconfigures the GPIO to be an input if the hw_algo =
setting is HW_ALGO_TOGGLE.  I don't see how this will disable the watchdog =
since presumably TOGGLE based hardware is expecting the signal to toggle (a=
nd now it won't) and LEVEL based hardware is expecting either a rising or f=
alling edge and no more edges will be produced.  Does anyone have any insig=
ht into how the driver is supposed to work when "always_running" is false?

Thanks,
David
