Return-Path: <SRS0=d5Mv=QP=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E3C169C4
	for <linux-watchdog@archiver.kernel.org>; Fri,  8 Feb 2019 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BDB21919
	for <linux-watchdog@archiver.kernel.org>; Fri,  8 Feb 2019 10:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfBHKwd (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:52:33 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33885 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHKwd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 8 Feb 2019 05:52:33 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gs3ln-0008UL-Vl; Fri, 08 Feb 2019 11:52:31 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gs3ln-00024g-1K; Fri, 08 Feb 2019 11:52:31 +0100
Date:   Fri, 8 Feb 2019 11:52:31 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org
Subject: What to set in struct watchdog_device::bootstatus?
Message-ID: <20190208105230.g33nxiu4r6uqech3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-watchdog@vger.kernel.org
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hello,

it's unclear to me, which bits I am supposed to set in the bootstatus
member of struct watchdog_device at probe time.

The i.MX watchdog differentiates the following reset causes:

 - Power On
 - external reset
 - watchdog timeout
 - software reset using a bit in the watchdog register set

(Not all i.MX variants implement all bits according to the respective
reference manuals.)

Should "Power On" result in setting WDIOF_POWERUNDER?

Should "software reset [...]" result in WDIOF_CARDRESET?

Should "external reset" result in WDIOF_EXTERN1? (I guess that no)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
