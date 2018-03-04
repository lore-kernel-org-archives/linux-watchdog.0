Return-Path: <torso.nafi@gmail.com>
Return-path: <torso.nafi@gmail.com>
MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?= <torso.nafi@gmail.com>
Date: Sun, 4 Mar 2018 19:26:56 +0300
Message-ID: <CAEo2pztutpwd0wvJWVmQ2XaT43nQ99StFbDMT7MQ5dkrMdkJvw@mail.gmail.com>
Subject: A case of watchdog+LED shared GPIO pin
To: linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

We (the development team at my current employer company) are having a
specific case of hardware configuraton. Namely, the same GPIO pin is
used for both watchdog keepalive signaling and status LED blinking.
The thing is, there are multiple blinking frequency modes for this
LED, each with its own meaning (i.e. system/firmware states), so
there's a need for changing the frequency/period dynamically from
userspace.

Previously I've done the thing implementing the timer period
configuration by updating a special sysfs file with new values in the
gpio_wdt driver. However since recently (commit 03bca15 in the kernel
Git repo) the timer has been swapped out with the keepalive callback
thing, which, as far as I can tell, supports updating the timeout
period via the WDIOC_SETTIMEOUT ioctl. However this ioctl is
insufficient for our purposes, in the sense that its minimum
resolution is 1 whole second, while we need a 100 millisecond
granularity at the very most.

I could also simply disable the gpio_wdt altogether and just use a LED
trigger driven configuration, but I highly doubt this would be a wise
thing, since the whole point of the watchdog is monitoring
responsiveness of the userspace. Also I gather that controlling the
GPIO entirely from a userspace process is rather undesirable, too, as
it might lead to confusing latencies sometimes, for a start.

I'd like to hear your opinions on the preferred way(s) of implementing
this for our product hardware on the most recent kernels, which could
be sent to upstream to secure further backwards compatibility.

Sincerely,
Ilyas
