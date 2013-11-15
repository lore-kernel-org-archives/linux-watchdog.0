Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Date: Fri, 15 Nov 2013 22:14:15 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Markus Mayer <markus.mayer@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Christian Daudt <bcm@fixthebug.org>,
        Linaro Patches <patches@linaro.org>,
        Matt Porter <matt.porter@linaro.org>,
        Linux Watchdog List
 <linux-watchdog@vger.kernel.org>,
        ARM Kernel List
 <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] watchdog: bcm281xx: Watchdog Driver
Message-ID: <20131115221415.2639daf0@alan.etchedpixels.co.uk>
In-Reply-To: <CAPdLdq=4HGZmQRJywto=u9SWaChoWz77oALVcKgggMA-fdsg+w@mail.gmail.com>
References: <1384549081-9571-1-git-send-email-markus.mayer@linaro.org>
	<1384549081-9571-2-git-send-email-markus.mayer@linaro.org>
	<CAPdLdq=4HGZmQRJywto=u9SWaChoWz77oALVcKgggMA-fdsg+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

> > +
> > +#define BCM_KONA_WDT_NAME              "bcm-kona-wdt"
> 
> I just noticed that this should be "bcm_kona_wdt" instead.


Otherwise looks good.

Alan
