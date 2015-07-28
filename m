Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35584 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834AbbG1Jwj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 05:52:39 -0400
Received: by wibxm9 with SMTP id xm9so149008378wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 02:52:38 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:52:36 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150728095236.GF2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <55B636D4.6020709@roeck-us.net>
 <20150727141948.GA2677@codeblueprint.co.uk>
 <55B63F09.4030101@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B63F09.4030101@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul, at 07:24:09AM, Guenter Roeck wrote:
> On 07/27/2015 07:19 AM, Matt Fleming wrote:
> >On Mon, 27 Jul, at 06:49:08AM, Guenter Roeck wrote:
> >>
> >>I don't see the platform data freed anywhere, neither in the error path nor
> >>in the cleanup path of this driver. Can you use devm_kzalloc() ?
> >>Otherwise I think you'll need a cleanup path.
> >
> >Oops, good catch. Yes, devm_kzalloc() can be used here, thanks!
> >
> Or maybe just use a static data structure, like in the i2c driver.

The point of dynamically allocating it is that we can use the data from
the static lpc_ich_chipset_info array and munge into the correct
platform data.

The alternative would be to go and mass-modify that array to include
iTCO_wdt_platform_data objects that we could directly pass to the
iTCO_wdt driver. I wanted to avoid the code churn, but I'm not super
bothered either way if people have strong opinions about it.

-- 
Matt Fleming, Intel Open Source Technology Center
