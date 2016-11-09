Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-eopbgr40122.outbound.protection.outlook.com ([40.107.4.122]:28704
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932398AbcKIOzF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 9 Nov 2016 09:55:05 -0500
From: Cor Peters <cpeters@victronenergy.com>
To: <linux-watchdog@vger.kernel.org>
Subject: Re: omap watchdog boot status
Date: Wed, 9 Nov 2016 15:40:26 +0100
Message-ID: <51015056.IPIqE8z1xd@corpeters>
In-Reply-To: <8d23fff0-5e47-e623-f367-b2605b796bdf@roeck-us.net>
References: <1837421.P2zRp1Vi4u@corpeters> <8d23fff0-5e47-e623-f367-b2605b796bdf@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 07 November 2016 17:12:56 Guenter Roeck wrote:
> On 11/07/2016 06:26 AM, Cor Peters wrote:
> > Hello everybody
> >
> > I was looking into an issue with the omap-wdt.c. The  watchdog driver not is
> > reporting a different boot status when a reset is being triggered by the
> > watchdog.
> >
> >>From what I gathered, the issue is that in the omap_wdt_probe function,
> > pdev->dev->platform_data requires to be a reference to the PRM module,
> > however it has not been set, and I was wondering how this should work in
> > an environment that uses the device tree method. (Link to usage:
> > http://lxr.free-electrons.com/source/drivers/watchdog/omap_wdt.c#L268[1] ).
> >
> > My questions are as follows:
> > 1) Is my assertion correct that the current method does not work when
> >   the driver is being initialised from an device tree instead of a old style
> >   board file.
> 
> I think you are correct.
> 
> > 2) If that is the case, what would be the best method of fixing this situation.
> >
> I am not a devicetree expert, but you may have to define a property to point to
> the register and bit providing the necessary information. This could possibly
> be done with syscon, but I really don't know enough about it to really know for
> sure what the best approach would be.

Thanks, syscon seems like a good solution.
 
> Guenter
> 

Cor
