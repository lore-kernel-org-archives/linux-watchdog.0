Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF21C0018C
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Dec 2020 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A1D227BF
	for <linux-watchdog@archiver.kernel.org>; Fri,  4 Dec 2020 09:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbgLDJ2g (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 4 Dec 2020 04:28:36 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:53195 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLDJ2g (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Dec 2020 04:28:36 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2209F200007;
        Fri,  4 Dec 2020 09:27:53 +0000 (UTC)
Date:   Fri, 4 Dec 2020 10:27:52 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Qiang Zhao <qiang.zhao@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/2] rtc: pcf2127: only use watchdog when explicitly
 available
Message-ID: <20201204092752.GE74177@piout.net>
References: <20200924074715.GT9675@piout.net>
 <20200924105256.18162-1-u.kleine-koenig@pengutronix.de>
 <c82fe7a9-0a5a-fd70-ae3d-6fdc5fca5a9a@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c82fe7a9-0a5a-fd70-ae3d-6fdc5fca5a9a@prevas.dk>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 30/11/2020 10:51:41+0100, Rasmus Villemoes wrote:
> On 24/09/2020 12.52, Uwe Kleine-König wrote:
> > Hello,
> > 
> > now that there are two people stumbling over the pcf2127 driver
> > providing a non-functional watchdog device, here comes an RFC patch to
> > address this.
> 
> I just want to add a "me too" here, as I'm also now affected by the
> pcf2127 exposing a watchdog device (1) it didn't use to (affecting what
> /dev/watchdog0 means) and (2) is not actually hooked up in hardware.
> 
> So can we please move forward with adding the has-watchdog opt-in DT
> property so existing boards will not be affected?
> 

Well, someone has to get that property reviewed by Rob. Maybe this could
be reset-source as we have wakeup-source.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
