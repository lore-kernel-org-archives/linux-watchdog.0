Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from condef-06.nifty.com ([202.248.20.71]:53938 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdFHCVA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Jun 2017 22:21:00 -0400
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-06.nifty.com with ESMTP id v5829pMn030780
        for <linux-watchdog@vger.kernel.org>; Thu, 8 Jun 2017 11:09:51 +0900
MIME-Version: 1.0
In-Reply-To: <1496740294-12653-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1496740294-12653-1-git-send-email-hayashibara.keiji@socionext.com>
 <1496740294-12653-3-git-send-email-hayashibara.keiji@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Jun 2017 11:09:41 +0900
Message-ID: <CAK7LNARQb3r7fvytCZ86G3iQBpWhu7-06DY9gcJswjH0heUonA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] watchdog: uniphier: add UniPhier watchdog driver
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

Just a nit.


> +
> +#include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/watchdog.h>
> +#include <linux/bitops.h>

I think you should have added <linux/bitops.h> on the top
to keep the includes alphabetically sorted.


-- 
Best Regards
Masahiro Yamada
