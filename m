Return-Path: <andrew.smirnov@gmail.com>
Return-path: <andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	cphealy@gmail.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Machek <pavel@ucw.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH v14 5/5] dt-bindings: watchdog: Add bindings for RAVE SP watchdog driver
Date: Thu,  7 Dec 2017 08:27:35 -0800
Message-Id: <20171207162735.25873-6-andrew.smirnov@gmail.com>
In-Reply-To: <20171207162735.25873-1-andrew.smirnov@gmail.com>
References: <20171207162735.25873-1-andrew.smirnov@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Add Device Tree bindings for RAVE SP watchdog drvier - an MFD cell of
parent RAVE SP driver (documented in
Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

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
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 .../bindings/watchdog/zii,rave-sp-wdt.txt          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
new file mode 100644
index 000000000000..ab16659e781d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/zii,rave-sp-wdt.txt
@@ -0,0 +1,39 @@
+Zodiac Inflight Innovations RAVE Supervisory Processor Watchdog Bindings
+
+RAVE SP watchdog device is a "MFD cell" device corresponding to
+watchdog functionality of RAVE Supervisory Processor. It is expected
+that its Device Tree node is specified as a child of the node
+corresponding to the parent RAVE SP device (as documented in
+Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
+
+Required properties:
+- compatible:	Should be "zii,rave-sp-watchdog"
+
+Optional properties:
+
+- wdt-timeout:	Two byte nvmem cell specified as per
+		Documentation/devicetree/bindings/nvmem/nvmem.txt
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		eeprom {
+			compatible = "zii,pic-main-eeprom";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wdt_timeout: wdt-timeout@8E {
+				reg = <0x8E 2>;
+			};
+		};
+
+		watchdog {
+			compatible = "zii,rave-sp-watchdog";
+			nvmem-cells = <&wdt_timeout>;
+			nvmem-cell-names = "wdt-timeout";
+		};
+	}
+
-- 
2.14.3
