Return-path: <stwiss.opensource@diasemi.com>
Message-ID: <e85c9e4723ea7e7bff32d7a4c92807439b438c6d.1477501000.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1477501000.git.stwiss.opensource@diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Wed, 26 Oct 2016 17:56:37 +0100
Subject: [PATCH V2 01/10] Documentation: devicetree: input: additions for
 da9061 onkey driver
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>,
	LINUX-KERNEL <linux-kernel@vger.kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck
	<linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG
	<linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Support
 Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck
	<wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add binding information for DA9061 onkey.

This patch updates the compatible string "dlg,da9061-onkey" to support
DA9061, removes the reference to KEY_SLEEP (which the driver no longer
supports) and fixes a typo in the example for DA9063.

It also adds two new examples, one for DA9062 and one for DA9061. The
DA9061 examples uses a fall-back compatible string for the DA9062 onkey
driver.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

v1 -> v2
 - Patch renamed from [PATCH V1 06/10] to [PATCH V2 01/10] -- these
   changes were made to fix checkpatch warnings caused by the patch
   set dependency order
 - Typo s/ther/the/ in commit message
 - Explanation about why KEY_SLEEP was removed (see below)
 - Addition of DA9062 example
 - Addition of a DA9061 example to follow the driver fall-back compatible
   convention being applied for this device driver

Hi,

This patch depends on the acceptance of the main code for the onkey:
  [PATCH V2 07/10] Input: da9061: onkey driver.

The device driver no longer supports KEY_SLEEP. It only supports
KEY_POWER. This change was sent a while ago for the DA9063 ONKEY driver,
but the docs were not updated.

Supporting KEY_SLEEP was not the general convention and the typical
solution should have been for KEY_POWER to support both cases of suspend
and S/W power off.

There is also new binding examples for DA9062 and DA9061. Importantly,
the Linux device driver changes for DA9061 were rejected because the
DA9062 device driver can be reused. For this reason, the DA9061 example
uses a fall-back compatible string.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 .../devicetree/bindings/input/da9062-onkey.txt     | 39 +++++++++++++++-------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
index ab0e048..e5a0469 100644
--- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
+++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
@@ -1,32 +1,47 @@
-* Dialog DA9062/63 OnKey Module
+* Dialog DA9061/62/63 OnKey Module
 
-This module is part of the DA9062/DA9063. For more details about entire
-chips see Documentation/devicetree/bindings/mfd/da9062.txt and
-Documentation/devicetree/bindings/mfd/da9063.txt
+This module is part of the DA9061/DA9062/DA9063. For more details about entire
+DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
+For DA9063 see Documentation/devicetree/bindings/mfd/da9063.txt
 
-This module provides KEY_POWER, KEY_SLEEP and events.
+This module provides the KEY_POWER event.
 
 Required properties:
 
 - compatible: should be one of:
+	dlg,da9061-onkey
 	dlg,da9062-onkey
 	dlg,da9063-onkey
 
 Optional properties:
 
-  - dlg,disable-key-power : Disable power-down using a long key-press. If this
+- dlg,disable-key-power : Disable power-down using a long key-press. If this
     entry exists the OnKey driver will remove support for the KEY_POWER key
-    press. If this entry does not exist then by default the key-press
-    triggered power down is enabled and the OnKey will support both KEY_POWER
-    and KEY_SLEEP.
+    press when triggered using a long press of the OnKey.
 
-Example:
-
-	pmic0: da9062@58 {
+Example: DA9063
 
+	pmic0: da9063@58 {
 		onkey {
 			compatible = "dlg,da9063-onkey";
 			dlg,disable-key-power;
 		};
+	};
+
+Example: DA9062
+
+	pmic0: da9062@58 {
+		onkey {
+			compatible = "dlg,da9062-onkey";
+			dlg,disable-key-power;
+		};
+	};
+
+Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
 
+	pmic0: da9061@58 {
+		onkey {
+			compatible = "dlg,da9061-onkey", "dlg,da9062-onkey";
+			dlg,disable-key-power;
+		};
 	};
-- 
end-of-patch for PATCH V2
