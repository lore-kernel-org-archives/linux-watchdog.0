Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60516 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbcKHBM7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 Nov 2016 20:12:59 -0500
Subject: Re: omap watchdog boot status
To: Cor Peters <cpeters@victronenergy.com>,
        linux-watchdog@vger.kernel.org
References: <1837421.P2zRp1Vi4u@corpeters>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8d23fff0-5e47-e623-f367-b2605b796bdf@roeck-us.net>
Date: Mon, 7 Nov 2016 17:12:56 -0800
MIME-Version: 1.0
In-Reply-To: <1837421.P2zRp1Vi4u@corpeters>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/07/2016 06:26 AM, Cor Peters wrote:
> Hello everybody
>
> I was looking into an issue with the omap-wdt.c. The  watchdog driver not is
> reporting a different boot status when a reset is being triggered by the
> watchdog.
>
>>From what I gathered, the issue is that in the omap_wdt_probe function,
> pdev->dev->platform_data requires to be a reference to the PRM module,
> however it has not been set, and I was wondering how this should work in
> an environment that uses the device tree method. (Link to usage:
> http://lxr.free-electrons.com/source/drivers/watchdog/omap_wdt.c#L268[1] ).
>
> My questions are as follows:
> 1) Is my assertion correct that the current method does not work when
>   the driver is being initialised from an device tree instead of a old style
>   board file.

I think you are correct.

> 2) If that is the case, what would be the best method of fixing this situation.
>
I am not a devicetree expert, but you may have to define a property to point to
the register and bit providing the necessary information. This could possibly
be done with syscon, but I really don't know enough about it to really know for
sure what the best approach would be.

Guenter

