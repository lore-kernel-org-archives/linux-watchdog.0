Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56277 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627AbcECNaJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2016 09:30:09 -0400
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Pratyush Anand <panand@redhat.com>, fu.wei@linaro.org,
	Suravee.Suthikulpanit@amd.com, timur@codeaurora.org, wim@iguana.be
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5728A7C3.4010001@roeck-us.net>
Date: Tue, 3 May 2016 06:29:39 -0700
MIME-Version: 1.0
In-Reply-To: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/03/2016 01:20 AM, Pratyush Anand wrote:
> Currently only WOR is used to program both first and second stage which
> provided very limited range of timeout.
>
> This patch uses WCV as well to achieve higher range of timeout. This patch
> programs max_timeout as 255, but that can be increased further as well.
>
> Following testing shows that we can happily achieve 40 second default timeout.
>
>   # modprobe sbsa_gwdt action=1
>   [  131.187562] sbsa-gwdt sbsa-gwdt.0: Initialized with 40s timeout @ 250000000 Hz, action=1.
>   # cd /sys/class/watchdog/watchdog0/
>   # cat state
>   inactive
>   # cat /dev/watchdog0
>   cat: /dev/watchdog0: Invalid argument
>   [  161.710593] watchdog: watchdog0: watchdog did not stop!
>   # cat state
>   active
>   # cat timeout
>   40
>   # cat timeleft
>   38
>   # cat timeleft
>   25
>   # cat /dev/watchdog0
>   cat: /dev/watchdog0: Invalid argument
>   [  184.931030] watchdog: watchdog0: watchdog did not stop!
>   # cat timeleft
>   37
>   # cat timeleft
>   21
>   ...
>   ...
>   # cat timeleft
>   1
>
> panic() is called upon timeout of 40s. See timestamp of last kick (cat) and
> next panic() message.
>
>   [  224.939065] Kernel panic - not syncing: SBSA Watchdog timeout
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>

You could also use the new infrastructure (specify max_hw_heartbeat_ms instead
of max_timeout), and not depend on the correct implementation of WCV.

Overall this adds a lot of complexity for something that could by now easily
be handled by the infrastructure. Is this really necessary ?

Guenter

> ---
>   drivers/watchdog/sbsa_gwdt.c | 83 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 62 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index ad383f6f15fc..529dd5e99fcd 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -35,17 +35,23 @@
>    *
>    * SBSA GWDT:
>    * if action is 1 (the two stages mode):
> - * |--------WOR-------WS0--------WOR-------WS1
> + * |--------WCV-------WS0--------WCV-------WS1
>    * |----timeout-----(panic)----timeout-----reset
>    *
>    * if action is 0 (the single stage mode):
> - * |------WOR-----WS0(ignored)-----WOR------WS1
> + * |------WCV-----WS0(ignored)-----WOR------WS1
>    * |--------------timeout-------------------reset
>    *
> - * Note: Since this watchdog timer has two stages, and each stage is determined
> - * by WOR, in the single stage mode, the timeout is (WOR * 2); in the two
> - * stages mode, the timeout is WOR. The maximum timeout in the two stages mode
> - * is half of that in the single stage mode.
> + * Note: This watchdog timer has two stages. If action is 0, first stage is
> + * determined by directly programming WCV and second by WOR. When first
> + * timeout is reached, WS0 is triggered and WCV is reloaded with value in
> + * WOR. WS0 interrupt will be ignored, then the second watch period starts;
> + * when second timeout is reached, then WS1 is triggered, system resets. WCV
> + * and WOR are programmed in such a way that total time corresponding to
> + * WCV+WOR becomes equivalent to user programmed "timeout".
> + * If action is 1, then we expect to call panic() at user programmed
> + * "timeout". Therefore, we program both first and second stage using WCV
> + * only.
>    *
>    */
>
> @@ -95,7 +101,17 @@ struct sbsa_gwdt {
>   	void __iomem		*control_base;
>   };
>
> -#define DEFAULT_TIMEOUT		10 /* seconds */
> +/*
> + * Max Timeout Can be in days, but 255 seconds seems reasonable for all use
> + * cases
> + */
> +#define MAX_TIMEOUT		255

We don't usually define such arbitrary limits.

