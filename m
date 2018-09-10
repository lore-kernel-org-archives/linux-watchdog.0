Return-Path: <jgebben@sweptlaser.com>
Return-path: <jgebben@sweptlaser.com>
From: Jeremy Gebben <jgebben@sweptlaser.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-rtc@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: abx80x: use a 'priv' struct for client data
Date: Mon, 10 Sep 2018 15:36:53 -0600
Message-Id: <20180910213654.26059-2-jgebben@sweptlaser.com>
In-Reply-To: <20180910213654.26059-1-jgebben@sweptlaser.com>
References: <20180910213654.26059-1-jgebben@sweptlaser.com>
List-ID: <linux-watchdog@vger.kernel.org>

This will allow additional data to be tracked, for future
improvements.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/rtc/rtc-abx80x.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 2cefa67a1132..9d49054a0a4a 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -94,6 +94,11 @@ static struct abx80x_cap abx80x_caps[] = {
 	[ABX80X] = {.pn = 0}
 };
 
+struct abx80x_priv {
+	struct rtc_device *rtc;
+	struct i2c_client *client;
+};
+
 static int abx80x_is_rc_mode(struct i2c_client *client)
 {
 	int flags = 0;
@@ -218,7 +223,8 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
-	struct rtc_device *rtc = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct rtc_device *rtc = priv->rtc;
 	int status;
 
 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
@@ -533,7 +539,7 @@ static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct device_node *np = client->dev.of_node;
-	struct rtc_device *rtc;
+	struct abx80x_priv *priv;
 	int i, data, err, trickle_cfg = -EINVAL;
 	char buf[7];
 	unsigned int part = id->driver_data;
@@ -610,13 +616,18 @@ static int abx80x_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	priv->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(priv->rtc))
+		return PTR_ERR(priv->rtc);
 
-	rtc->ops = &abx80x_rtc_ops;
+	priv->rtc->ops = &abx80x_rtc_ops;
+	priv->client = client;
 
-	i2c_set_clientdata(client, rtc);
+	i2c_set_clientdata(client, priv);
 
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
@@ -649,7 +660,7 @@ static int abx80x_probe(struct i2c_client *client,
 		return err;
 	}
 
-	err = rtc_register_device(rtc);
+	err = rtc_register_device(priv->rtc);
 
 	return err;
 }
-- 
2.17.1
