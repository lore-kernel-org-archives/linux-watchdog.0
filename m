Return-Path: <SRS0=xPok=SZ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB3C282DD
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093F72175B
	for <linux-watchdog@archiver.kernel.org>; Tue, 23 Apr 2019 15:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfDWPwA (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:52:00 -0400
Received: from mail5.windriver.com ([192.103.53.11]:40470 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfDWPwA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 23 Apr 2019 11:52:00 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3NFmwNQ005137
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 23 Apr 2019 08:49:08 -0700
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 08:48:48 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nancy Yuen <yuenn@google.com>, <openbmc@lists.ozlabs.org>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/5] wdt: clean up unused modular infrastructure
Date:   Tue, 23 Apr 2019 11:48:30 -0400
Message-ID: <1556034515-28792-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

People can embed modular includes and modular exit functions into code
that never use any of it, and they won't get any errors or warnings.

Using modular infrastructure in non-modules might seem harmless, but some
of the downfalls this leads to are:

 (1) it is easy to accidentally write unused module_exit/remove code
 (2) it can be misleading when reading the source, thinking a driver can
     be modular when the Makefile and/or Kconfig prohibit it
 (3) an unused include of the module.h header file will in turn
     include nearly everything else; adding a lot to CPP overhead.
 (4) it gets copied/replicated into other drivers and can spread.

As a data point for #3 above, an empty C file that just includes the
module.h header generates over 750kB of CPP output.  Repeating the same
experiment with init.h and the result is less than 12kB; with export.h
it is only about 1/2kB; with both it still is less than 12kB.

Here, In this series, we do what has been done for other subsystems,
like, net, x86, mfd, iommu....  and audit for uses of modular
infrastructure inside code that currently can't be built as a module.

As always, the option exists for driver authors to convert their code
to tristate, if there is a valid use case for it to be so.  But since
I don't have the context for each driver to know if such a use case
exists, I limit myself to simply removing the unused code in order to
make the driver consistent with the Makefile/Kconfig settings that
control it.

Paul.

---

Cc: Benjamin Fair <benjaminfair@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-watchdog@vger.kernel.org
Cc: Nancy Yuen <yuenn@google.com>
Cc: openbmc@lists.ozlabs.org
Cc: Patrick Venture <venture@google.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>


Paul Gortmaker (5):
  watchdog: rtd119x: drop unused module.h include
  watchdog: watchdog_core: make it explicitly non-modular
  watchdog: npcm: make it explicitly non-modular
  watchdog: intel_scu: make it explicitly non-modular
  watchdog: coh901327: make it explicitly non-modular

 drivers/watchdog/coh901327_wdt.c      | 24 ++++--------------------
 drivers/watchdog/intel_scu_watchdog.c | 18 ------------------
 drivers/watchdog/npcm_wdt.c           | 13 ++++++-------
 drivers/watchdog/rtd119x_wdt.c        |  1 -
 drivers/watchdog/watchdog_core.c      | 15 +--------------
 5 files changed, 11 insertions(+), 60 deletions(-)

-- 
2.7.4

