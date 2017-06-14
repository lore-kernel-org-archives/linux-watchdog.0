Return-Path: <yamada.masahiro@socionext.com>
Return-path: <yamada.masahiro@socionext.com>
MIME-Version: 1.0
In-Reply-To: <1497316499-22254-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1497316499-22254-1-git-send-email-hayashibara.keiji@socionext.com>
 <1497316499-22254-3-git-send-email-hayashibara.keiji@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Jun 2017 12:07:31 +0900
Message-ID: <CAK7LNASq9MxUwDrNeRrg_eNkJbXR2J-9hHKGZe6-DtioO3p4cQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] watchdog: uniphier: add UniPhier watchdog driver
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc: wim@iguana.be, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Kiyoshi Owada <owada.kiyoshi@socionext.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hayashibara-san


2017-06-13 10:14 GMT+09:00 Keiji Hayashibara
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 52a70ee..2a9d9a6 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -744,6 +744,17 @@ config ZX2967_WATCHDOG
>           To compile this driver as a module, choose M here: the
>           module will be called zx2967_wdt.
>
> +config UNIPHIER_WATCHDOG
> +       tristate "UniPhier watchdog support"
> +       depends on ARCH_UNIPHIER || COMPILE_TEST

This driver relies on syscon_node_to_regmap().
Could you also add "depends on OF && MFD_SYSCON" ?




> +       select WATCHDOG_CORE
> +       help
> +         Say Y here to include support watchdog timer embedded
> +         into the UniPhier system.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called uniphier_wdt.
> +



-- 
Best Regards
Masahiro Yamada
