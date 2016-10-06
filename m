Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.137]:26363 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966947AbcJFJKO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Oct 2016 05:10:14 -0400
Message-ID: <313a15d14dd20a8cb8ac99a4cd423798343c5b65.1475743411.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 6 Oct 2016 09:43:30 +0100
Subject: [PATCH V1 06/10] Documentation: dt: input: temperature driver
To: DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC: Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
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

Add binding information for DA9061 onkey.

This patch updates the compatible string "dlg,da9061-onkey" to support
DA9061, removes ther reference to KEY_SLEEP (which the driver no longer
supports) and fixes a typo in the example.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Hi,

This patch depends on the acceptance of the main code for the onkey:
  [PATCH V1 3/10] Input: da9061: onkey driver.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 .../devicetree/bindings/input/da9062-onkey.txt        | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/da9062-onkey.txt b/Documentation/devicetree/bindings/input/da9062-onkey.txt
index ab0e048..ce45436 100644
--- a/Documentation/devicetree/bindings/input/da9062-onkey.txt
+++ b/Documentation/devicetree/bindings/input/da9062-onkey.txt
@@ -1,28 +1,27 @@
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
 
 Example:
 
-	pmic0: da9062@58 {
+	pmic0: da9063@58 {
 
 		onkey {
 			compatible = "dlg,da9063-onkey";
-- 
end-of-patch for PATCH V1

