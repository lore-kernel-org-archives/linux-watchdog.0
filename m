Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from condef-10.nifty.com ([202.248.20.75]:36697 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdFHCSB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Jun 2017 22:18:01 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-10.nifty.com with ESMTP id v582B8UX031876
        for <linux-watchdog@vger.kernel.org>; Thu, 8 Jun 2017 11:11:08 +0900
MIME-Version: 1.0
In-Reply-To: <1496740294-12653-2-git-send-email-hayashibara.keiji@socionext.com>
References: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
 <1496740294-12653-2-git-send-email-hayashibara.keiji@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Jun 2017 11:11:00 +0900
Message-ID: <CAK7LNATMRPW3PYU-fX+biRdez-mgkUKRbVi+w+dBNb3szOuXdw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] devicetree: add UniPhier WDT devicetree bindings documentation
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
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hayashibara-san


Just nitpicking.


2017-06-06 18:11 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> Add uniphier-wdt bindings documentation.
>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>


Maybe "dt-bindings: watchdog: ..." for the subject.

This seems what Rob prefers.

For example,
https://patchwork.kernel.org/patch/9606365/



> ---
>  .../devicetree/bindings/watchdog/uniphier-wdt.txt    | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> new file mode 100644
> index 0000000..a59d1ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> @@ -0,0 +1,20 @@
> +UniPhier watchdog timer controller
> +
> +This UniPhier watchdog timer controller must be under sysctrl compatible node.

Do you mean "syscon compatible" ?


> +Required properties:
> +- compatible: should be "socionext,uniphier-wdt"
> +
> +Example:
> +
> +       sysctrl@61840000 {
> +               compatible = "socionext,uniphier-ld11-sysctrl",
> +                            "simple-mfd", "syscon";
> +               reg = <0x61840000 0x4000>;
> +
> +               sys_wdt: watchdog {
> +                       compatible = "socionext,uniphier-wdt";
> +               }

Could you remove the "sys_dwt: " label?
I'd like the example matched with actual DT files.


Thanks.


> +               other nodes ...
> +       };
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
