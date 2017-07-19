Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 19 Jul 2017 10:35:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 094/102] watchdog: mt7621: explicitly request exclusive
 reset control
Message-ID: <20170719173557.GB11439@roeck-us.net>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-95-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719152646.25903-95-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Jul 19, 2017 at 05:26:38PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mt7621_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 48a06067075d5..f6f4c1bf24c95 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -135,7 +135,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(mt7621_wdt_base))
>  		return PTR_ERR(mt7621_wdt_base);
>  
> -	mt7621_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
> +	mt7621_wdt_reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>  	if (!IS_ERR(mt7621_wdt_reset))
>  		reset_control_deassert(mt7621_wdt_reset);
>  
> -- 
> 2.11.0
> 
