Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52959 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab3LASyG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 Dec 2013 13:54:06 -0500
Message-ID: <529B85CD.9040505@roeck-us.net>
Date: Sun, 01 Dec 2013 10:54:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Markus Mayer <markus.mayer@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Linux Watchdog List <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC 0/2] Proposal for Watchdog Timer Resolution
References: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
In-Reply-To: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/29/2013 01:20 PM, Markus Mayer wrote:
> I would like to propose the following extension to the watchdog
> framework to allow userland programs access to the resolution of the
> watchdog timer should the hardware support such a feature. The first
> driver to make use of this feature would be the BCM Kona watchdog
> driver.
>
> I would also like to propose introducing a sysfs interface to the
> watchdog framework in a later phase of updating the watchdog framework.
> The sysfs interface would exist in addition to the existing ioctl
> interface. In the future, the ioctl interface could be deprecated in
> favour of the sysfs interface or both interfaces could be kept
> indefinitely.
>
> Phase 1:
>
> Add get resolution/set resolution ioctls.

Hi Markus,

I am not entirely sure I understand the rationale for this one, or if it is really
valuable for the user.

One example where a resolution might be applicable is the w83627hf_wdt.c driver.
The Winbond/Nuvoton chips support watchdog timeouts either in seconds or in
minutes, based on some configuration register. Currently the driver supports
only seconds (1..255). I had thought about extending it to minutes, but my
approach would have been to automatically select minutes-based timeouts if the
requested timeout is too large (> 255 seconds).

The same approach should be possible for the bcm_kona driver as well; just select
the optimal resolution based on the requested timeout. I think this would make more
sense than manual configuration from a user perspective, to keep the API as simple
as possible while supporting a wide range of timeouts.

On a side note, I don't think you specify anywhere what "resolution" actually means;
it is just a number which, as far as I can see, does not seem to resemble a specific
time. In the case of the bcm_kona driver, it appears to be that values of 0..15 map
to 30us .. 1s in reverse order, which translates to a maximum timeout of anywhere
between 32s and about 12 days.

Based on this, you could set the maximum permitted timeout for the driver to 12 days
or 748800 seconds (or , and then calculate the required resolution from the actually
selected timeout.

Example:
	requested timeout: 24 x 3600 = 86400 seconds, ie 1 day
	Required resolution: 86400 s / 0xfffff = 82.4 ms ==> resolution = 3.

On the other side, I am not sure if all this complexity is really needed.
Even at maximum resolution of 1s you can always provide the remaining timeout
exactly down to the second to the user, which is the granularity provided
by the watchdog subsystem. So, if you want to be able to support 12-day
timeouts, why don't you just set the resolution to the maximum supported ?

> Add necessary flags and call-back functions.
> Extend bcm_kona_wdt.c to make use of the new functionality.
>
> Phase 2:
>
> Abstract the ioctl interface (into watchdog_ioctl.c) with a new set of
> per-driver ops, similar to what other frameworks are already doing.
>
> Phase 3:
>
> Introduce a sysfs interface (watchdog_sysfs.c) hooking into the already
> established per-driver ops. ioctl and sysfs calls would use the same
> framework and driver functions, requiring no code duplication.
>
> Please let me know if this sounds sensible or whether an alternate
> approach would be preferred.
>
I would like to see a sysfs interface, so I would like to see phase 3.
I'd have to see a patch set for phase 2; not really sure what this entails.

Thanks,
Guenter

