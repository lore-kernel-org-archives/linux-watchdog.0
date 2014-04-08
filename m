Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37945 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756288AbaDHXo1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Apr 2014 19:44:27 -0400
From: David Cohen <david.a.cohen@linux.intel.com>
To: wim@iguana.be, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	gnomes@lxorguk.ukuu.org.uk, david.a.cohen@linux.intel.com
Subject: [PATCH 0/2] Initial implementation of Intel MID watchdog driver
Date: Tue,  8 Apr 2014 13:59:02 -0700
Message-Id: <1396990744-10695-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

This patch set is an initial implementation of a generic Intel MID watchdog
driver.
It currently supports Intel Merrifield only, but will extend to other SoCs of
MID family.

Br, David

--
David Cohen (2):
  watchdog: add Intel MID watchdog driver support
  x86: intel-mid: add watchdog platform code for Merrifield

 arch/x86/platform/intel-mid/device_libs/Makefile   |   1 +
 .../platform/intel-mid/device_libs/platform_wdt.c  |  43 +++++
 drivers/watchdog/Kconfig                           |  12 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/intel-mid_wdt.c                   | 209 +++++++++++++++++++++
 5 files changed, 266 insertions(+)
 create mode 100644 arch/x86/platform/intel-mid/device_libs/platform_wdt.c
 create mode 100644 drivers/watchdog/intel-mid_wdt.c

-- 
1.9.0

