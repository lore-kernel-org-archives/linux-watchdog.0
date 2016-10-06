Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.139]:62974 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967045AbcJFJKP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Oct 2016 05:10:15 -0400
Message-ID: <7a21f22bd62817b63ba64e11eecadfb78338ee46.1475743411.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 6 Oct 2016 09:43:31 +0100
Subject: [PATCH V1 09/10] Documentation: dt: mfd: da9062/61 MFD binding
To: DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Extend existing DA9062 binding information to include the DA9061 PMIC for
MFD core and regulators.

Add a da9062-onkey link to the existing onkey binding file.

Add a da9062-thermal link to the new temperature monitoring binding file
found in [PATCH V1 8/10].

Delete the da9062-watchdog section and replace it with a link to the new
DA9061/62 binding information file added by [PATCH V1 7/10].

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Hi,

This patch depends on acceptance of the main code for the DA9061 MFD:

- [PATCH V1 1/10] mfd: da9061: MFD core support

and also from the following binding file changes:

- [PATCH V1 6/10] Binding for onkey
- [PATCH V1 7/10] Binding for watchdog
- [PATCH V1 8/10] Binding for thermal

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 Documentation/devicetree/bindings/mfd/da9062.txt | 45 +++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 38802b5..38ba5e2 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -1,22 +1,32 @@
 * Dialog DA9062 Power Management Integrated Circuit (PMIC)
 
-DA9062 consists of a large and varied group of sub-devices:
+The DA9062 driver is compatible with the DA9062 and DA9061 devices.
+
+Product information can be found here:
+- http://www.dialog-semiconductor.com/products/da9062
+- http://www.dialog-semiconductor.com/products/da9061
+
+DA9062 driver consists of a large and varied group of sub-devices:
 
 Device                   Supply Names    Description
 ------                   ------------    -----------
 da9062-regulator        :               : LDOs & BUCKs
 da9062-rtc              :               : Real-Time Clock
+da9062-onkey            :               : On Key
 da9062-watchdog         :               : Watchdog Timer
+da9062-thermal          :               : Thermal
 
 ======
 
 Required properties:
 
-- compatible : Should be "dlg,da9062".
+- compatible : Should be
+    "dlg,da9062" for DA9062
+    "dlg,da9061" for DA9061
 - reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
   modified to match the chip's OTP settings).
 - interrupt-parent : Specifies the reference to the interrupt controller for
-  the DA9062.
+  the DA9062 or DA9061.
 - interrupts : IRQ line information.
 - interrupt-controller
 
@@ -25,8 +35,8 @@ further information on IRQ bindings.
 
 Sub-nodes:
 
-- regulators : This node defines the settings for the LDOs and BUCKs. The
-  DA9062 regulators are bound using their names listed below:
+- regulators : This node defines the settings for the LDOs and BUCKs.
+  The DA9062 regulators are bound using their names listed below:
 
     buck1    : BUCK_1
     buck2    : BUCK_2
@@ -37,6 +47,16 @@ Sub-nodes:
     ldo3     : LDO_3
     ldo4     : LDO_4
 
+  The DA9061 regulators are bound using their names listed below:
+
+    buck1    : BUCK_1
+    buck2    : BUCK_2
+    buck3    : BUCK_3
+    ldo1     : LDO_1
+    ldo2     : LDO_2
+    ldo3     : LDO_3
+    ldo4     : LDO_4
+
   The component follows the standard regulator framework and the bindings
   details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
@@ -46,9 +66,14 @@ Sub-nodes:
   with the DA9062. There are currently no entries in this binding, however
   compatible = "dlg,da9062-rtc" should be added if a node is created.
 
-- watchdog: This node defines the settings for the watchdog driver associated
-  with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
-  if a node is created.
+
+- onkey : See ../input/da9062-onkey.txt
+
+
+- watchdog: See ../watchdog/da9062-watchdog.txt
+
+
+- thermal : See ../thermal/da9062-thermal.txt
 
 
 Example:
@@ -64,10 +89,6 @@ Example:
 			compatible = "dlg,da9062-rtc";
 		};
 
-		watchdog {
-			compatible = "dlg,da9062-watchdog";
-		};
-
 		regulators {
 			DA9062_BUCK1: buck1 {
 				regulator-name = "BUCK1";
-- 
end-of-patch for PATCH V1

