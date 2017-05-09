Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbdEISU3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 9 May 2017 14:20:29 -0400
From: Moritz Fischer <mdf@kernel.org>
To: linux-watchdog@vger.kernel.org
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, wim@iguana.be,
        alexandre.belloni@free-electrons.com, a.zummo@towertech.it,
        mark.rutland@arm.com, robh+dt@kernel.org, moritz.fischer@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [RFC/PATCH 1/2] dt-binding: mfd: Add Maxim/Dallas DS1374 MFD device binding
Date: Tue,  9 May 2017 11:20:20 -0700
Message-Id: <1494354021-370-1-git-send-email-mdf@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds a binding for the Maxim/Dallas DS1374 MFD.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi all,

I'm not entirely sure aobut the binding, does anyone
have a better suggestion for the remap-wdt-reset property?

Thanks,

Moritz

---
 Documentation/devicetree/bindings/mfd/ds1374.txt   | 63 ++++++++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt        |  1 -
 drivers/rtc/Kconfig                                |  2 +
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ds1374.txt

diff --git a/Documentation/devicetree/bindings/mfd/ds1374.txt b/Documentation/devicetree/bindings/mfd/ds1374.txt
new file mode 100644
index 0000000..b22396f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ds1374.txt
@@ -0,0 +1,63 @@
+* Device tree bindings for Maxim/Dallas DS1374 Multi Function Device (MFD)
+
+The Maxim/Dallas DS1374 is a multi function device that combines rtc,
+watchdog or alarm, as well as trickle charger.
+
+The DS1374 is connected via I2C.
+
+Required properties:
+- compatible: "dallas,ds1374"
+- reg: I2C slave address
+- dallas,ds1374-mode: Should be one of the following values:
+			<0> for RTC
+			<1> for RTC + Alarm (Interrupt)
+			<2> for RTC + Watchdog
+
+Required child:
+A single available child device of type matching the "dallas,ds1374-mode"
+property.
+
+Optional properties (watchdog):
+- dallas,ds1374-remap-wdt-reset: Boolean describing whether the INT pin
+				 on the device is used as interrupt for
+				 the alarm
+
+See ../watchdog/* for generic watchdog bindings.
+
+Optional properties (real time clock):
+- interrupt: phandle to interrupt cell for the rtc's alarm feature
+
+See ../rtc/* for generic rtc bindings.
+
+Optional properties (trickle-charger):
+- dallas,trickle-resistor-ohms : Selected resistor for trickle charger
+	Values usable for ds1374 are 250, 2000, 4000
+	Should be given if trickle charger should be enabled
+- dallas,trickle-diode-disable : Do not use internal trickle charger diode
+	Should be given if internal trickle charger diode should be disabled
+
+Example for rtc with alarm mode and interrupt:
+
+i2c@12ca0000 {
+	rtc@68 {
+		compatible = "ds1374";
+		reg = <0x68>;
+		interrupts = <&gpio0 62>;
+		dallas,ds1374-mode = <2>
+
+		dallas,trickle-resistor-ohms = <250>;
+		dallas,trickle-diode-disable;
+	};
+};
+
+Example for rtc with watchdog and reset on timeout, with reset remapped
+to the INT pin:
+
+i2c@12ca0000 {
+	rtc@68 {
+		compatible = "ds1374";
+		reg = <0x68>;
+		dallas,ds1374-mode = <2>
+		dallas,ds1374-remap-wdt-reset;
+	};
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 3e0a34c..f7a50e5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -29,7 +29,6 @@ cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
 dallas,ds1307		64 x 8, Serial, I2C Real-Time Clock
 dallas,ds1338		I2C RTC with 56-Byte NV RAM
 dallas,ds1340		I2C RTC with Trickle Charger
-dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
 dallas,ds1682		Total-Elapsed-Time Recorder with Alarm
 dallas,ds1775		Tiny Digital Thermometer and Thermostat
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d3b957..e6763fe 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -250,6 +250,8 @@ config RTC_DRV_DS1307_CENTURY
 
 config RTC_DRV_DS1374
 	tristate "Dallas/Maxim DS1374"
+	depends on MFD_DS1374
+	depends on REGMAP_I2C
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS1374 real-time clock chips. If an interrupt is associated
-- 
2.7.4

