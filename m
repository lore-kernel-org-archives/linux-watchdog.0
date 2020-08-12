Return-Path: <SRS0=szdd=BW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639DC433E1
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Aug 2020 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F9220786
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Aug 2020 07:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597219113;
	bh=Sgo1Y1bLVQIdO5mGgCuvsUCuF/NfKTBefSuLxPm4OKo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Dqx1QvqQJp5pruytQ2uy5xfD90tQT2C4+jShZTLcQiUMgZKo48slSJKJVvXdOBHeW
	 xSVsA64OQaitV1YvTeZPcciLhDc5BmCQz2A91RMXdTdN3peGKL+zxVqpIxcP1Y/HDD
	 kleR3nNIazyjbI11IHa3eNV3ACQQXj3EVINYGDlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHLH6c (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgHLH6c (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Aug 2020 03:58:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C07C206B5;
        Wed, 12 Aug 2020 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597219111;
        bh=Sgo1Y1bLVQIdO5mGgCuvsUCuF/NfKTBefSuLxPm4OKo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Bi1ru2/BtfsbYfnzqSLgLpv596WJ0MJOeOgLyqvHex6GmYPJraWp1EWCVl7exVJsW
         8WarWtvO5ls0wgeVW1X142OnmYYO9x9D4/Yf+qgHsP2DLQeFfuk379pnOerAhmfU0D
         fsqNxwe0cE1c9CMe92eS5Bm06xBS6vIQxmu8DqIA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200804192654.12783-4-krzk@kernel.org>
References: <20200804192654.12783-1-krzk@kernel.org> <20200804192654.12783-4-krzk@kernel.org>
Subject: Re: [PATCH v2 03/13] ARM: s3c64xx: include header to fix -Wmissing-prototypes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sergio Prado <sergio.prado@e-labworks.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Cedric Roux <sed@free.fr>, Lihua Yao <ylhuajnu@outlook.com>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-watchdog@vger.kernel.org, patches@opensource.cirrus.com
Date:   Wed, 12 Aug 2020 00:58:30 -0700
Message-ID: <159721911034.33733.3901443482423678500@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-08-04 12:26:44)
> Include the spi-s3c64xx.h header to fix W=3D1 build warning:
>=20
>     arch/arm/mach-s3c64xx/setup-spi.c:11:5: warning:
>         no previous prototype for 's3c64xx_spi0_cfg_gpio' [-Wmissing-prot=
otypes]
>        11 | int s3c64xx_spi0_cfg_gpio(void)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
