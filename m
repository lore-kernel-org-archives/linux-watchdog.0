Return-Path: <SRS0=BVI6=UE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560AAC282DE
	for <linux-watchdog@archiver.kernel.org>; Wed,  5 Jun 2019 06:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217B920866
	for <linux-watchdog@archiver.kernel.org>; Wed,  5 Jun 2019 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559715178;
	bh=irDCUXbnBDlPlmhz5zcjcndvEsXZZZcUc47h1fBL7fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3FT3AXvG9itbdXLfp3QkOy+D2j5nR86pvOMei9dMBhDx3JNpTFvchCLFW17PISze
	 ZyBDKH2F+puWGHx1jaFFJormYMcaMpsaNRCpRDk+xWK7Q/98Mf3aH01a2akaJpcsel
	 DWGNyBN3yTnW1aVTPqOOEz9sg5yUd7IEJrBgt7ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFEGM5 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGM5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Jun 2019 02:12:57 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011DB20673;
        Wed,  5 Jun 2019 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559715177;
        bh=irDCUXbnBDlPlmhz5zcjcndvEsXZZZcUc47h1fBL7fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcHfwmcFrho2SGrruB5UjX2fRIX46+0x6zffq3Mxh5vseEXNEnJwSVsrpDkRT7rhF
         VYxCR9TKKAyGC4DA7FpPKO5/9y7A86CcFkmTxYzVBVcUoVDrwK2pyUE7hLj3L5Nw82
         73CquITgGh7XLFlN5CxOh4ohzeEOOSL/zxOR7mys=
Date:   Wed, 5 Jun 2019 14:12:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V4 2/3] arm64: dts: imx8qxp: Move watchdog node
 into scu node
Message-ID: <20190605061238.GC29853@dragon>
References: <1557655528-12816-1-git-send-email-Anson.Huang@nxp.com>
 <1557655528-12816-2-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39162F3811484D90546B4CC2F5150@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190605060000.GA29853@dragon>
 <DB3PR0402MB39161D679A11B05ADCA8A28BF5160@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39161D679A11B05ADCA8A28BF5160@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Jun 05, 2019 at 06:09:12AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Wednesday, June 5, 2019 2:00 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: robh+dt@kernel.org; mark.rutland@arm.com; wim@linux-watchdog.org;
> > linux@roeck-us.net; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; Aisheng Dong <aisheng.dong@nxp.com>;
> > ulf.hansson@linaro.org; Daniel Baluta <daniel.baluta@nxp.com>; Peng Fan
> > <peng.fan@nxp.com>; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH RESEND V4 2/3] arm64: dts: imx8qxp: Move watchdog
> > node into scu node
> > 
> > On Tue, Jun 04, 2019 at 09:06:28AM +0000, Anson Huang wrote:
> > > Hi, Shawn
> > > 	The driver and binding doc are already reviewed and waiting for DT
> > patch, will you help review this DT patch?
> > 
> > I'm fine with it.  Should I just pick this patch up, or is there any dependency
> > we need to handle?
> 
> No dependency, it just makes more sense to move the node into SCU node as it is NOW depending on SCU
> driver. Once you pick up this patch

Just applied.

> (and maybe the dt-binding patch as well?),

It makes more sense to have it go through watchdog tree.

Shawn

> I will notify the watchdog
> maintainer to pick up the watchdog patch in this series.

