Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34725 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162355AbdDUSYu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Apr 2017 14:24:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170417192942.32219-2-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-2-hauke@hauke-m.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 21 Apr 2017 20:17:38 +0200
Message-ID: <CAFBinCBjnDz3oSUVOLKR0ku-TvrCHDNEgGX6NzGnkSQCk_yPLA@mail.gmail.com>
Subject: Re: [PATCH 01/13] MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This allows populating syscon devices which are using "simple-mfd"
> instead of "simple-bus".
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/mips/lantiq/prom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 96773bed8a8a..72cc12f1b6a5 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -117,7 +117,8 @@ void __init prom_init(void)
>
>  int __init plat_of_setup(void)
>  {
> -       return __dt_register_buses(soc_info.compatible, "simple-bus");
> +       return of_platform_populate(NULL, of_default_bus_match_table, NULL,
> +                                   NULL);
>  }
>
>  arch_initcall(plat_of_setup);
> --
> 2.11.0
>
