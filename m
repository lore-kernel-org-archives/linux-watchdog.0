Return-Path: <joel.stan@gmail.com>
Return-path: <joel.stan@gmail.com>
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170920053020.6860-2-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au> <20170920053020.6860-2-andrew@aj.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Sep 2017 15:37:13 +0930
Message-ID: <CACPK8XfK8voWhPoYg0kG-OhQoTH_B+=ES8BqbT26bdPYf39d1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] watchdog: aspeed: Retain watchdog enabled state
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Sep 20, 2017 at 3:00 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> An unintended post-condition of probe() is that the watchdog is
> disabled. This behaviour was introduced by an unnecessary write to the
> control register to configure the hardware based on the devicetree. The
> write is unnecessary because the cached control value that is
> manipulated by the code parsing the devicetree is eventually written by
> aspeed_wdt_enable(), which is when we care how the control register
> should be configured.
>
> Remove the write to restore expected behaviour.
>
> Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks,

Joel
