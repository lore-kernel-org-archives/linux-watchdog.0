Return-Path: <SRS0=szdd=BW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE75AC433DF
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Aug 2020 07:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DB820786
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Aug 2020 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597219059;
	bh=GD6v7CB5dursMy1LFpKqdYSAC+0NBpdsVgzB6336OsY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=c5HVHmMyv0p69oNX2SLqspeUlmPuOoSge/kqjjbZDZBv7Cws5lXz7N+Hnf78W4pK4
	 LE0OAIsf4j9eupn9vvpXVFI3D2SFQR5UnJmYKL8G7F8B4NU4+As1lXWZyvehPCh74i
	 282Tehj7XkGVX8osCWxDF9zoBBxuOWceVLq04+lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHLH5j (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgHLH5i (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Aug 2020 03:57:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B28206B5;
        Wed, 12 Aug 2020 07:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597219058;
        bh=GD6v7CB5dursMy1LFpKqdYSAC+0NBpdsVgzB6336OsY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gZ5jkX3CKM34ZTH++hII1uQw30e8+MyMAKBf/92qWAPFNOB5EDsGGpwuXXUzUoVYW
         BIntS+buE/cYprrFrlXTkPTipWz6w6D8cuPgvaJsI+4GBwNCLTlbYcOE8cxL8hrqrs
         IhPAVxZVSfXakucpn21EgTtcV7/DYAAjgiQ5+Ui8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200804192654.12783-3-krzk@kernel.org>
References: <20200804192654.12783-1-krzk@kernel.org> <20200804192654.12783-3-krzk@kernel.org>
Subject: Re: [PATCH v2 02/13] clk: samsung: s3c24xx: declare s3c24xx_common_clk_init() in shared header
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
Date:   Wed, 12 Aug 2020 00:57:37 -0700
Message-ID: <159721905719.33733.2654708598275375464@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-08-04 12:26:43)
> The s3c2410_common_clk_init() and others are defined and used by the
> clk-s3c24xx driver and also used in the mach-s3c24xx machine code.  Move
> the declaration to a header to fix W=3D1 build warnings:
>=20
>     drivers/clk/samsung/clk-s3c2410.c:320:13: warning: no previous protot=
ype for 's3c2410_common_clk_init' [-Wmissing-prototypes]
>       320 | void __init s3c2410_common_clk_init(struct device_node *np, u=
nsigned long xti_f,
>     drivers/clk/samsung/clk-s3c2412.c:205:13: warning: no previous protot=
ype for 's3c2412_common_clk_init' [-Wmissing-prototypes]
>       205 | void __init s3c2412_common_clk_init(struct device_node *np, u=
nsigned long xti_f,
>     drivers/clk/samsung/clk-s3c2443.c:341:13: warning: no previous protot=
ype for 's3c2443_common_clk_init' [-Wmissing-prototypes]
>       341 | void __init s3c2443_common_clk_init(struct device_node *np, u=
nsigned long xti_f,
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
