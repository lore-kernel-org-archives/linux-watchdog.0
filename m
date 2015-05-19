Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.166]:46975 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932241AbbESNaO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 09:30:14 -0400
Message-ID: <67231dc85550f233e15fe5e1a823cfa14e023c57.1432041031.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1432041031.git.stwiss.opensource@diasemi.com>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
From: S Twiss <stwiss.opensource@diasemi.com>
Date: Tue, 19 May 2015 14:10:30 +0100
Subject: [PATCH V3 4/4] devicetree: da9062: Add bindings for DA9062 driver
To: DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>
CC: Alessandro Zummo <a.zummo@towertech.it>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	S Twiss <stwiss.opensource@diasemi.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: S Twiss <stwiss.opensource@diasemi.com>

Add device tree bindings for the DA9062 driver


Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Changes in V3:
 - No change
 
Changes in V2:
 - Dropped the RTC and Onkey binding information in this patch-set
   Those drivers have been dropped from this patch set and the
   binding information has been removed accordingly.

This patch applies against linux-next and v4.1-rc3 



 Documentation/devicetree/bindings/mfd/da9062.txt | 79 ++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
new file mode 100644
index 0000000..5765ed9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -0,0 +1,79 @@
+* Dialog DA9062 Power Management Integrated Circuit (PMIC)
+
+DA9062 consists of a large and varied group of sub-devices:
+
+Device                   Supply Names    Description
+------                   ------------    -----------
+da9062-regulator        :               : LDOs & BUCKs
+da9062-watchdog         :               : Watchdog Timer
+
+======
+
+Required properties:
+
+- compatible : Should be "dlg,da9062".
+- reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
+  modified to match the chip's OTP settings).
+- interrupt-parent : Specifies the reference to the interrupt controller for
+  the DA9062.
+- interrupts : IRQ line information.
+- interrupt-controller
+
+See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+further information on IRQ bindings.
+
+Sub-nodes:
+
+- regulators : This node defines the settings for the LDOs and BUCKs. The
+  DA9062 regulators are bound using their names listed below:
+
+    buck1    : BUCK_1
+    buck2    : BUCK_2
+    buck3    : BUCK_3
+    buck4    : BUCK_4
+    ldo1     : LDO_1
+    ldo2     : LDO_2
+    ldo3     : LDO_3
+    ldo4     : LDO_4
+
+  The component follows the standard regulator framework and the bindings
+  details of individual regulator device can be found in:
+  Documentation/devicetree/bindings/regulator/regulator.txt
+
+
+- watchdog: This node defines the settings for the watchdog driver associated
+  with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
+  if a node is created.
+
+
+Example:
+
+	pmic0: da9062@58 {
+		compatible = "dlg,da9062";
+		reg = <0x58>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		watchdog {
+			compatible = "dlg,da9062-watchdog";
+		};
+
+		regulators {
+			DA9062_BUCK1: buck1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1570000>;
+				regulator-min-microamp = <500000>;
+				regulator-max-microamp = <2000000>;
+				regulator-boot-on;
+			};
+			DA9062_LDO1: ldo1 {
+				regulator-name = "LDO_1";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+			};
+		};
+	};
+
-- 
end-of-patch for PATCH V3

