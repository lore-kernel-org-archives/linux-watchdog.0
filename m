Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49834 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdAYCnc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 24 Jan 2017 21:43:32 -0500
Subject: Re: [PATCH v5 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
To: Baoyou Xie <baoyou.xie@linaro.org>
References: <1485248322-24299-1-git-send-email-baoyou.xie@linaro.org>
 <1485248322-24299-3-git-send-email-baoyou.xie@linaro.org>
 <35dcd00f-a4bd-a313-0d6f-932a3f5888f0@roeck-us.net>
 <CA+DQWky4---=gRipAR=NqajvwYV2QQQWbztTpPJS5oaL4D6QaQ@mail.gmail.com>
Cc: Jun Nie <jun.nie@linaro.org>, wim@iguana.be,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn,
        wang.qiang01@zte.com.cn
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <74bfcbb3-a9ce-8228-77d3-db4defa79df5@roeck-us.net>
Date: Tue, 24 Jan 2017 18:43:21 -0800
MIME-Version: 1.0
In-Reply-To: <CA+DQWky4---=gRipAR=NqajvwYV2QQQWbztTpPJS5oaL4D6QaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/24/2017 06:16 PM, Baoyou Xie wrote:
>
[ ... ]
>         +
>         +       ret = of_parse_phandle_with_fixed_args(dev->of_node,
>         +                       "zte,wdt-reset-sysctrl", 3, 0, &out_args);
>         +       if (ret)
>         +               return;
>         +
>         +       offset = out_args.args[0];
>         +       config = out_args.args[1];
>         +       mask = out_args.args[2];
>         +
>         +       regmap = syscon_node_to_regmap(out_args.np <http://out_args.np>);
>         +       if (IS_ERR(regmap))
>         +               return;
>         +
>         +       regmap_update_bits(regmap, offset, mask, config);
>
>
>     Another comment suggested adding
>             of_node_put(out_args.np <http://out_args.np>);
>     here.
>
>
> is it really? most of the driver that call this function don't call of_node_put. but it seems harmless to call of_node_put.
>
>
Even if everyone else is doing things wrong, that doesn't mean
that you should do the same, nor is it a good idea to use it
as argument.

Guenter

