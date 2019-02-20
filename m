Return-Path: <SRS0=fu0w=Q3=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15854C43381
	for <linux-watchdog@archiver.kernel.org>; Wed, 20 Feb 2019 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDF02080F
	for <linux-watchdog@archiver.kernel.org>; Wed, 20 Feb 2019 20:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfBTUOO (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:14:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46543 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTUOO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 20 Feb 2019 15:14:14 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gwYFt-000895-HW; Wed, 20 Feb 2019 21:14:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gwYFs-000674-HP; Wed, 20 Feb 2019 21:14:08 +0100
Date:   Wed, 20 Feb 2019 21:14:08 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: What to set in struct watchdog_device::bootstatus?
Message-ID: <20190220201408.gcgsg43uonwc4ucs@pengutronix.de>
References: <20190208105230.g33nxiu4r6uqech3@pengutronix.de>
 <f9ec94d7-8365-e733-81ff-34c501cce89a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9ec94d7-8365-e733-81ff-34c501cce89a@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-watchdog@vger.kernel.org
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hello Guenter,

On Fri, Feb 08, 2019 at 06:05:43AM -0800, Guenter Roeck wrote:
> On 2/8/19 2:52 AM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > it's unclear to me, which bits I am supposed to set in the bootstatus
> > member of struct watchdog_device at probe time.
> > 
> > The i.MX watchdog differentiates the following reset causes:
> > 
> >   - Power On
> None.
> 
> >   - external reset
> 
> None.
> 
> >   - watchdog timeout
> 
> WDIOF_CARDRESET
> 
> >   - software reset using a bit in the watchdog register set
> > 
> > (Not all i.MX variants implement all bits according to the respective
> > reference manuals.)
> > 
> > Should "Power On" result in setting WDIOF_POWERUNDER?
> > 
> No.
> 
> > Should "software reset [...]" result in WDIOF_CARDRESET?
> > 
> That would be the best fit if you want a bit to be set, but it would be
> misleading since it would suggest that the watchdog fired.
> 
> > Should "external reset" result in WDIOF_EXTERN1? (I guess that no)
>
> No.

In a custom kernel patch stack I found a patch that uses (apart from
WDIOF_CARDRESET also) WDIOF_POWERUNDER and WDIOF_EXTERN1 to
differentiate the different reset causes. Now that you told using this
is wrong, I wonder how these are supposed to be used instead; and there
are a few more that according to
Documentation/watchdog/watchdog-kernel-api.txt might be used to set
bootstatus. Are these a relic? What do these signal?

IMHO there is a patch opportunity waiting to improve the documenation
:-) Or maybe even change watchdog_get_status() to ensure that only
WDIOF_CARDRESET, WDIOF_MAGICCLOSE and WDIOF_KEEPALIVEPING can be set?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
