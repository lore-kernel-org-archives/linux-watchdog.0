Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49179 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbcF0X0w (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jun 2016 19:26:52 -0400
From: Thomas Pedersen <twp@codeaurora.org>
To: linux-watchdog@vger.kernel.org
Cc: Thomas Pedersen <twp@codeaurora.org>
Subject: [PATCH 0/3] qcom watchdog fixes
Date: Mon, 27 Jun 2016 16:26:47 -0700
Message-Id: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some boards (eg. qcom IPQ8064 based) Need these changes to avoid a spurious
watchdog reset.

Matthew McClintock (3):
  watchdog: qcom: update device tree bindings
  watchdog: qcom: add option for standalone watchdog not in timer block
  watchdog: qcom: configure BARK time in addition to BITE time

 .../devicetree/bindings/watchdog/qcom-wdt.txt      |  5 +-
 drivers/watchdog/qcom-wdt.c                        | 78 ++++++++++++++++------
 2 files changed, 59 insertions(+), 24 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

