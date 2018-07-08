Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39079 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeGHSVy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 8 Jul 2018 14:21:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so12037340pfm.6
        for <linux-watchdog@vger.kernel.org>; Sun, 08 Jul 2018 11:21:54 -0700 (PDT)
Subject: Re: Should gpio_wdt be enhanced?
To: David Frey <DFrey@sierrawireless.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <CY1PR0201MB143533F5A15F861611445319C7470@CY1PR0201MB1435.namprd02.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8759ed7b-db27-7644-9b42-9d32701bbf19@roeck-us.net>
Date: Sun, 8 Jul 2018 11:21:51 -0700
MIME-Version: 1.0
In-Reply-To: <CY1PR0201MB143533F5A15F861611445319C7470@CY1PR0201MB1435.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/06/2018 10:55 AM, David Frey wrote:
> Hi,
> 
> I am working on a board that contains a Texas Instruments TPS3851-Q1 which is described by the datasheet (http://www.ti.com/lit/ds/symlink/tps3851-q1.pdf) as "High-Accuracy Voltage Supervisor with Integrated Watchdog Timer".  The operation of the watchdog feature of the chip is quite simple.

Please configure your mailer to produce line wraps.

> 
> 1. Use a GPIO of your system to write the SET1 pin of the TPS3851-Q1 high to enable the watchdog
> 2. Use a GPIO of your system to produce a falling edge to kick the watchdog.  The rate at which this must occur depends upon hardware pin strapping options and whether the chosen part uses "standard" or "extended" timing.
> 3. If you don't kick the watchdog, the WDO output of the TPS3851-Q1 will go low.  In the case of the board that I am working on, this is tied to the board reset
> 4. You may write 0 to SET1 to disable the watchdog
> 
> I discovered gpio_wdt.c in the Linux kernel and it seems like this driver is mostly compatible with this device.  What seems to be missing is the ability to control the SET1 pin to enable/disable the watchdog hardware.  Would it be sensible to define an optional devicetree property "enable-gpio" which if defined, is written high in gpio_wdt_probe() and low in gpio_wdt_remove().
> 

Sure, just provide a set of patches to add/document the property and
the code to use it.

> I also don't think I understand the "always_running" option of the driver.  If this option is false, then a call to gpio_wdt_stop() produces a call to gpio_wdt_disable().  The gpio_wdt_disable() function sets the watchdog signal GPIO to 1 and then reconfigures the GPIO to be an input if the hw_algo setting is HW_ALGO_TOGGLE.  I don't see how this will disable the watchdog since presumably TOGGLE based hardware is expecting the signal to toggle (and now it won't) and LEVEL based hardware is expecting either a rising or falling edge and no more edges will be produced.  Does anyone have any insight into how the driver is supposed to work when "always_running" is false?
> 

If you want to know how exactly this is implemented in hardware, I would
suggest to consult the various data sheets mentioned in the commit logs,
and if necessary the authors of the various patches. A quick check suggests
that the implemented mechanism works just fine at least with Maxim
MAX823/MAX824.

Thanks,
Guenter
