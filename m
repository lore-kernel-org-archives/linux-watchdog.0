Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:55938 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbcGENYr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 09:24:47 -0400
From: Stefan Christ <s.christ@phytec.de>
To: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [RFC 3/6] i2c-imx: add blocking xfer function
Date: Tue, 5 Jul 2016 15:22:20 +0200
Message-Id: <1467724943-13416-4-git-send-email-s.christ@phytec.de>
In-Reply-To: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Implement a blocking i2c xfer function that does not call schedule() and
does not rely on acquiring locks. The caller must ensure that there is
no concurrent user.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
 drivers/i2c/busses/i2c-imx.c | 108 ++++++++++++++++++++++++++++++++-----------
 include/linux/i2c.h          |   2 +
 2 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a53a7dd..49104b0 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -412,7 +412,7 @@ static void i2c_imx_dma_free(struct imx_i2c_struct *i2c_imx)
 /** Functions for IMX I2C adapter driver ***************************************
 *******************************************************************************/
 
-static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
+static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy, bool blocking)
 {
 	unsigned long orig_jiffies = jiffies;
 	unsigned int temp;
@@ -438,15 +438,41 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 				"<%s> I2C bus is busy\n", __func__);
 			return -ETIMEDOUT;
 		}
-		schedule();
+		if (!blocking) {
+			schedule();
+		} else {
+			printk("%s: delay\n", __func__);
+			udelay(100);
+		}
 	}
 
 	return 0;
 }
 
-static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_trx_complete(struct imx_i2c_struct *i2c_imx, bool blocking)
 {
-	wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ / 10);
+	if (!blocking) {
+		wait_event_timeout(i2c_imx->queue, i2c_imx->i2csr & I2SR_IIF, HZ / 10);
+	} else {
+		int counter = 0;
+		unsigned int reg;
+
+		while (1) {
+			printk("%s: try %d\n", __func__, counter);
+			reg = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
+			i2c_imx->i2csr = reg;
+			if (reg & I2SR_IIF)
+				break;
+
+			if (counter > 1000) {
+				dev_err(&i2c_imx->adapter.dev, "<%s> TXR timeout\n", __func__);
+				return -EIO;
+			}
+			udelay(100);
+			counter++;
+		}
+		imx_i2c_write_reg(0, i2c_imx, IMX_I2C_I2SR);
+	}
 
 	if (unlikely(!(i2c_imx->i2csr & I2SR_IIF))) {
 		dev_dbg(&i2c_imx->adapter.dev, "<%s> Timeout\n", __func__);
@@ -511,7 +537,7 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx)
 #endif
 }
 
-static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
+static int i2c_imx_start(struct imx_i2c_struct *i2c_imx, bool blocking)
 {
 	unsigned int temp = 0;
 	int result;
@@ -535,18 +561,24 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 	temp |= I2CR_MSTA;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-	result = i2c_imx_bus_busy(i2c_imx, 1);
+	result = i2c_imx_bus_busy(i2c_imx, 1, blocking);
 	if (result)
 		return result;
 	i2c_imx->stopped = 0;
 
-	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
+	if (!blocking) {
+		temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
+	} else {
+		temp |= I2CR_MTX | I2CR_TXAK;
+		temp &= ~I2CR_IIEN; /* Disable interrupt */
+	}
+
 	temp &= ~I2CR_DMAEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	return result;
 }
 
-static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
+static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx, bool blocking)
 {
 	unsigned int temp = 0;
 
@@ -568,7 +600,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 	}
 
 	if (!i2c_imx->stopped) {
-		i2c_imx_bus_busy(i2c_imx, 0);
+		i2c_imx_bus_busy(i2c_imx, 0, blocking);
 		i2c_imx->stopped = 1;
 	}
 
@@ -653,7 +685,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	/* The last data byte must be transferred by the CPU. */
 	imx_i2c_write_reg(msgs->buf[msgs->len-1],
 				i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx);
+	result = i2c_imx_trx_complete(i2c_imx, false);
 	if (result)
 		return result;
 
@@ -716,7 +748,7 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 
 	msgs->buf[msgs->len-2] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
 	/* read n byte data */
-	result = i2c_imx_trx_complete(i2c_imx);
+	result = i2c_imx_trx_complete(i2c_imx, false);
 	if (result)
 		return result;
 
@@ -729,7 +761,7 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 		temp &= ~(I2CR_MSTA | I2CR_MTX);
 		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-		i2c_imx_bus_busy(i2c_imx, 0);
+		i2c_imx_bus_busy(i2c_imx, 0, false);
 		i2c_imx->stopped = 1;
 	} else {
 		/*
@@ -748,7 +780,7 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	return 0;
 }
 
-static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bool blocking)
 {
 	int i, result;
 
@@ -757,7 +789,7 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 
 	/* write slave address */
 	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx);
