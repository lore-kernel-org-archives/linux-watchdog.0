Return-Path: <SRS0=NjjV=4A=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21A2C3F68F
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Feb 2020 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7970B21734
	for <linux-watchdog@archiver.kernel.org>; Wed, 12 Feb 2020 14:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBLO7q (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:59:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:32755 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgBLO7q (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 12 Feb 2020 09:59:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 06:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="237729494"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 06:59:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A13251F6; Wed, 12 Feb 2020 16:59:41 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Tom Abraham <tabraham@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 0/3] ACPI / watchdog: Fix two reported issues
Date:   Wed, 12 Feb 2020 17:59:38 +0300
Message-Id: <20200212145941.32914-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

This is an updated version of the patch series posted here:

  https://lore.kernel.org/linux-watchdog/20200212110540.83559-1-mika.westerberg@linux.intel.com/

This should fix the two issues reported by Jean Delvare. I also addressed
all the review comments and fixed the bugs in the previous version.

This time I actually tested these on Intel Joule board and the watchdog
still works as expected.

I'm now including ACPICA maintainers as well to get some feedback regarding
the first patch of the series.

Mika Westerberg (3):
  ACPICA: Introduce ACPI_ACCESS_BYTE_WIDTH() macro
  ACPI / watchdog: Fix gas->access_width usage
  ACPI / watchdog: Set default timeout in probe

 drivers/acpi/acpi_watchdog.c |  3 +--
 drivers/watchdog/wdat_wdt.c  | 25 ++++++++++++++++++++++++-
 include/acpi/actypes.h       |  3 ++-
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.25.0

