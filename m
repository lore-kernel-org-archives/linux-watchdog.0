Return-Path: <SRS0=tGrw=QZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FDC10F06
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Feb 2019 01:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16F218D3
	for <linux-watchdog@archiver.kernel.org>; Mon, 18 Feb 2019 01:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550453233;
	bh=O8Sxd2LgJPTNXcUJ5pZxabl6dwXdm9PmZWIAKrG3hSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iYMoDZFi1LQqhjhb4iN/QR/R5nKjdvMeNlfuPrxVORJalRPZud9KTMS4CqWjIlDOM
	 CjiPYybomM7h9MQfQAsqtcfme6TrnjY090MXMeSfYSZ8tJ2zguoLp6Tx+M4lr2PvIm
	 F4rmYud3+KrVM2zPUdgn9GQXXOdR+/Asan1UcDqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfBRB1M (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 17 Feb 2019 20:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfBRB1M (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 17 Feb 2019 20:27:12 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7827420855;
        Mon, 18 Feb 2019 01:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550453231;
        bh=O8Sxd2LgJPTNXcUJ5pZxabl6dwXdm9PmZWIAKrG3hSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggpqNxeAnjWoVQyyfWLx8KDTfGz5V2nyuM19AxTPBEa+ewPPmc5GI3dEY+bwI6WFf
         DIs8ivuaFy+QY3+NzuAd/bRs07kJjGbyP5hgdXRJL5R20dCjSeCraVnL252xnaStvo
         UUQsxI/L/C5O+/7vX+fooegLmJhWjRyEmdvKuiec=
Date:   Mon, 18 Feb 2019 09:26:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 4/4] arm64: dts: freescale: imx8qxp: add watchdog support
Message-ID: <20190218012637.GC6262@dragon>
References: <1550144346-1187-1-git-send-email-Anson.Huang@nxp.com>
 <1550144346-1187-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550144346-1187-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, Feb 14, 2019 at 11:45:14AM +0000, Anson Huang wrote:
> Add i.MX8QXP system controller watchdog support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Note: this patch is based on my thermal patch series: https://patchwork.kernel.org/patch/10800699/
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 1bf0e3b..087ba41 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -155,6 +155,10 @@
>  			tsens-num = <1>;
>  			#thermal-sensor-cells = <1>;
>  		};
> +
> +		wdog: wdog {

watchdog for node name.

Shawn

> +			compatible = "fsl,imx8qxp-sc-wdt";
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.7.4
> 
