Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from condef-06.nifty.com ([202.248.20.71]:55380 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdGEKfF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Jul 2017 06:35:05 -0400
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-06.nifty.com with ESMTP id v65AQObg027712
        for <linux-watchdog@vger.kernel.org>; Wed, 5 Jul 2017 19:26:24 +0900
MIME-Version: 1.0
In-Reply-To: <000001d2f576$5f011c20$1d035460$@socionext.com>
References: <1497426825-25450-1-git-send-email-hayashibara.keiji@socionext.com>
 <000001d2f576$5f011c20$1d035460$@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 5 Jul 2017 19:26:05 +0900
Message-ID: <CAK7LNAR7kbXPFGywpnWRCFibwp350kmZ7CpSUO6GTFG3pxG=zw@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] add UniPhier watchdog support
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc: wim@iguana.be, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        =?UTF-8?B?SGF5YXNoaSwgS3VuaWhpa28v5p6XIOmCpuW9pg==?=
        <hayashi.kunihiko@socionext.com>,
        =?UTF-8?B?T3dhZGEsIEtpeW9zaGkv5aSn5ZKM55SwIOa4heW/lw==?=
        <owada.kiyoshi@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2017-07-05 19:06 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> Hi Guenter,
>
> Let me confirm if I got it.
>
> I guess that this series finished the review.
> Could you tell me the current state of this series?


I will pick up 3/3.  (It should have been sent to ARM-SoC ML, though.)

I had sent my PRs for v4.13 before Rob acked the DT binding.
Please look forward to v4.14.

-- 
Best Regards
Masahiro Yamada
