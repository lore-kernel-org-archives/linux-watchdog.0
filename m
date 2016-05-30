Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37093 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161271AbcE3Nv2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 May 2016 09:51:28 -0400
Date: Mon, 30 May 2016 15:51:25 +0200
From: Carlo Caione <carlo@caione.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] watchdog: Add Meson GXBB Watchdog Driver
Message-ID: <20160530135125.GB16188@mephisto>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
 <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1464614948-28247-2-git-send-email-narmstrong@baylibre.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 30/05/16 15:29, Neil Armstrong wrote:
> Add watchdog specific driver for Amlogic Meson GXBB SoC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> +

> +#define GXBB_WDT_CTRL1_REG			0x4
...
> +#define GXBB_WDT_CTRL_EE_RESET_NOW		BIT(26)
...
> +#define GXBB_WDT_CTRL_IRQ_EN			BIT(23)
...
> +#define GXBB_WDT_CTRL_XTAL_SEL			(0)
...
> +#define GXBB_WDT_CTRL_CLK81_SEL			BIT(19)
...
> +#define GXBB_WDT_CTRL1_GPIO_PULSE		BIT(17)
...
> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_0		BIT(16)
> +#define GXBB_WDT_CTRL1_GPIO_POL_RESET_1		(0)
> +#define GXBB_WDT_CTRL1_GPIO_PULSE_CNT		(BIT(16) - 1)

nit: all these defines are not used at all in the driver. You can remove them

Thanks!


-- 
Carlo Caione
