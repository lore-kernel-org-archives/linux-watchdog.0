Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.168]:30686 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755940AbaHVHrp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Aug 2014 03:47:45 -0400
Date: Fri, 22 Aug 2014 10:39:31 +0200
From: Andreas Werner <andreas.werner@men.de>
To: Guenter Roeck <linux@roeck-us.net>
CC: Andreas Werner <andreas.werner@men.de>,
	<linux-kernel@vger.kernel.org>, <sameo@linux.intel.com>,
	<lee.jones@linaro.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>, <cooloney@gmail.com>,
	<rpurdie@rpsys.net>, <linux-leds@vger.kernel.org>,
	<jdelvare@suse.de>, <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH v4 4/4] drivers/hwmon/menf21bmc_hwmon: introduce
 MEN14F021P00 BMC HWMON driver
Message-ID: <20140822083930.GB453@awelinux>
References: <cover.1407918792.git.andreas.werner@men.de>
 <cf0593273cbadcb16b094b7bc3bd9d3b5a93f7ed.1407918792.git.andreas.werner@men.de>
 <20140821184501.GC16045@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20140821184501.GC16045@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 21, 2014 at 11:45:01AM -0700, Guenter Roeck wrote:
> On Wed, Aug 13, 2014 at 10:40:37AM +0200, Andreas Werner wrote:
> > Added driver to support the 14F021P00 BMC Hardware Monitoring.
> > The BMC is a Board Management Controller including monitoring of the
> > board voltages.
> > 
> > Signed-off-by: Andreas Werner <andreas.werner@men.de>
> > ---
> >  drivers/hwmon/Kconfig           |   7 ++
> >  drivers/hwmon/Makefile          |   1 +
> >  drivers/hwmon/menf21bmc_hwmon.c | 238 ++++++++++++++++++++++++++++++++++++++++
> 
> Forgot: Please also provide Documentation/hwmon/menf21bmc.
> 

Did not know that i have to do it.
But you are right it is good to have one.

> Thanks,
> Guenter