> +
> +/* Default timeout is 40 seconds, which is the 1st + 2nd watch periods when
> + * action is 0. When action is 1 then both 1st and 2nd watch periods will
> + * be of 40 seconds.
> + */
> +#define DEFAULT_TIMEOUT		40 /* seconds */
>
>   static unsigned int timeout;
>   module_param(timeout, uint, 0);
> @@ -127,20 +143,21 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>   				 unsigned int timeout)
>   {
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
> +	u64 timeout_1, timeout_2;
>
>   	wdd->timeout = timeout;
>
>   	if (action)
> -		writel(gwdt->clk * timeout,
> -		       gwdt->control_base + SBSA_GWDT_WOR);
> +		timeout_1 = (u64)gwdt->clk * timeout;
>   	else
> -		/*
> -		 * In the single stage mode, The first signal (WS0) is ignored,
> -		 * the timeout is (WOR * 2), so the WOR should be configured
> -		 * to half value of timeout.
> -		 */
> -		writel(gwdt->clk / 2 * timeout,
> -		       gwdt->control_base + SBSA_GWDT_WOR);
> +		timeout_1 = (u64)gwdt->clk * (timeout - wdd->min_timeout);
> +
> +	/* when action=1, timeout_2 will be overwritten in ISR */
> +	timeout_2 = (u64)gwdt->clk * wdd->min_timeout;
> +
Why min_timeout ? Also, where is it overwritten in the interrupt handler,
and to which value ?

> +	writel(timeout_2, gwdt->control_base + SBSA_GWDT_WOR);
> +	writeq(timeout_1 + arch_counter_get_cntvct(),
> +		gwdt->control_base + SBSA_GWDT_WCV);
>
>   	return 0;
>   }
> @@ -172,12 +189,17 @@ static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
>
>   	/*
> -	 * Writing WRR for an explicit watchdog refresh.
> -	 * You can write anyting (like 0).
> +	 * play safe: program WOR with max value so that we have sufficient
> +	 * time to overwrite them after explicit refresh
>   	 */
> +	writel(U32_MAX, gwdt->control_base + SBSA_GWDT_WOR);
> +	/*
> +	* Writing WRR for an explicit watchdog refresh.
> +	* You can write anyting (like 0).
> +	*/

Please stick with standard multi-line comments.

>   	writel(0, gwdt->refresh_base + SBSA_GWDT_WRR);
>
> -	return 0;
> +	return sbsa_gwdt_set_timeout(wdd, wdd->timeout);;
>   }
>
>   static unsigned int sbsa_gwdt_status(struct watchdog_device *wdd)
> @@ -193,10 +215,15 @@ static int sbsa_gwdt_start(struct watchdog_device *wdd)
>   {
>   	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
>
> +	/*
> +	 * play safe: program WOR with max value so that we have sufficient
> +	 * time to overwrite them after explicit refresh
> +	 */
> +	writel(U32_MAX, gwdt->control_base + SBSA_GWDT_WOR);
>   	/* writing WCS will cause an explicit watchdog refresh */
>   	writel(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
>
> -	return 0;
> +	return sbsa_gwdt_set_timeout(wdd, wdd->timeout);;
>   }
>
>   static int sbsa_gwdt_stop(struct watchdog_device *wdd)
> @@ -211,6 +238,20 @@ static int sbsa_gwdt_stop(struct watchdog_device *wdd)
>
>   static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>   {
> +	struct sbsa_gwdt *gwdt = (struct sbsa_gwdt *)dev_id;
> +	struct watchdog_device *wdd = &gwdt->wdd;
> +	u64 timeout_2 = (u64)gwdt->clk * wdd->timeout;
> +
> +	/*
> +	 * Since we can not trust system at this moment, therefore re-write
> +	 * WCV only if wdd->timeout <= MAX_TIMEOUT to avoid a corner
> +	 * scenario when we might have corrupted wdd->timeout values at
> +	 * this point.
> +	 */

This is quite vague. What is this corner scenario where wdd->timeout
would be corrupted ? How can wdd->timeout ever be larger than MAX_TIMEOUT ?

> +	if (wdd->timeout <= MAX_TIMEOUT)
> +		writeq(timeout_2 + arch_counter_get_cntvct(),
> +			gwdt->control_base + SBSA_GWDT_WCV);
> +
>   	panic(WATCHDOG_NAME " timeout");
>
>   	return IRQ_HANDLED;
> @@ -273,7 +314,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>   	wdd->info = &sbsa_gwdt_info;
>   	wdd->ops = &sbsa_gwdt_ops;
>   	wdd->min_timeout = 1;
> -	wdd->max_timeout = U32_MAX / gwdt->clk;
> +	wdd->max_timeout = MAX_TIMEOUT;
>   	wdd->timeout = DEFAULT_TIMEOUT;
>   	watchdog_set_drvdata(wdd, gwdt);
>   	watchdog_set_nowayout(wdd, nowayout);
>

