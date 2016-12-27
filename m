Return-path: <baruch@tkos.co.il>
Date: Tue, 27 Dec 2016 07:07:40 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, wim@iguana.be, linux@roeck-us.net,
	f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	support.opensource@diasemi.com, manabian@gmail.com,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] watchdog: constify watchdog_info structures
Message-ID: <20161227050740.fqpmxxqxtalkovka@tarshish>
References: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482771911-13548-1-git-send-email-bhumirks@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Bhumika Goyal,

On Mon, Dec 26, 2016 at 10:35:11PM +0530, Bhumika Goyal wrote:
> Declare watchdog_info structures as const as they are only stored in the
> info field of watchdog_device structures. This field is of type const
> struct watchdog_info *, so watchdog_info structures having this property
> can be declared const too.
> Done using Coccinelle:
> 
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_info i@p={...};
> 
> @ok@
> identifier r1.i;
> position p;
> struct watchdog_device obj;
> @@
> obj.info=&i@p;
> 
> @bad@
> position p!={r1.p,ok.p};
> identifier r1.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct watchdog_info i;
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

For digicolor_wdt.c:

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
