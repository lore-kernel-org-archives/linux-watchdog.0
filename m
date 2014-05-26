Return-Path: <wimvs@spo001.leaseweb.com>
Date: Mon, 26 May 2014 23:26:46 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] watchdog: Remove drivers for W83697HF and W83697UG
Message-ID: <20140526212646.GB23827@spo001.leaseweb.com>
References: <1396722457-8275-1-git-send-email-linux@roeck-us.net> <1396722457-8275-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1396722457-8275-2-git-send-email-linux@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> Since both chips are now supported by the w83627hf watchdog driver,
> the chip specific drivers are no longer needed and can be removed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: rebase to latest upstream kernel
> v2: resend, no change to v1
> 
>  drivers/watchdog/Kconfig        |   30 ---
>  drivers/watchdog/Makefile       |    2 -
>  drivers/watchdog/w83697hf_wdt.c |  460 ---------------------------------------
>  drivers/watchdog/w83697ug_wdt.c |  397 ---------------------------------
>  4 files changed, 889 deletions(-)
>  delete mode 100644 drivers/watchdog/w83697hf_wdt.c
>  delete mode 100644 drivers/watchdog/w83697ug_wdt.c
> 

Has been added to linux-watchdog-next.

Kind regards,
Wim.
