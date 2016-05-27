Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36947 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbcE0IWW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 May 2016 04:22:22 -0400
Received: by mail-wm0-f45.google.com with SMTP id z87so127413416wmh.0
        for <linux-watchdog@vger.kernel.org>; Fri, 27 May 2016 01:22:21 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
To: Carlo Caione <carlo@caione.org>
References: <1464249112-13658-1-git-send-email-narmstrong@baylibre.com>
 <1464249112-13658-2-git-send-email-narmstrong@baylibre.com>
 <20160526100655.GB14703@mephisto>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <574803AF.5020409@baylibre.com>
Date: Fri, 27 May 2016 10:22:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160526100655.GB14703@mephisto>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/26/2016 12:06 PM, Carlo Caione wrote:
> On 26/05/16 09:51, Neil Armstrong wrote:
>> Add watchdog specific driver for Amlogic Meson GXBB SoC.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> +
> 
> [...]
>> +#define DEFAULT_TIMEOUT	10	/* seconds */
>> +
>> +#define GXBB_WDT_CTRL_REG	0x0
>> +#define GXBB_WDT_CTRL1_REG	0x4
>> +#define GXBB_WDT_TCNT_REG	0x8
>> +#define GXBB_WDT_RSET_REG	0xc
>> +
>> +#define GXBB_WDT_CTRL_EE_RESET_NOW	BIT(26)
>> +
>> +#define GXBB_WDT_CTRL_CLKDIV_EN	BIT(25)
>> +#define GXBB_WDT_CTRL_CLK_EN	BIT(24)
>> +#define GXBB_WDT_CTRL_IRQ_EN	BIT(23)
>> +#define GXBB_WDT_CTRL_EE_RESET	BIT(21)
>> +#define GXBB_WDT_CTRL_XTAL_SEL	(0)
>> +#define GXBB_WDT_CTRL_CLK81_SEL	BIT(19)
>> +#define GXBB_WDT_CTRL_EN	BIT(18)
>> +#define GXBB_WDT_CTRL_DIV_MASK	(BIT(18)-1)
>> +
>> +#define GXBB_WDT_CTRL1_GPIO_PULSE	BIT(17)
>> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_0	BIT(16)
>> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_1	(0)
>> +#define GXBB_WDT_CTRL1_GPIO_PULSE_CNT	(BIT(16)-1)
>> +
>> +#define GXBB_WDT_TCNT_SETUP_MASK	(BIT(16)-1)
>> +#define GXBB_WDT_TCNT_CNT_SHIFT		16
> 
> Indentation
> 
> [...]
>> +int meson_gxbb_wdt_set_timeout(struct watchdog_device *wdt_dev,
>> +			       unsigned int timeout)
>> +{
>> +	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
>> +
>> +	if (watchdog_active(wdt_dev))
>> +		meson_gxbb_wdt_stop(wdt_dev);
>> +
>> +	meson_gxbb_wdt_ping(wdt_dev);
>> +
>> +	writel(timeout*1000, data->reg_base + GXBB_WDT_TCNT_REG);
> 
> nit: spaces around "*"
> 
> [...]
>> +	data->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(data->clk))
>> +		return PTR_ERR(data->clk);
>> +
>> +	clk_prepare_enable(data->clk);
> 
> Do we need to merge the clock controller driver before this?

It's not necessary, currently it only selects the xtal source, so it's works with the current upstream architecture.

Neil

> 
> Cheers,
> 

