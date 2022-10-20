Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A7EC433FE
	for <linux-watchdog@archiver.kernel.org>; Thu, 20 Oct 2022 18:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJTSu6 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJTSu5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2022 14:50:57 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833E112A98;
        Thu, 20 Oct 2022 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666291853; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=RV480YNenF/jlwMOhQtM8MMhBl1hDAejAqsptq4UvdQ=;
        b=Mz3Arf4oaFZJP+v0+83yxhraaUVjer1zHEkyZOlzjPyYg+NxpbVhOWhEDVC/2Mam3ghuHX
        aa7ptcqlza0T3eCyBpEykU/l0et1Qa0Z/X7R9NM8IjfJGvS3zHD6FCTYQJmzwzCWWOwgqp
        jmreFBd8MjzX/j3lIFLPfYGrFxNxOFY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/4] watchdog: Remove #ifdef guards for PM functions
Date:   Thu, 20 Oct 2022 19:50:43 +0100
Message-Id: <20221020185047.1001522-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

A finishing touch of my previous work that removed #ifdef guards around
PM functions. Some drivers were not updated.

With this patchset all watchdog drivers are now converted to use the new
PM macros.

Cheers,
-Paul

Paul Cercueil (4):
  watchdog: at91rm9200: Remove #ifdef guards for PM related functions
  watchdog: twl4030: Remove #ifdef guards for PM related functions
  watchdog: omap: Remove #ifdef guards for PM related functions
  watchdog: kempld: Remove #ifdef guards for PM related functions

 drivers/watchdog/at91rm9200_wdt.c | 11 ++---------
 drivers/watchdog/db8500_wdt.c     |  9 ++-------
 drivers/watchdog/kempld_wdt.c     | 11 ++---------
 drivers/watchdog/omap_wdt.c       | 11 ++---------
 drivers/watchdog/twl4030_wdt.c    |  9 ++-------
 5 files changed, 10 insertions(+), 41 deletions(-)

-- 
2.35.1

