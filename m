Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50486 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab3I0QxY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 12:53:24 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so2232814oag.19
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Sep 2013 09:53:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380276986-24131-4-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
	<1380276986-24131-4-git-send-email-l.krishna@samsung.com>
Date: Fri, 27 Sep 2013 22:23:23 +0530
Message-ID: <CAK9yfHxBnj39w=YrBw-PyT-Anpprx8Zn4d0O6BPp__qNGH4Xhg@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to
 read PMU registers adresses
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	Tomasz Figa <t.figa@samsung.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 27 September 2013 15:46, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
> This patch parses the watchdog node to read pmu wdt sys registers addresses
> and do mask/unmask enable/disable of WDT in probe and s2r scenarios.
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |   24 ++++-
>  drivers/watchdog/s3c2410_wdt.c                     |   94 ++++++++++++++++++--
>  2 files changed, 108 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> index 2aa486c..f78b802 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -5,10 +5,30 @@ after a preset amount of time during which the WDT reset event has not
>  occurred.
>
>  Required properties:
> -- compatible : should be "samsung,s3c2410-wdt"
> +- compatible : should be "samsung,s3c2410-wdt" or "samsung,s3c5250-wdt"

It would also be helpful to mention the SoCs along with the compatibles strings.

>  - reg : base physical address of the controller and length of memory mapped
> -       region.
> +       region and additional (addresses and length of memory mapped regions
> +       of) PMU registers for masking/unmasking WDT only in case of Exynos5250 and 5420.
>  - interrupts : interrupt number to the cpu.
> +- reset-mask-bit: bit number in the PMU registers to program mask/unmask WDT (required only
> +       in case of Exynos5250 and 5420).
>
>  Optional properties:
>  - timeout-sec : contains the watchdog timeout in seconds.
> +
> +Examples:
> +
> +watchdog {

watchdog@101D0000

> +       compatible = "samsung,s3c2410-wdt";
> +       reg = <0x101D0000 0x100>;
> +       interrupts = <0 42 0>;
> +       status = "disabled";
> +};
> +
> +watchdog {

ditto

> +        compatible = "samsung,s3c5250-wdt";
> +        reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;

-- 
With warm regards,
Sachin
