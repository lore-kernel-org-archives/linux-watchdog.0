Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sun, 1 Jan 2017 12:14:22 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Mans Rullgard <mans@mansr.com>, Justin Chen <justinpopo6@gmail.com>,
	Wenyou Yang <wenyou.yang@atmel.com>,
	Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: Re: Stopping watchdog in watchdog driver remove functions
Message-ID: <20170101111421.GA9695@spo001.leaseweb.nl>
References: <64c83c02-2c64-c536-3302-8079f438f0ab@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c83c02-2c64-c536-3302-8079f438f0ab@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> I noticed that several watchdog drivers stop the watchdog in trhe driver 
> remove function.
> A non-exhaustive list of drivers doing that is
> 
> 	drivers/watchdog/bcm7038_wdt.c
> 	drivers/watchdog/cadence_wdt.c
> 	drivers/watchdog/imgpdc_wdt.c
> 	drivers/watchdog/jz4740_wdt.c
> 	drivers/watchdog/kempld_wdt.c
> 	drivers/watchdog/max77620_wdt.c
> 	drivers/watchdog/moxart_wdt.c
> 	drivers/watchdog/sama5d4_wdt.c
> 	drivers/watchdog/tangox_wdt.c
> 	drivers/watchdog/tegra_wdt.c
> 
> Since a watchdog has to be closed for its driver to be removable, one 
> situation
> where a watchdog is still running on unload is where the watchdog was 
> opened but
> not closed properly (eg by killing the watchdog application, or if the 
> 'nowayout'
> flag is set).
> 
> Given that, does it even make sense to stop the watchdog in the remove 
> function ?
> Should it even be permitted ?

>From an API point of view: if WDIOF_MAGICCLOSE is being used then the watchdog
_SHOULD_ continue to run when the watchdog was not properly closed (which
normally also results in a reboot of the system).
if WDIOF_MAGICCLOSE is not being used then closing the watchdog device means
that the driver needs to stop the watchdog.

Kind regards and happy new year to you all,
Wim.
