Return-Path: <ray.jui@broadcom.com>
Return-path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 6/6] arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG
Date: Wed, 23 May 2018 17:15:24 -0700
Message-Id: <1527120924-12131-7-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
References: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-watchdog@vger.kernel.org>

Enable the SP805 watchdog timer

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..3fe5eb5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -351,6 +351,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.1.4
