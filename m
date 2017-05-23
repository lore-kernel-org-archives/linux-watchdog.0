Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:12483 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762092AbdEWH0q (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 May 2017 03:26:46 -0400
Subject: Re: [PATCH v5 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
 <20170522190751.5bf5e813@alans-desktop>
CC: <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        <esben.haabendal@gmail.com>, Guenter Roeck <linux@roeck-us.net>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <d83c4cd1-966a-a7df-c116-7b503208b74b@prevas.dk>
Date: Tue, 23 May 2017 09:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170522190751.5bf5e813@alans-desktop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 2017-05-22 20:07, Alan Cox wrote:
> On Mon, 22 May 2017 16:06:36 +0200
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
>> If a watchdog driver tells the framework that the device is running,
>> the framework takes care of feeding the watchdog until userspace opens
>> the device. If the userspace application which is supposed to do that
>> never comes up properly, the watchdog is fed indefinitely by the
>> kernel. This can be especially problematic for embedded devices.
>>
>> These patches allow one to set a maximum time for which the kernel
>> will feed the watchdog, thus ensuring that either userspace has come
>> up, or the board gets reset. This allows fallback logic in the
>> bootloader to attempt some recovery (for example, if an automatic
>> update is in progress, it could roll back to the previous version).
> 
> 
> This makes sense except for being a CONFIG_ option not a boot parameter.
> If it's a boot parameter then the same kernel works for multiple systems
> and is general. If it's compile time then you have to build a custom
> kernel.

I don't understand. Patch 3 simply allows the default to be set in the
config, but it is very much still possible to set it via the boot
command line, overriding the default (whether that was a CONFIG or a
hardcoded 0).

> For some embedded stuff that might not matter (although I bet they'd
> prefer it command line/device tree too)

When building a full BSP, yes, one can cook it into the boot command
line in u-boot, but that means that to update it one has to edit one's
u-boot recipe. It also often makes testing-turnaround times longer,
since updating the kernel can often be done by just scp'ing a new image
to the board, while updating the bootloader is sometimes a much more
involved procedure (not to mention that that's sometimes not even
possible to do remotely). There's also the issue of the command line
getting rather crowded if every aspect of the kernel has to be
configured at boot time.

As an embedded developer, I'm all for being able to override this
timeout as well lots of other kernel behavior via the command line, but
at the same time, I also prefer being able to set the default values in
the kernel's .config.

 but for something like an x86
> platform where you are deploying a standard vendor supplied kernel it's
> bad to do it that way IMHO.

A "standard vendor supplied kernel" will never set that CONFIG to
anything but its default - how could it possibly decide how long
userspace should have to open /dev/watchdog0, or even if userspace will
ever do that? Again, patch 3 doesn't in any way remove the possiblity of
setting this on the command line, and the end user is no worse off just
because the vendor had to keep a default setting.

> In other words I think you should drop patch 3 but the rest is good.

For the life of me, I cannot see the downside of patch 3, or how it's
any different from CONSOLE_LOGLEVEL_DEFAULT, BLK_DEV_RAM_SIZE, or any
number of other parameters-with-defaults-from-Kconfig.

Rasmus

