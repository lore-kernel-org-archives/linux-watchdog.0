Return-Path: <SRS0=q9YU=EE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF042C4363A
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771CD2087E
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603982375;
	bh=UxKTrOdbQX8WwcdQeFEJqz4r+f0/JB4wMaev8w7Ad88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hRaGHjGzc6mhv9lC83A8sqSVW+hQ1+cblSs5KOhgFAKKAbxo6bZLape3ijHWkk61L
	 4ZeriN3W75vTxs4A6UQAotCCG5wji1tgOpccx0Z1jpgNPIwXzSb65F3JdPOVGY8E+I
	 +XceZv5AIuEQ20Dw2A3tFceEEgiwSXIoLy71Ccgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgJ2Ojf (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgJ2Oje (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Oct 2020 10:39:34 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140A820838;
        Thu, 29 Oct 2020 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603982374;
        bh=UxKTrOdbQX8WwcdQeFEJqz4r+f0/JB4wMaev8w7Ad88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6uJfLd6Zfm8m7sZgdS926PUyJig4Y8AaIu6IdtP9KCp8CsXlcsz4f4atTFg0cr6a
         Qo9FMu7gk+f/lP5vFTa0ihGsyoSy12eoxMHxoNeyTtIqU6qEyBqn1M+4YT1EgejAlA
         tqNmrhmFhMfRup/LhiWNEjZvitZezcEIaNojK/io=
Date:   Thu, 29 Oct 2020 22:39:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: vf: align watchdog node name with dtschema
Message-ID: <20201029143925.GQ28755@dragon>
References: <20200926162302.32525-1-krzk@kernel.org>
 <20200926162302.32525-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162302.32525-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sat, Sep 26, 2020 at 06:23:02PM +0200, Krzysztof Kozlowski wrote:
> The dtschema expects watchdog device node name to be "watchdog":
> 
>   arch/arm/boot/dts/vf500-colibri-eval-v3.dt.yaml: wdog@4003e000:
>     $nodename:0: 'wdog@4003e000' does not match '^watchdog(@.*|-[0-9a-f])?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
