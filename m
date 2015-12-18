Return-path: <roy.qing.li@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5672CB9D.7000709@roeck-us.net>
References: <1450359002-26577-1-git-send-email-roy.qing.li@gmail.com>
	<5672CB9D.7000709@roeck-us.net>
Date: Fri, 18 Dec 2015 08:55:40 +0800
Message-ID: <CAJFZqHxvRX8ZW--VCx+N7zA-kOTXVt1tsQ2Ob1otMNJP6BREJw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: refuse to unload softdog module when its timer
 is running
From: Li RongQing <roy.qing.li@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Dec 17, 2015 at 10:50 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Don't bother with module_put() here.


I think this is needed;

the softdog supported soft_noreboot "Softdog action, set to 1 to
ignore reboots, 0 to reboot (default=0)"
if soft_noreboot is 1, and not call module_put(THIS_MODULE) in watchdog_fire,
softdog module ref count is leaked, and softdog will not be unload

-Roy
