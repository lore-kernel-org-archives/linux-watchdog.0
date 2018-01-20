Return-Path: <prasannatsmkumar@gmail.com>
Return-path: <prasannatsmkumar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171230135108.6834-3-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net> <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-3-paul@crapouillou.net>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Sat, 20 Jan 2018 13:01:17 +0530
Message-ID: <CANc+2y7CT150cO61RfRgc6hCLEasx+NmqCacZtaFPKLgTPyt4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] watchdog: JZ4740: Register a restart handler
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>,
	open list <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Paul,

On 30 December 2017 at 19:21, Paul Cercueil <paul@crapouillou.net> wrote:
> The watchdog driver can restart the system by simply configuring the
> hardware for a timeout of 0 seconds.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
>  v2: No change
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 92d6ca8ceb49..fa7f49a3212c 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>         return 0;
>  }
>
> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
> +                             unsigned long action, void *data)
> +{
> +       wdt_dev->timeout = 0;
> +       jz4740_wdt_start(wdt_dev);
> +       return 0;
> +}
> +
>  static const struct watchdog_info jz4740_wdt_info = {
>         .options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>         .identity = "jz4740 Watchdog",
> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>         .stop = jz4740_wdt_stop,
>         .ping = jz4740_wdt_ping,
>         .set_timeout = jz4740_wdt_set_timeout,
> +       .restart = jz4740_wdt_restart,
>  };
>
>  #ifdef CONFIG_OF
> --
> 2.11.0
>
>

Noticed that min_timeout of the watchdog device is set to 1 but this
function calls start with timeout set to 0. Even though this works I
feel it is better to set min_timeout to 0.

Regards,
PrasannaKumar
