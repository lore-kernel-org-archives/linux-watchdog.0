Return-Path: <lee.jones@linaro.org>
Return-path: <lee.jones@linaro.org>
Date: Tue, 24 Oct 2017 11:24:31 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, support.opensource@diasemi.com,
	wim@iguana.be, linux@roeck-us.net, kernel@pengutronix.de,
	Stefan Christ <s.christ@phytec.de>
Subject: Re: [PATCH 2/6] mfd: da9062: make register CONFIG_I writable
Message-ID: <20171024102431.n5isgkgi4ltcynqz@dell>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
 <20171017153027.24665-3-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171017153027.24665-3-m.grzeschik@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, 17 Oct 2017, Michael Grzeschik wrote:

> From: Stefan Christ <s.christ@phytec.de>
> 
> Make the config register CONFIG_I writable to change the watchdog mode.
> The datasheet does not mention exactly whether these registers should be
> read-only or writeable. But writing to those registers works at runtime.
> Only on reset they are reseted.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> ---
>  drivers/mfd/da9062-core.c | 4 ++++
>  1 file changed, 4 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
