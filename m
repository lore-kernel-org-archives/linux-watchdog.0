Return-Path: <ray.jui@broadcom.com>
Return-path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec' property for sp805
Date: Tue, 22 May 2018 11:47:16 -0700
Message-Id: <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-watchdog@vger.kernel.org>

Update the SP805 binding document to add optional 'timeout-sec'
devicetree property

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
index edc4f0e..f898a86 100644
--- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
@@ -19,6 +19,8 @@ Required properties:
 
 Optional properties:
 - interrupts : Should specify WDT interrupt number.
+- timeout-sec : Should specify default WDT timeout in seconds. If unset, the
+                default timeout is 30 seconds
 
 Examples:
 
-- 
2.1.4
