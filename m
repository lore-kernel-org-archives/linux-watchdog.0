Message-ID: <4F3E9129.9040704@mvista.com>
Date: Fri, 17 Feb 2012 20:40:57 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: John Crispin <blogic@openwrt.org>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 9/9] WDT: MIPS: lantiq: convert watchdog driver to clkdev
 api
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-10-git-send-email-blogic@openwrt.org>
In-Reply-To: <1329474800-20979-10-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hello.

On 02/17/2012 01:33 PM, John Crispin wrote:

> Update from old pmu_{dis,en}able() to ckldev api.

   Again, you're doing something different.

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> ---
> This patch should go via MIPS with the rest of the series.
>
>   drivers/watchdog/lantiq_wdt.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 9c8b10c..05646b8 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -206,7 +206,7 @@ ltq_wdt_probe(struct platform_device *pdev)
>   	}
>
>   	/* we do not need to enable the clock as it is always running */
> -	clk = clk_get(&pdev->dev, "io");
> +	clk = clk_get_sys("io", NULL);

    Why not clk_get(&pdev->dev, NULL)?

WBR, Sergei
