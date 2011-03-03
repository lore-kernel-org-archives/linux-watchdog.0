Message-ID: <4D6F7F1C.5040001@mvista.com>
Date: Thu, 03 Mar 2011 14:44:28 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: John Crispin <blogic@openwrt.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V3 05/10] MIPS: lantiq: add watchdog support
References: <1299146626-17428-1-git-send-email-blogic@openwrt.org> <1299146626-17428-6-git-send-email-blogic@openwrt.org>
In-Reply-To: <1299146626-17428-6-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hello.

On 03-03-2011 13:03, John Crispin wrote:

> This patch adds the driver for the watchdog found inside the Lantiq SoC family.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Signed-off-by: Ralph Hempel<ralph.hempel@lantiq.com>
> Cc: Wim Van Sebroeck<wim@iguana.be>
> Cc: linux-mips@linux-mips.org
> Cc: linux-watchdog@vger.kernel.org
[...]

> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> new file mode 100644
> index 0000000..d49ddaa
> --- /dev/null
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -0,0 +1,235 @@
[...]
> +static void
> +ltq_wdt_disable(void)
> +{
> +#ifndef CONFIG_WATCHDOG_NOWAYOUT
> +	ltq_wdt_ok_to_close = 0;
> +#endif
> +	/* write the first paswword magic */
                               ^
    You still didn't fix the typo here. :-)

> +	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
> +	/* write the second paswword magic with no config
                                ^
    And here...

> +static int
> +ltq_wdt_probe(struct platform_device *pdev)

    Should be __init now that you're using platform_driver_probe()...

> +	/* we do not need to enable the clock as it is always running */
> +	clk = clk_get(&pdev->dev, "io");
> +	if (!clk)
> +		BUG();

    BUG_ON(!clk);

> +static struct platform_driver ltq_wdt_driver = {
> +	.probe = ltq_wdt_probe,

    No need to initialize it now that you're using platform_driver_probe()...

> +	.remove = ltq_wdt_remove,

    Shouldn't 'ltq_wdt_remove' be enclosed in __exit_p()?

WBR, Sergei
