Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33769 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030298AbbKFVzR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 16:55:17 -0500
Received: by wijp11 with SMTP id p11so38096834wij.0
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Nov 2015 13:55:15 -0800 (PST)
From: Carlo Caione <carlo@caione.org>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	drake@endlessm.com, jerry.cao@amlogic.com, victor.wan@amlogic.com,
	romain.perier@gmail.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH 0/4] watchdog: meson: Add meson8b watchdog
Date: Fri,  6 Nov 2015 22:55:02 +0100
Message-Id: <1446846906-31520-1-git-send-email-carlo@caione.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

Patchset to add support for the watchdog found on the Amlogic meson8b SoCs.
DTS and documentation are also updated.

Carlo Caione (4):
  watchdog: meson: Enable meson SoC specific data
  watchdog: meson: Add meson8b SoC specific data
  Documentation: watchdog: Add new bindings for meson8b
  ARM: dts: meson8b: Add watchdog node

 .../devicetree/bindings/watchdog/meson-wdt.txt     | 13 +++++
 .../devicetree/bindings/watchdog/meson6-wdt.txt    | 13 -----
 arch/arm/boot/dts/meson8b.dtsi                     |  6 +++
 drivers/watchdog/meson_wdt.c                       | 62 ++++++++++++++++------
 4 files changed, 64 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

-- 
1.9.1

