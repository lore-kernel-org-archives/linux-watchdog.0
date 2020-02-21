Return-Path: <SRS0=GRI/=4J=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF8C35647
	for <linux-watchdog@archiver.kernel.org>; Fri, 21 Feb 2020 14:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341CC20679
	for <linux-watchdog@archiver.kernel.org>; Fri, 21 Feb 2020 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="sUGL2Eyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgBUOGC (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:06:02 -0500
Received: from www.linux-watchdog.org ([185.87.125.42]:53430 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgBUOGB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Feb 2020 09:06:01 -0500
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 0A8AB409DB; Fri, 21 Feb 2020 14:15:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 0A8AB409DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1582290950;
        bh=FcZySqhyMAh9lhbUP3TGUj05n+xie8vP4kFrH3asFSs=;
        h=Date:From:To:Cc:Subject:From;
        b=sUGL2Eyw7ZvNBTVhZpFSwCmasMbiGhBCLkENp72UmNpG7U38DgtL+ZVa3+xsYsUB2
         8eIpN6bRGM9nQDW3NE0ChuikpJzG40yDEuupKZVswdaDO1fgt2gvDSFx18yGp2wRXm
         ZyqepsqmARYTa+SbmFhZv1/tKOvcmAfxPP9rxp+I=
Date:   Fri, 21 Feb 2020 14:15:49 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL REQUEST] watchdog - v5.6 Fixes
Message-ID: <20200221131549.GA13194@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull the watchdog fixes for the v5.6 release cycle.

This series contains:
* mtk_wdt.c: RESET_CONTROLLER build error fix
* da9062: fix power management ops
* da9062: do not ping the hw during stop()
* da9062: Add dependency on I2C

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.6-rc3

for you to fetch changes up to 44144c809e39d64ff9931c7e8956c42b2baa89e6:

  watchdog: da9062: Add dependency on I2C (2020-02-17 13:19:08 +0100)

----------------------------------------------------------------
linux-watchdog 5.6-rc3 tag

----------------------------------------------------------------
Guenter Roeck (1):
      watchdog: da9062: Add dependency on I2C

Marco Felsch (2):
      watchdog: da9062: do not ping the hw during stop()
      watchdog: da9062: fix power management ops

Randy Dunlap (1):
      watchdog: fix mtk_wdt.c RESET_CONTROLLER build error

 drivers/watchdog/Kconfig      |  2 ++
 drivers/watchdog/da9062_wdt.c | 19 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
----------------------------------------------------------------

Kind regards,
Wim.

