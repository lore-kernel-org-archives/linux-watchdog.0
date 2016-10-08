Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 8 Oct 2016 16:03:48 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: rt2880_wdt: Remove assignment of dev pointer
Message-ID: <20161008140348.GC23290@spo001.leaseweb.nl>
References: <1473672913-10484-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1473672913-10484-1-git-send-email-matt.redfearn@imgtec.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Matt,

> Commit 0254e953537c ("watchdog: Drop pointer to watchdog device from
> struct watchdog_device") removed the dev pointer from struct
> watchdog_device, but this driver was still assigning it, leading to a
> compilation error:
> 
> drivers/watchdog/rt2880_wdt.c: In function ‘rt288x_wdt_probe’:
> drivers/watchdog/rt2880_wdt.c:161:16: error: ‘struct watchdog_device’
> has no member named ‘dev’
>   rt288x_wdt_dev.dev = &pdev->dev;
>                 ^
> scripts/Makefile.build:289: recipe for target
> 'drivers/watchdog/rt2880_wdt.o' failed
> 
> Fix this by removing the assignment.
> 
> Fixes: 0254e953537c
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---

This patch and a similar patch from Guenter regarding mt7621_wdt was
added to linux-watchdog-next almost 2 weeks ago.

Kind regards,
Wim.
