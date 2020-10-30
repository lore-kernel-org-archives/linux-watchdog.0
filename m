Return-Path: <SRS0=+3Tt=EF=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60151C2D0A3
	for <linux-watchdog@archiver.kernel.org>; Fri, 30 Oct 2020 00:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034EB2076D
	for <linux-watchdog@archiver.kernel.org>; Fri, 30 Oct 2020 00:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604018292;
	bh=wynUc563K1gkMWzfMCzDYCWs+7V4DOteyd7YvZinwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N1HlXLgW7IFaCdaDaSRD8WvE5wuKWUFdVUnJ5l9r7hPuxen8az0+MzIgLKMHFqSu6
	 5nYuS1uG6qQ4OiEq5X2CRfzGwyLs89DY8ikbDGvvFMzIMgAhqpSkTVNEKSmVTls2/Q
	 wED7IV1RlJSTsfWGpea6MdnUB84CS72256QpSWMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJ3AiL (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 29 Oct 2020 20:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3AiL (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Oct 2020 20:38:11 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A1B206CB;
        Fri, 30 Oct 2020 00:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604018290;
        bh=wynUc563K1gkMWzfMCzDYCWs+7V4DOteyd7YvZinwf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIA3pp9FjIUdb0wOaU1x0BsWDmF7Xo4CJ59QOAnUuggK+nAIzRijBOIfXtNcRFTnP
         wVgwvulrLRH3tm/0uZ0jfq5rJqgWAthWDULHXYhuBdxgsJ+D+hD2c7PxcxGYuE7g5F
         PehqsMnatp0GXojmSG48ZApwp8EFTFr9MKy9oeFU=
Date:   Fri, 30 Oct 2020 08:38:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: fsl-imx: document NXP
 compatibles
Message-ID: <20201030003803.GZ28755@dragon>
References: <20201029162133.81016-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162133.81016-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, Oct 29, 2020 at 05:21:32PM +0100, Krzysztof Kozlowski wrote:
> Document all ARMv5, ARMv6, ARMv7 and ARMv8 NXP (i.MX, Layerscape)
> compatibles used in DTSes (even though driver binds only to
> fsl,imx21-wdt) to fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/imx53-qsb.dt.yaml: gpio@53fe0000: compatible:
>     ['fsl,imx53-gpio', 'fsl,imx35-gpio'] is not valid under any of the given schemas
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks.
