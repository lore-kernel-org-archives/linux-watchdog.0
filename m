Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758909Ab2EXUHt (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 May 2012 16:07:49 -0400
Message-ID: <4FBE9517.4010402@redhat.com>
Date: Thu, 24 May 2012 22:07:51 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Fwd: [lm-sensors] [patch] watchdog: sch56xx-common: set correct bits
 in register()
References: <20120524155802.GB11037@elgon.mountain>
In-Reply-To: <20120524155802.GB11037@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

Thanks for the patch! Since the rest of the watchdog related
sch56xx-common patches, which introduce this problem in the first
place, are going into 3.5 through the watchdog tree, this patch
should probably go in through that tree too -> forwarding this
to linux-watchdog.

Also:
Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




-------- Original Message --------
Subject: [lm-sensors] [patch] watchdog: sch56xx-common: set correct bits in register()
Date: Thu, 24 May 2012 18:58:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jean Delvare <khali@linux-fr.org>
CC: lm-sensors@lm-sensors.org, kernel-janitors@vger.kernel.org

WDOG_NO_WAY_OUT (3) and WDOG_ACTIVE (0) are the bit numbers, not a mask.
So "data->wddev.status |= WDOG_ACTIVE;" was intended to set bit zero but
it is a no-op.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 839087c..4380f5d 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -464,9 +464,9 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
  	data->wddev.min_timeout = 1;
  	data->wddev.max_timeout = 255 * 60;
  	if (nowayout)
-		data->wddev.status |= WDOG_NO_WAY_OUT;
+		set_bit(WDOG_NO_WAY_OUT, &data->wddev.status);
  	if (output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)
-		data->wddev.status |= WDOG_ACTIVE;
+		set_bit(WDOG_ACTIVE, &data->wddev.status);

  	/* Since the watchdog uses a downcounter there is no register to read
  	   the BIOS set timeout from (if any was set at all) ->

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
