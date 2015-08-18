Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58414 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbHRPsr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 11:48:47 -0400
Message-ID: <55D353D7.4020904@roeck-us.net>
Date: Tue, 18 Aug 2015 08:48:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Pratyush Anand <panand@redhat.com>, linux-watchdog@vger.kernel.org
CC: dyoung@redhat.com, dzickus@redhat.com
Subject: Re: [PATCH 00/37] watchdog: Fix parent of watchdog devices
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/17/2015 09:47 PM, Pratyush Anand wrote:
> Hi,
>
> I posted a query here (https://lkml.org/lkml/2015/8/10/19), but did not get any
> feedback. So, thought to post patches and to seek response.
>
> I need some way to identify the driver/module for a given watchdog node say
> /dev/watchdog0.
>
> Documentation/watchdog/watchdog-api.txt says:
> identity                a string identifying the watchdog driver
>
> However, all the watchdog driver does not define identity as DRV_NAME.
>
> Otherway could be to look for /sys/class/watchdog/watchdog0/device/modalias.
>
> However, many wdt devices does not set its parent and so, we do not see an entry
> for /sys/class/watchdog/watchdog0/device/ in sysfs.
>
> This patch set fixes parent for wdt drivers written in watchdog-core framework.
>
> Exceptions: booke, diag288, mpc8xxx, octeon, softdog and w83627hf -- They do not
> have any parent. Not sure, how we can identify driver for these devices.
>

Series makes sense, but imposes a huge burden on the maintainer.
I think this is one of those changes where a single patch would make much more sense.

I merged all patches into my test repository for build and runtime tests,
but I would suggest to resubmit the series as a single patch.

Thanks,
Guenter

