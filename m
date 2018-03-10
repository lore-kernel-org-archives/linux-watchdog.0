Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33394 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeCJCrv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Mar 2018 21:47:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id s206so5717913wme.0
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 18:47:50 -0800 (PST)
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com. [74.125.82.52])
        by smtp.gmail.com with ESMTPSA id t16sm1469857edt.68.2018.03.09.18.47.48
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 18:47:49 -0800 (PST)
Received: by mail-wm0-f52.google.com with SMTP id z9so6984820wmb.3
        for <linux-watchdog@vger.kernel.org>; Fri, 09 Mar 2018 18:47:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180310024431.160195-1-briannorris@chromium.org>
References: <20180310024431.160195-1-briannorris@chromium.org>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 9 Mar 2018 18:47:47 -0800
Message-ID: <CA+ASDXPmh7Ng8x1dnezs5a9zSdvVVTa4W+KQYVLDWWoKW0S=-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: dw: RMW the control register
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

+ linux-rockchip (probably should have included in the first place)

On Fri, Mar 9, 2018 at 6:44 PM, Brian Norris <briannorris@chromium.org> wrote:
> RK3399 has rst_pulse_length in CONTROL_REG[4:2], determining the length
> of pulse to issue for system reset. We shouldn't clobber this value,
> because that might make the system reset ineffective. On RK3399, we're
> seeing that a value of 000b (meaning 2 cycles) yields an unreliable
> (partial?) reset, and so we only fully reset after the watchdog fires a
> second time. If we retain the system default (010b, or 8 clock cycles),
> then the watchdog reset is much more reliable.
>
> Read-modify-write retains the system value and improves reset
> reliability.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/watchdog/dw_wdt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index c2f4ff516230..6925d3e6c6b3 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -34,6 +34,7 @@
>
>  #define WDOG_CONTROL_REG_OFFSET                    0x00
>  #define WDOG_CONTROL_REG_WDT_EN_MASK       0x01
> +#define WDOG_CONTROL_REG_RESP_MODE_MASK            0x02
>  #define WDOG_TIMEOUT_RANGE_REG_OFFSET      0x04
>  #define WDOG_TIMEOUT_RANGE_TOPINIT_SHIFT    4
>  #define WDOG_CURRENT_COUNT_REG_OFFSET      0x08
> @@ -124,11 +125,16 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
>  static int dw_wdt_start(struct watchdog_device *wdd)
>  {
>         struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
> +       u32 val;
>
>         dw_wdt_set_timeout(wdd, wdd->timeout);
>
> -       writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> -              dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +       val = readl(dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
> +       /* Disable interrupt mode; always perform system reset. */
> +       val &= ~WDOG_CONTROL_REG_RESP_MODE_MASK;
> +       /* Enable watchdog. */
> +       val |= WDOG_CONTROL_REG_WDT_EN_MASK;
> +       writel(val, dw_wdt->regs + WDOG_CONTROL_REG_OFFSET);
>
>         return 0;
>  }
> --
> 2.16.2.660.g709887971b-goog
>
