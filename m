Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47594 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965451AbcKKC6U (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 10 Nov 2016 21:58:20 -0500
Subject: Re: [PATCH] watchdog: jz4740: Fix modular build
To: Stephen Boyd <sboyd@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>
References: <20161111000220.12989-1-sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d3ca4658-cb79-5aba-1bc8-f2059ec8d4c7@roeck-us.net>
Date: Thu, 10 Nov 2016 18:58:17 -0800
MIME-Version: 1.0
In-Reply-To: <20161111000220.12989-1-sboyd@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 11/10/2016 04:02 PM, Stephen Boyd wrote:
> Compiling this driver as a module causes a build error because a
> semicolon is missing after MODULE_DEVICE_TABLE. Add it.
>
>   CC [M]  drivers/watchdog/jz4740_wdt.o
> drivers/watchdog/jz4740_wdt.c:154:1: error: expected =E2=80=98,=E2=80=99=
 or =E2=80=98;=E2=80=99 before =E2=80=98static=E2=80=99
> drivers/watchdog/jz4740_wdt.c:218:11: error: =E2=80=98jz4740_wdt_probe=E2=
=80=99 undeclared here (not in a function)
>
> Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Oops :-(

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wd=
t.c
> index c8d51ddb26d5..20627f22baf6 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -148,7 +148,7 @@ static const struct of_device_id jz4740_wdt_of_matc=
hes[] =3D {
>  	{ .compatible =3D "ingenic,jz4740-watchdog", },
>  	{ /* sentinel */ }
>  };
> -MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches)
> +MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
>  #endif
>
>  static int jz4740_wdt_probe(struct platform_device *pdev)
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