+	result = i2c_imx_trx_complete(i2c_imx, blocking);
 	if (result)
 		return result;
 	result = i2c_imx_acked(i2c_imx);
@@ -771,7 +803,7 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
 			"<%s> write byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
 		imx_i2c_write_reg(msgs->buf[i], i2c_imx, IMX_I2C_I2DR);
-		result = i2c_imx_trx_complete(i2c_imx);
+		result = i2c_imx_trx_complete(i2c_imx, blocking);
 		if (result)
 			return result;
 		result = i2c_imx_acked(i2c_imx);
@@ -793,7 +825,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 
 	/* write slave address */
 	imx_i2c_write_reg((msgs->addr << 1) | 0x01, i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx);
+	result = i2c_imx_trx_complete(i2c_imx, false);
 	if (result)
 		return result;
 	result = i2c_imx_acked(i2c_imx);
@@ -824,7 +856,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	for (i = 0; i < msgs->len; i++) {
 		u8 len = 0;
 
-		result = i2c_imx_trx_complete(i2c_imx);
+		result = i2c_imx_trx_complete(i2c_imx, false);
 		if (result)
 			return result;
 		/*
@@ -852,7 +884,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 				temp &= ~(I2CR_MSTA | I2CR_MTX);
 				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-				i2c_imx_bus_busy(i2c_imx, 0);
+				i2c_imx_bus_busy(i2c_imx, 0, false);
 				i2c_imx->stopped = 1;
 			} else {
 				/*
@@ -884,8 +916,8 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	return 0;
 }
 
-static int i2c_imx_xfer(struct i2c_adapter *adapter,
-						struct i2c_msg *msgs, int num)
+static int i2c_imx_xfer_s(struct i2c_adapter *adapter,
+						struct i2c_msg *msgs, int num, bool blocking)
 {
 	unsigned int i, temp;
 	int result;
@@ -895,7 +927,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
 
 	/* Start I2C transfer */
-	result = i2c_imx_start(i2c_imx);
+	result = i2c_imx_start(i2c_imx, blocking);
 	if (result)
 		goto fail0;
 
@@ -910,7 +942,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
 			temp |= I2CR_RSTA;
 			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-			result =  i2c_imx_bus_busy(i2c_imx, 1);
+			result =  i2c_imx_bus_busy(i2c_imx, 1, blocking);
 			if (result)
 				goto fail0;
 		}
@@ -935,12 +967,19 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			(temp & I2SR_RXAK ? 1 : 0));
 #endif
 		if (msgs[i].flags & I2C_M_RD)
-			result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg);
-		else {
-			if (i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD)
-				result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
+			if (!blocking)
+				result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg);
 			else
-				result = i2c_imx_write(i2c_imx, &msgs[i]);
+				return -EPERM; /* not implemented */
+		else {
+			if (!blocking) {
+				if (i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD)
+					result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
+				else
+					result = i2c_imx_write(i2c_imx, &msgs[i], blocking);
+			} else {
+				result = i2c_imx_write(i2c_imx, &msgs[i], blocking);
+			}
 		}
 		if (result)
 			goto fail0;
@@ -948,7 +987,7 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 fail0:
 	/* Stop I2C transfer */
-	i2c_imx_stop(i2c_imx);
+	i2c_imx_stop(i2c_imx, blocking);
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
 		(result < 0) ? "error" : "success msg",
@@ -956,6 +995,18 @@ fail0:
 	return (result < 0) ? result : num;
 }
 
+static int i2c_imx_xfer(struct i2c_adapter *adapter,
+						struct i2c_msg *msgs, int num)
+{
+	return i2c_imx_xfer_s(adapter, msgs, num, false);
+}
+
+static int i2c_imx_xfer_blocking(struct i2c_adapter *adapter,
+						struct i2c_msg *msgs, int num)
+{
+	return i2c_imx_xfer_s(adapter, msgs, num, true);
+}
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -964,6 +1015,7 @@ static u32 i2c_imx_func(struct i2c_adapter *adapter)
 
 static struct i2c_algorithm i2c_imx_algo = {
 	.master_xfer	= i2c_imx_xfer,
+	.master_xfer_blocking	= i2c_imx_xfer_blocking,
 	.functionality	= i2c_imx_func,
 };
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738..8461841 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -397,6 +397,8 @@ struct i2c_algorithm {
 	   processed, or a negative value on error */
 	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   int num);
+	int (*master_xfer_blocking)(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			   int num);
 	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
 			   unsigned short flags, char read_write,
 			   u8 command, int size, union i2c_smbus_data *data);
-- 
1.9.1

