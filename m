Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41787 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdL2UOy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 29 Dec 2017 15:14:54 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: mail@maciej.szmigiero.name, linux@roeck-us.net,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 4/5] isa: Remove ISA_BUS_API selection for ISA_BUS
Date: Fri, 29 Dec 2017 15:14:46 -0500
Message-Id: <bc33320887f448b772004e7c5d97322abb8cae0b.1514578085.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ISA_BUS_API is selected by drivers themselves when necessary. The
ISA_BUS Kconfig option is now simply a mask for true ISA device drivers
and relevant configuration. For now, the ISA_BUS Kconfig option is only
available for X86, but may be added for other arch builds in the future
if the need arises.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 arch/x86/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8eed3f94bfc7..5478c5beb302 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2608,11 +2608,13 @@ config PCI_CNB20LE_QUIRK
 source "drivers/pci/Kconfig"
 
 config ISA_BUS
-	bool "ISA-style bus support on modern systems" if EXPERT
-	select ISA_BUS_API
+	bool "ISA bus support on modern systems" if EXPERT
 	help
-	  Enables ISA-style drivers on modern systems. This is necessary to
-	  support PC/104 devices on X86_64 platforms.
+	  Expose ISA bus device drivers and options available for selection and
+	  configuration. Enable this option if your target machine has an ISA
+	  bus. ISA is an older system, displaced by PCI and newer bus
+	  architectures -- if your target machine is modern, it probably does
+	  not have an ISA bus.
 
 	  If unsure, say N.
 
-- 
2.15.1

