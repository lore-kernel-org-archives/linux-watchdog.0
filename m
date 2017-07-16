Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from condef-08.nifty.com ([202.248.20.73]:37559 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdGPD24 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 15 Jul 2017 23:28:56 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-08.nifty.com with ESMTP id v6G3QtR3012624
        for <linux-watchdog@vger.kernel.org>; Sun, 16 Jul 2017 12:26:55 +0900
MIME-Version: 1.0
In-Reply-To: <1497426825-25450-4-git-send-email-hayashibara.keiji@socionext.com>
References: <1497426825-25450-1-git-send-email-hayashibara.keiji@socionext.com>
 <1497426825-25450-4-git-send-email-hayashibara.keiji@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 16 Jul 2017 12:26:47 +0900
Message-ID: <CAK7LNATdoA6kUzwepoVz3yV_8nZVGd4156uatCSzsL+426s2Ug@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] arm64: dts: uniphier: add watchdog node for LD11
 and LD20
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

2017-06-14 16:53 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> Add nodes of watchdog timer for UniPhier LD11 and LD20 SoC.
> The watchdog timer is included in sysctrl.
>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>

Applied to linux-uniphier. Thanks!

-- 
Best Regards
Masahiro Yamada
