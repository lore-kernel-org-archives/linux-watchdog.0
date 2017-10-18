Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44604 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdJRRCO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Oct 2017 13:02:14 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        cphealy@gmail.com, Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 5/5] dt-bindings: watchdog: Add bindings for RAVE SP watchdog driver
Date: Wed, 18 Oct 2017 10:01:36 -0700
Message-Id: <20171018170136.12347-6-andrew.smirnov@gmail.com>
In-Reply-To: <20171018170136.12347-1-andrew.smirnov@gmail.com>
References: <20171018170136.12347-1-andrew.smirnov@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
new file mode 100644
index 000000000000..f242c3eed0dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
@@ -0,0 +1,10 @@
+Zodiac Inflight Innovations RAVE Supervisory Processor Watchdog
+
+Required properties:
+
+ - compatible: Should be "zii,rave-sp-watchdog"
+
+Optional properties:
+
+ - Two byte nvmem cell "wdt_timeout", specified as per
+   Documentation/devicetree/bindings/nvmem/nvmem.txt
-- 
2.13.5

