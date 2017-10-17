Return-Path: <akpm@linux-foundation.org>
Return-path: <akpm@linux-foundation.org>
Date: Tue, 17 Oct 2017 15:08:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-watchdog@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Wim Van Sebroeck
 <wim@iguana.be>, Andy Shevchenko <andy.shevchenko@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: core: Make use of
 devm_register_reboot_notifier()
Message-Id: <20171017150812.187a6816af791519294897b6@linux-foundation.org>
In-Reply-To: <CAHQ1cqFqupqUyVUrHcD6AcdyMBS_2f=0AZ-Og1pvQApjWozB_A@mail.gmail.com>
References: <20170411160615.9784-1-andrew.smirnov@gmail.com>
	<01843f95-c62f-7844-70ee-eed3dc7d3c23@roeck-us.net>
	<CAHQ1cqFqupqUyVUrHcD6AcdyMBS_2f=0AZ-Og1pvQApjWozB_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, 17 Oct 2017 08:50:12 -0700 Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> On Sat, Apr 15, 2017 at 11:11 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 04/11/2017 09:06 AM, Andrey Smirnov wrote:
> >>
> >> Save a bit of cleanup code by leveraging newly added
> >> devm_register_reboot_notifier().
> >>
> >> Cc: cphealy@gmail.com
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: Wim Van Sebroeck <wim@iguana.be>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> >
> 
> Andrew,
> 
> This patch can't go in via watchdog tree because it depends on
> devm_register_reboot_notifier() which is still present only in
> linux-next, any change you can pull this into linux-next as well?

That's because I've been sitting on
kernel-reboot-add-devm_register_reboot_notifier.patch since March
because it has no users.

This patch adds a user.  Have you identified other sites which
can/should use devm_register_reboot_notifier()?  I guess quite a lot,
so it's a matter of alerting developers to the new interface.  I
wonder how.  A checkpatch rule would do it, but that's new ground for
checkpatch.
