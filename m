Return-path: <Ezequiel.Garcia@imgtec.com>
Message-ID: <5473439E.4000901@imgtec.com>
Date: Mon, 24 Nov 2014 11:41:34 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: <naidu.tellapati@gmail.com>, <wim@iguana.be>, <linux@roeck-us.net>,
	<abrestic@chromium.org>, <james.hartley@imgtec.com>, <james.hogan@imgtec.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<arul.ramasamy@imgtec.com>, Jude Abraham <Jude.Abraham@imgtec.com>, "Naidu
 Tellapati" <Naidu.Tellapati@imgtec.com>
Subject: Re: [PATCH RESEND v5 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
References: <1416597957-10516-1-git-send-email-Naidu.Tellapati@gmail.com> <1416597957-10516-2-git-send-email-Naidu.Tellapati@gmail.com>
In-Reply-To: <1416597957-10516-2-git-send-email-Naidu.Tellapati@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>


Hi Naidu,

Just a few nitpicks on my side. See below.

On 11/21/2014 04:25 PM, naidu.tellapati@gmail.com wrote:
> From: Jude Abraham <Jude.Abraham@imgtec.com>
> 
> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
> 
> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
[..]
> +
> +struct pdc_wdt_dev {
> +	struct device *dev;

'dev' is unused.

> +	struct watchdog_device wdt_dev;
> +	struct clk *wdt_clk;
> +	struct clk *sys_clk;
> +	unsigned long clk_rate;

'clk_rate' is unused.

> +	int min_delay;
> +	void __iomem *base;
> +};
> +
[..]
> +
> +/* Start the watchdog timer (delay should already be set */

Typo here: missing closing parenthesis.

[..]
> +
> +static int pdc_wdt_probe(struct platform_device *pdev)
> +{
> +	int ret, val;
> +	struct resource *res;
> +	struct pdc_wdt_dev *pdc_wdt;
> +
> +	pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
> +	if (!pdc_wdt)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pdc_wdt->base))
> +		return PTR_ERR(pdc_wdt->base);
> +
> +	pdc_wdt->sys_clk = devm_clk_get(&pdev->dev, "sys");
> +	if (IS_ERR(pdc_wdt->sys_clk)) {
> +		dev_err(&pdev->dev, "failed to get the sys clock.\n");
> +		ret = PTR_ERR(pdc_wdt->wdt_clk);
> +		goto out_wdt;

I'd say remove all uses of the out_wdt label and just return ret.

Reviewed-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Wim: Any comments? We're aiming at having this driver merged for v3.19.

Thanks!
-- 
Ezequiel
