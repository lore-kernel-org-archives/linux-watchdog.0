Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56369 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdF1Lbc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Jun 2017 07:31:32 -0400
Subject: Re: [PATCH v2 2/2] drivers/watchdog: ASPEED reference dev tree
 properties for config
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>, wim@iguana.be,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
 <20170627211734.60477-3-cbostic@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <606a2e11-2d43-5204-0bb6-9c4415ee03df@roeck-us.net>
Date: Wed, 28 Jun 2017 04:31:29 -0700
MIME-Version: 1.0
In-Reply-To: <20170627211734.60477-3-cbostic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/27/2017 02:17 PM, Christopher Bostic wrote:
> Reference the system device tree when configuring the watchdog
> engines.  Set external signal mode on timeout if specified.
> Set system reset on timeout if specified.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> ---
> v2 - Change of_get_property() to of_property_read_bool()
>     - Remove redundant check for NULL struct device_node pointer
>     - Optional property names now start with prefix 'aspeed,'
> ---
>   drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 1c65258..71ce5f5 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   {
>   	struct aspeed_wdt *wdt;
>   	struct resource *res;
> +	struct device_node *np;
>   	int ret;
>   
>   	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> @@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	 * the SOC and not the full chip
>   	 */
>   	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
> -		WDT_CTRL_1MHZ_CLK |
> -		WDT_CTRL_RESET_SYSTEM;
> +		WDT_CTRL_1MHZ_CLK;
> +
> +	np = pdev->dev.of_node;
> +	if (of_property_read_bool(np, "aspeed,sys-reset"))
> +		wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
> +

For backward compatibility, this should default to WDT_CTRL_RESET_SYSTEM
if no optional property is provided.

> +	if (of_property_read_bool(np, "aspeed,external-signal"))
> +		wdt->ctrl |= WDT_CTRL_WDT_EXT;
> +
> +	writel(wdt->ctrl, wdt->base + WDT_CTRL);
>   
>   	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
>   		aspeed_wdt_start(&wdt->wdd);
> 

