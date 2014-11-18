Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:40096 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaKRXGv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Nov 2014 18:06:51 -0500
Received: by mail-vc0-f182.google.com with SMTP id im17so8985486vcb.41
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Nov 2014 15:06:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com>
Date: Tue, 18 Nov 2014 15:06:50 -0800
Message-ID: <CAL1qeaFb1K0eD-wnnQPhzN5z9KWaz9LoS7S=fx2d7kUhuYmU6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
From: Andrew Bresticker <abrestic@chromium.org>
To: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Naidu,

On Tue, Nov 18, 2014 at 4:07 AM,  <Naidu.Tellapati@imgtec.com> wrote:
> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>
> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>
> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Almost there, just a couple of comments:

> --- /dev/null
> +++ b/drivers/watchdog/imgpdc_wdt.c

> +#define PDC_WD_CONFIG                  0x004
> +#define PDC_WD_MAX_DELAY               31 /* 4:0 bits */
> +#define PDC_WD_CONFIG_ENABLE           BIT(31)
> +#define PDC_WD_CONFIG_DELAY_MASK       0x0000001f

PDC_WD_MAX_DELAY and PDC_WD_CONFIG_DELAY_MASK are the same thing -
just pick one (probably PDC_WD_CONFIG_DELAY_MASK).

> +struct pdc_wdt_dev {
> +       struct device *dev;
> +       struct watchdog_device wdt_dev;
> +       struct clk *wdt_clk;
> +       struct clk *sys_clk;
> +       unsigned long clk_rate;
> +       unsigned int min_delay;
> +       void __iomem *base;
> +       spinlock_t lock;

Now that there's no clock notifier, I don't think you need this
spinlock anymore.

> +static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +                              unsigned int new_timeout)
> +{
> +       unsigned int val;
> +       struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
> +
> +       if (new_timeout < wdt->wdt_dev.min_timeout ||
> +           new_timeout > wdt->wdt_dev.max_timeout)
> +               return -EINVAL;

The watchdog core already does this check for us.

> +       spin_lock(&wdt->lock);
> +       wdt->wdt_dev.timeout = new_timeout;
> +       /* round up to the next power of 2 */
> +       new_timeout = order_base_2(new_timeout);
> +       val = readl(wdt->base + PDC_WD_CONFIG);
> +       val &= ~(PDC_WD_CONFIG_DELAY_MASK << PDC_WD_CONFIG_DELAY_SHIFT);
> +       val |= (new_timeout + wdt->min_delay);

This should be shifted by PDC_WD_CONFIG_DELAY_SHIFT.

> +static struct watchdog_info pdc_wdt_info = {
> +       .options                = WDIOF_SETTIMEOUT |
> +                                 WDIOF_KEEPALIVEPING |
> +                                 WDIOF_MAGICCLOSE,
> +       .identity = "PDC Watchdog",

Maybe "IMG PDC Watchdog"?

> +static int pdc_wdt_probe(struct platform_device *pdev)
> +{
> +       int ret, val;
> +       struct resource *res;
> +       struct pdc_wdt_dev *pdc_wdt;
> +
> +       pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
> +       if (!pdc_wdt)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pdc_wdt->base))
> +               return PTR_ERR(pdc_wdt->base);
> +
> +       pdc_wdt->sys_clk = devm_clk_get(&pdev->dev, "sys");
> +       if (IS_ERR(pdc_wdt->sys_clk)) {
> +               dev_err(&pdev->dev, "failed to get the sys clock.\n");
> +               ret = PTR_ERR(pdc_wdt->wdt_clk);
> +               goto out_wdt;
> +       }
> +
> +       spin_lock_init(&pdc_wdt->lock);
> +
> +       pdc_wdt->wdt_clk = devm_clk_get(&pdev->dev, "wdt");
> +       if (IS_ERR(pdc_wdt->wdt_clk)) {
> +               dev_err(&pdev->dev, "failed to get the wdt clock.\n");
> +               ret = PTR_ERR(pdc_wdt->wdt_clk);
> +               goto out_wdt;
> +       }
> +
> +       ret = clk_prepare_enable(pdc_wdt->sys_clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "could not prepare or enable sys clock.\n");
> +               goto out_wdt;
> +       }
> +
> +       ret = clk_prepare_enable(pdc_wdt->wdt_clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "could not prepare or enable wdt clock.\n");
> +               goto disable_sys_clk;
> +       }
> +       /* We use the clock rate to calculate the max timeout */
> +       pdc_wdt->clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
> +       if (pdc_wdt->clk_rate < 1 || pdc_wdt->clk_rate > PDC_WD_MAX_CLK_RATE) {
> +               dev_err(&pdev->dev, "invalid clock rate\n");
> +               ret = -EINVAL;
> +               goto disable_wdt_clk;
> +       }

Does a maximum rate really need to be enforced?  I know rates greater
than 50Mhz aren't recommended, but I believe you can still configure
the clock controller to do so.
The check for a clock rate of 0 is fine - that would indicate that
clk_get_rate() failed to get the rate.

> +       if (order_base_2(pdc_wdt->clk_rate)  == 0)
> +               pdc_wdt->min_delay = 0;
> +       else
> +               pdc_wdt->min_delay = order_base_2(pdc_wdt->clk_rate) - 1;
> +
> +       pdc_wdt->wdt_dev.info = &pdc_wdt_info;
> +       pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
> +       pdc_wdt->wdt_dev.min_timeout = PDC_WD_MIN_TIMEOUT;
> +       pdc_wdt->wdt_dev.max_timeout =
> +                               (1 << (PDC_WD_MAX_DELAY - pdc_wdt->min_delay));
> +       pdc_wdt->wdt_dev.parent = &pdev->dev;
> +       pdc_wdt->dev = &pdev->dev;
> +
> +       ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev->dev);
> +       if (ret < 0)
> +               pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
> +
> +       pdc_wdt_stop(&pdc_wdt->wdt_dev);
> +       /* Set timeouts before userland has a chance to start the timer */
> +       pdc_wdt_set_timeout(&pdc_wdt->wdt_dev, pdc_wdt->wdt_dev.timeout);

The stop() is fine, but I don't think it's necessary to set the timeout.

> +static int pdc_wdt_remove(struct platform_device *pdev)
> +{
> +       struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
> +
> +       pdc_wdt_shutdown(pdev);

Just call pdc_wdt_stop() directly.
