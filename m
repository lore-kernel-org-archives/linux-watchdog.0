Return-Path: <SRS0=BU60=BI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE459C433DF
	for <linux-watchdog@archiver.kernel.org>; Wed, 29 Jul 2020 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F632075D
	for <linux-watchdog@archiver.kernel.org>; Wed, 29 Jul 2020 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596051765;
	bh=gvBRTtVpHZ8XIvcKDGM0x4zcwd8P01/WaBAWg80jZBw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=iHL06WSBNAh5vZJOLAUcQGtj/A0bpTvAI1JgcqCc5Z9DUwfUizgwY3EG6Iwly9kWV
	 osYV0xtIyjzjQzwxBjua+I8wP9FmJRmO3gLfRjXGmHOu9lwrz/6lb+oqo+wWpBBLdd
	 7QdgnzlUujCxbcvb+HkTtacPOt1oz680QkfgtyuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG2Tmp (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2Tmp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Jul 2020 15:42:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB73206D4;
        Wed, 29 Jul 2020 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596051764;
        bh=gvBRTtVpHZ8XIvcKDGM0x4zcwd8P01/WaBAWg80jZBw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q3rbrJ5UWU7IB86jpP3xYz3NzwStYMAInjwyCcx0oFkBNTOfQw5tV6Bu8sB9s/kMz
         0RhPokOz+E4HIx3nkCkZ7qMHzmdBHFPJx+ECVeL17Aa6IOZybPSnPYncV5IrRo5zpX
         A8m7Ojdd0nAIHQKdxmLVU+hRLZlJ5n/o+GCRrMDo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200729160942.28867-2-krzk@kernel.org>
References: <20200729160942.28867-1-krzk@kernel.org> <20200729160942.28867-2-krzk@kernel.org>
Subject: Re: [PATCH 1/7] clk: samsung: s3c64xx: Declare s3c64xx_clk_init() in shared header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sergio Prado <sergio.prado@e-labworks.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Cedric Roux <sed@free.fr>, Lihua Yao <ylhuajnu@outlook.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Vincent Sanders <vince@simtec.co.uk>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-watchdog@vger.kernel.org, patches@opensource.cirrus.com
Date:   Wed, 29 Jul 2020 12:42:43 -0700
Message-ID: <159605176358.1360974.7715120460121088439@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-07-29 09:09:36)
> diff --git a/include/linux/clk/samsung.h b/include/linux/clk/samsung.h
> new file mode 100644
> index 000000000000..b6b253c46c22
> --- /dev/null
> +++ b/include/linux/clk/samsung.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> + */
> +
> +#ifndef __LINUX_CLK_SAMSUNG_H_
> +#define __LINUX_CLK_SAMSUNG_H_
> +
> +#ifdef CONFIG_ARCH_S3C64XX
> +void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_=
f,

Don't use __init in header files. It doesn't do anything.

> +                            unsigned long xusbxti_f, bool s3c6400,
> +                            void __iomem *base);
> +#else
> +static inline void __init s3c64xx_clk_init(struct device_node *np,

Forward declare struct device_node;

> +                                          unsigned long xtal_f,
> +                                          unsigned long xusbxti_f,
> +                                          bool s3c6400,
> +                                          void __iomem *base) { }

Include <linux/compiler.h> (or compiler_types.h) for __iomem define
please.

> +#endif /* CONFIG_ARCH_S3C64XX */
> +
> +#endif /* __LINUX_CLK_SAMSUNG_H_ */
