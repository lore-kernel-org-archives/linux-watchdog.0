Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39377 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965345AbeCGUDA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Mar 2018 15:03:00 -0500
Date: Wed, 7 Mar 2018 12:02:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=
        <torso.nafi@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: A case of watchdog+LED shared GPIO pin
Message-ID: <20180307200258.GB10381@roeck-us.net>
References: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Mar 04, 2018 at 07:26:56PM +0300, Ильяс Гасанов wrote:
> Hello,
> 
> We (the development team at my current employer company) are having a
> specific case of hardware configuraton. Namely, the same GPIO pin is
> used for both watchdog keepalive signaling and status LED blinking.
> The thing is, there are multiple blinking frequency modes for this
> LED, each with its own meaning (i.e. system/firmware states), so
> there's a need for changing the frequency/period dynamically from
> userspace.
> 
> Previously I've done the thing implementing the timer period
> configuration by updating a special sysfs file with new values in the
> gpio_wdt driver. However since recently (commit 03bca15 in the kernel
> Git repo) the timer has been swapped out with the keepalive callback
> thing, which, as far as I can tell, supports updating the timeout
> period via the WDIOC_SETTIMEOUT ioctl. However this ioctl is
> insufficient for our purposes, in the sense that its minimum
> resolution is 1 whole second, while we need a 100 millisecond
> granularity at the very most.
> 
> I could also simply disable the gpio_wdt altogether and just use a LED
> trigger driven configuration, but I highly doubt this would be a wise
> thing, since the whole point of the watchdog is monitoring
> responsiveness of the userspace. Also I gather that controlling the
> GPIO entirely from a userspace process is rather undesirable, too, as
> it might lead to confusing latencies sometimes, for a start.
> 
> I'd like to hear your opinions on the preferred way(s) of implementing
> this for our product hardware on the most recent kernels, which could
> be sent to upstream to secure further backwards compatibility.
> 

Using the same GPIO pin for both watchdog and LEDs seems odd. I don't
have a useful idea how to address your problem, sorry.

Guenter
