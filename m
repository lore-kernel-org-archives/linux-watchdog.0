Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35038 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbdJGCeX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Oct 2017 22:34:23 -0400
From: sathyanarayanan.kuppuswamy@linux.intel.com
To: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com
Cc: linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sathyaosid@gmail.com,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v4 6/8] platform/x86: intel_punit_ipc: Use generic intel ipc device calls
Date: Fri,  6 Oct 2017 19:34:00 -0700
Message-Id: <84ed3b65f48989ace50b0faeeed8219476620a09.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Removed redundant IPC helper functions and refactored the driver to use
APIs provided by generic IPC driver. This patch also cleans-up PUNIT IPC
user drivers(intel_telemetry_pltdrv.c) to use APIs provided by generic IPC
driver.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/intel_punit_ipc.h        | 125 +++++------
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/intel_punit_ipc.c        | 303 ++++++++++----------------
 drivers/platform/x86/intel_telemetry_pltdrv.c |  97 +++++----
 4 files changed, 223 insertions(+), 303 deletions(-)

Changes since v2:
 * Added unique name to PUNIT BIOS, GTD, & ISP regmaps.
 * Added intel_ipc_dev_put() support.

Changes since v1:
 * Removed custom APIs.
 * Cleaned up PUNIT IPC user drivers to use APIs provided by generic
   IPC driver.

diff --git a/arch/x86/include/asm/intel_punit_ipc.h b/arch/x86/include/asm/intel_punit_ipc.h
index 201eb9d..cf1630c 100644
--- a/arch/x86/include/asm/intel_punit_ipc.h
+++ b/arch/x86/include/asm/intel_punit_ipc.h
@@ -1,10 +1,8 @@
 #ifndef _ASM_X86_INTEL_PUNIT_IPC_H_
 #define  _ASM_X86_INTEL_PUNIT_IPC_H_
 
-/*
- * Three types of 8bit P-Unit IPC commands are supported,
- * bit[7:6]: [00]: BIOS; [01]: GTD; [10]: ISPD.
- */
+#include <linux/platform_data/x86/intel_ipc_dev.h>
+
 typedef enum {
 	BIOS_IPC = 0,
 	GTDRIVER_IPC,
@@ -12,61 +10,60 @@ typedef enum {
 	RESERVED_IPC,
 } IPC_TYPE;
 
-#define IPC_TYPE_OFFSET			6
-#define IPC_PUNIT_BIOS_CMD_BASE		(BIOS_IPC << IPC_TYPE_OFFSET)
-#define IPC_PUNIT_GTD_CMD_BASE		(GTDDRIVER_IPC << IPC_TYPE_OFFSET)
-#define IPC_PUNIT_ISPD_CMD_BASE		(ISPDRIVER_IPC << IPC_TYPE_OFFSET)
-#define IPC_PUNIT_CMD_TYPE_MASK		(RESERVED_IPC << IPC_TYPE_OFFSET)
+#define PUNIT_BIOS_IPC_DEV			"punit_bios_ipc"
+#define PUNIT_GTD_IPC_DEV			"punit_gtd_ipc"
+#define PUNIT_ISP_IPC_DEV			"punit_isp_ipc"
+#define PUNIT_PARAM_LEN				3
 
 /* BIOS => Pcode commands */
-#define IPC_PUNIT_BIOS_ZERO			(IPC_PUNIT_BIOS_CMD_BASE | 0x00)
-#define IPC_PUNIT_BIOS_VR_INTERFACE		(IPC_PUNIT_BIOS_CMD_BASE | 0x01)
-#define IPC_PUNIT_BIOS_READ_PCS			(IPC_PUNIT_BIOS_CMD_BASE | 0x02)
-#define IPC_PUNIT_BIOS_WRITE_PCS		(IPC_PUNIT_BIOS_CMD_BASE | 0x03)
-#define IPC_PUNIT_BIOS_READ_PCU_CONFIG		(IPC_PUNIT_BIOS_CMD_BASE | 0x04)
-#define IPC_PUNIT_BIOS_WRITE_PCU_CONFIG		(IPC_PUNIT_BIOS_CMD_BASE | 0x05)
-#define IPC_PUNIT_BIOS_READ_PL1_SETTING		(IPC_PUNIT_BIOS_CMD_BASE | 0x06)
-#define IPC_PUNIT_BIOS_WRITE_PL1_SETTING	(IPC_PUNIT_BIOS_CMD_BASE | 0x07)
-#define IPC_PUNIT_BIOS_TRIGGER_VDD_RAM		(IPC_PUNIT_BIOS_CMD_BASE | 0x08)
-#define IPC_PUNIT_BIOS_READ_TELE_INFO		(IPC_PUNIT_BIOS_CMD_BASE | 0x09)
-#define IPC_PUNIT_BIOS_READ_TELE_TRACE_CTRL	(IPC_PUNIT_BIOS_CMD_BASE | 0x0a)
-#define IPC_PUNIT_BIOS_WRITE_TELE_TRACE_CTRL	(IPC_PUNIT_BIOS_CMD_BASE | 0x0b)
-#define IPC_PUNIT_BIOS_READ_TELE_EVENT_CTRL	(IPC_PUNIT_BIOS_CMD_BASE | 0x0c)
-#define IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL	(IPC_PUNIT_BIOS_CMD_BASE | 0x0d)
-#define IPC_PUNIT_BIOS_READ_TELE_TRACE		(IPC_PUNIT_BIOS_CMD_BASE | 0x0e)
-#define IPC_PUNIT_BIOS_WRITE_TELE_TRACE		(IPC_PUNIT_BIOS_CMD_BASE | 0x0f)
-#define IPC_PUNIT_BIOS_READ_TELE_EVENT		(IPC_PUNIT_BIOS_CMD_BASE | 0x10)
-#define IPC_PUNIT_BIOS_WRITE_TELE_EVENT		(IPC_PUNIT_BIOS_CMD_BASE | 0x11)
-#define IPC_PUNIT_BIOS_READ_MODULE_TEMP		(IPC_PUNIT_BIOS_CMD_BASE | 0x12)
-#define IPC_PUNIT_BIOS_RESERVED			(IPC_PUNIT_BIOS_CMD_BASE | 0x13)
-#define IPC_PUNIT_BIOS_READ_VOLTAGE_OVER	(IPC_PUNIT_BIOS_CMD_BASE | 0x14)
-#define IPC_PUNIT_BIOS_WRITE_VOLTAGE_OVER	(IPC_PUNIT_BIOS_CMD_BASE | 0x15)
-#define IPC_PUNIT_BIOS_READ_RATIO_OVER		(IPC_PUNIT_BIOS_CMD_BASE | 0x16)
-#define IPC_PUNIT_BIOS_WRITE_RATIO_OVER		(IPC_PUNIT_BIOS_CMD_BASE | 0x17)
-#define IPC_PUNIT_BIOS_READ_VF_GL_CTRL		(IPC_PUNIT_BIOS_CMD_BASE | 0x18)
-#define IPC_PUNIT_BIOS_WRITE_VF_GL_CTRL		(IPC_PUNIT_BIOS_CMD_BASE | 0x19)
-#define IPC_PUNIT_BIOS_READ_FM_SOC_TEMP_THRESH	(IPC_PUNIT_BIOS_CMD_BASE | 0x1a)
-#define IPC_PUNIT_BIOS_WRITE_FM_SOC_TEMP_THRESH	(IPC_PUNIT_BIOS_CMD_BASE | 0x1b)
+#define IPC_PUNIT_BIOS_ZERO			(0x00)
+#define IPC_PUNIT_BIOS_VR_INTERFACE		(0x01)
+#define IPC_PUNIT_BIOS_READ_PCS			(0x02)
+#define IPC_PUNIT_BIOS_WRITE_PCS		(0x03)
+#define IPC_PUNIT_BIOS_READ_PCU_CONFIG		(0x04)
+#define IPC_PUNIT_BIOS_WRITE_PCU_CONFIG		(0x05)
+#define IPC_PUNIT_BIOS_READ_PL1_SETTING		(0x06)
+#define IPC_PUNIT_BIOS_WRITE_PL1_SETTING	(0x07)
+#define IPC_PUNIT_BIOS_TRIGGER_VDD_RAM		(0x08)
+#define IPC_PUNIT_BIOS_READ_TELE_INFO		(0x09)
+#define IPC_PUNIT_BIOS_READ_TELE_TRACE_CTRL	(0x0a)
+#define IPC_PUNIT_BIOS_WRITE_TELE_TRACE_CTRL	(0x0b)
+#define IPC_PUNIT_BIOS_READ_TELE_EVENT_CTRL	(0x0c)
+#define IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL	(0x0d)
+#define IPC_PUNIT_BIOS_READ_TELE_TRACE		(0x0e)
+#define IPC_PUNIT_BIOS_WRITE_TELE_TRACE		(0x0f)
+#define IPC_PUNIT_BIOS_READ_TELE_EVENT		(0x10)
+#define IPC_PUNIT_BIOS_WRITE_TELE_EVENT		(0x11)
+#define IPC_PUNIT_BIOS_READ_MODULE_TEMP		(0x12)
+#define IPC_PUNIT_BIOS_RESERVED			(0x13)
+#define IPC_PUNIT_BIOS_READ_VOLTAGE_OVER	(0x14)
+#define IPC_PUNIT_BIOS_WRITE_VOLTAGE_OVER	(0x15)
+#define IPC_PUNIT_BIOS_READ_RATIO_OVER		(0x16)
+#define IPC_PUNIT_BIOS_WRITE_RATIO_OVER		(0x17)
+#define IPC_PUNIT_BIOS_READ_VF_GL_CTRL		(0x18)
+#define IPC_PUNIT_BIOS_WRITE_VF_GL_CTRL		(0x19)
+#define IPC_PUNIT_BIOS_READ_FM_SOC_TEMP_THRESH	(0x1a)
+#define IPC_PUNIT_BIOS_WRITE_FM_SOC_TEMP_THRESH	(0x1b)
 
 /* GT Driver => Pcode commands */
-#define IPC_PUNIT_GTD_ZERO			(IPC_PUNIT_GTD_CMD_BASE | 0x00)
-#define IPC_PUNIT_GTD_CONFIG			(IPC_PUNIT_GTD_CMD_BASE | 0x01)
-#define IPC_PUNIT_GTD_READ_ICCP_LIC_CDYN_SCAL	(IPC_PUNIT_GTD_CMD_BASE | 0x02)
-#define IPC_PUNIT_GTD_WRITE_ICCP_LIC_CDYN_SCAL	(IPC_PUNIT_GTD_CMD_BASE | 0x03)
-#define IPC_PUNIT_GTD_GET_WM_VAL		(IPC_PUNIT_GTD_CMD_BASE | 0x06)
-#define IPC_PUNIT_GTD_WRITE_CONFIG_WISHREQ	(IPC_PUNIT_GTD_CMD_BASE | 0x07)
-#define IPC_PUNIT_GTD_READ_REQ_DUTY_CYCLE	(IPC_PUNIT_GTD_CMD_BASE | 0x16)
-#define IPC_PUNIT_GTD_DIS_VOL_FREQ_CHG_REQUEST	(IPC_PUNIT_GTD_CMD_BASE | 0x17)
-#define IPC_PUNIT_GTD_DYNA_DUTY_CYCLE_CTRL	(IPC_PUNIT_GTD_CMD_BASE | 0x1a)
-#define IPC_PUNIT_GTD_DYNA_DUTY_CYCLE_TUNING	(IPC_PUNIT_GTD_CMD_BASE | 0x1c)
+#define IPC_PUNIT_GTD_ZERO			(0x00)
+#define IPC_PUNIT_GTD_CONFIG			(0x01)
+#define IPC_PUNIT_GTD_READ_ICCP_LIC_CDYN_SCAL	(0x02)
+#define IPC_PUNIT_GTD_WRITE_ICCP_LIC_CDYN_SCAL	(0x03)
+#define IPC_PUNIT_GTD_GET_WM_VAL		(0x06)
+#define IPC_PUNIT_GTD_WRITE_CONFIG_WISHREQ	(0x07)
+#define IPC_PUNIT_GTD_READ_REQ_DUTY_CYCLE	(0x16)
+#define IPC_PUNIT_GTD_DIS_VOL_FREQ_CHG_REQUEST	(0x17)
+#define IPC_PUNIT_GTD_DYNA_DUTY_CYCLE_CTRL	(0x1a)
+#define IPC_PUNIT_GTD_DYNA_DUTY_CYCLE_TUNING	(0x1c)
 
 /* ISP Driver => Pcode commands */
-#define IPC_PUNIT_ISPD_ZERO			(IPC_PUNIT_ISPD_CMD_BASE | 0x00)
-#define IPC_PUNIT_ISPD_CONFIG			(IPC_PUNIT_ISPD_CMD_BASE | 0x01)
-#define IPC_PUNIT_ISPD_GET_ISP_LTR_VAL		(IPC_PUNIT_ISPD_CMD_BASE | 0x02)
-#define IPC_PUNIT_ISPD_ACCESS_IU_FREQ_BOUNDS	(IPC_PUNIT_ISPD_CMD_BASE | 0x03)
-#define IPC_PUNIT_ISPD_READ_CDYN_LEVEL		(IPC_PUNIT_ISPD_CMD_BASE | 0x04)
-#define IPC_PUNIT_ISPD_WRITE_CDYN_LEVEL		(IPC_PUNIT_ISPD_CMD_BASE | 0x05)
+#define IPC_PUNIT_ISPD_ZERO			(0x00)
+#define IPC_PUNIT_ISPD_CONFIG			(0x01)
+#define IPC_PUNIT_ISPD_GET_ISP_LTR_VAL		(0x02)
+#define IPC_PUNIT_ISPD_ACCESS_IU_FREQ_BOUNDS	(0x03)
+#define IPC_PUNIT_ISPD_READ_CDYN_LEVEL		(0x04)
+#define IPC_PUNIT_ISPD_WRITE_CDYN_LEVEL		(0x05)
 
 /* Error codes */
 #define IPC_PUNIT_ERR_SUCCESS			0
@@ -77,25 +74,11 @@ typedef enum {
 #define IPC_PUNIT_ERR_INVALID_VR_ID		5
 #define IPC_PUNIT_ERR_VR_ERR			6
 
-#if IS_ENABLED(CONFIG_INTEL_PUNIT_IPC)
-
-int intel_punit_ipc_simple_command(int cmd, int para1, int para2);
-int intel_punit_ipc_command(u32 cmd, u32 para1, u32 para2, u32 *in, u32 *out);
-
-#else
-
-static inline int intel_punit_ipc_simple_command(int cmd,
-						  int para1, int para2)
+static inline void punit_cmd_init(u32 *cmd, u32 param1, u32 param2, u32 param3)
 {
-	return -ENODEV;
+	cmd[0] = param1;
+	cmd[1] = param2;
+	cmd[2] = param3;
 }
 
-static inline int intel_punit_ipc_command(u32 cmd, u32 para1, u32 para2,
-					  u32 *in, u32 *out)
-{
-	return -ENODEV;
-}
-
-#endif /* CONFIG_INTEL_PUNIT_IPC */
-
 #endif
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 724ee696..9442c23 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1096,6 +1096,7 @@ config SURFACE_3_BUTTON
 
 config INTEL_PUNIT_IPC
 	tristate "Intel P-Unit IPC Driver"
+	select REGMAP_MMIO
 	---help---
 	  This driver provides support for Intel P-Unit Mailbox IPC mechanism,
 	  which is used to bridge the communications between kernel and P-Unit.
diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
index b5b8901..f310a05 100644
--- a/drivers/platform/x86/intel_punit_ipc.c
+++ b/drivers/platform/x86/intel_punit_ipc.c
@@ -18,18 +18,18 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/x86/intel_ipc_dev.h>
+#include <linux/regmap.h>
 #include <asm/intel_punit_ipc.h>
 
-/* IPC Mailbox registers */
-#define OFFSET_DATA_LOW		0x0
-#define OFFSET_DATA_HIGH	0x4
 /* bit field of interface register */
 #define	CMD_RUN			BIT(31)
-#define	CMD_ERRCODE_MASK	GENMASK(7, 0)
+#define CMD_ERRCODE_MASK	GENMASK(7, 0)
 #define	CMD_PARA1_SHIFT		8
 #define	CMD_PARA2_SHIFT		16
 
-#define CMD_TIMEOUT_SECONDS	1
+/* IPC PUNIT commands */
+#define	IPC_DEV_PUNIT_CMD_STATUS_ERR_MASK	GENMASK(7, 0)
 
 enum {
 	BASE_DATA = 0,
@@ -39,187 +39,42 @@ enum {
 
 typedef struct {
 	struct device *dev;
-	struct mutex lock;
-	int irq;
-	struct completion cmd_complete;
 	/* base of interface and data registers */
 	void __iomem *base[RESERVED_IPC][BASE_MAX];
+	struct intel_ipc_dev *ipc_dev[RESERVED_IPC];
 	IPC_TYPE type;
 } IPC_DEV;
 
 static IPC_DEV *punit_ipcdev;
 
-static inline u32 ipc_read_status(IPC_DEV *ipcdev, IPC_TYPE type)
-{
-	return readl(ipcdev->base[type][BASE_IFACE]);
-}
-
-static inline void ipc_write_cmd(IPC_DEV *ipcdev, IPC_TYPE type, u32 cmd)
-{
-	writel(cmd, ipcdev->base[type][BASE_IFACE]);
-}
-
-static inline u32 ipc_read_data_low(IPC_DEV *ipcdev, IPC_TYPE type)
-{
-	return readl(ipcdev->base[type][BASE_DATA] + OFFSET_DATA_LOW);
-}
-
-static inline u32 ipc_read_data_high(IPC_DEV *ipcdev, IPC_TYPE type)
-{
-	return readl(ipcdev->base[type][BASE_DATA] + OFFSET_DATA_HIGH);
-}
-
-static inline void ipc_write_data_low(IPC_DEV *ipcdev, IPC_TYPE type, u32 data)
-{
-	writel(data, ipcdev->base[type][BASE_DATA] + OFFSET_DATA_LOW);
-}
-
-static inline void ipc_write_data_high(IPC_DEV *ipcdev, IPC_TYPE type, u32 data)
-{
-	writel(data, ipcdev->base[type][BASE_DATA] + OFFSET_DATA_HIGH);
-}
+const char *ipc_dev_name[RESERVED_IPC] = {
+	PUNIT_BIOS_IPC_DEV,
+	PUNIT_GTD_IPC_DEV,
+	PUNIT_ISP_IPC_DEV
+};
 
-static const char *ipc_err_string(int error)
-{
-	if (error == IPC_PUNIT_ERR_SUCCESS)
-		return "no error";
-	else if (error == IPC_PUNIT_ERR_INVALID_CMD)
-		return "invalid command";
-	else if (error == IPC_PUNIT_ERR_INVALID_PARAMETER)
-		return "invalid parameter";
-	else if (error == IPC_PUNIT_ERR_CMD_TIMEOUT)
-		return "command timeout";
-	else if (error == IPC_PUNIT_ERR_CMD_LOCKED)
-		return "command locked";
-	else if (error == IPC_PUNIT_ERR_INVALID_VR_ID)
-		return "invalid vr id";
-	else if (error == IPC_PUNIT_ERR_VR_ERR)
-		return "vr error";
-	else
-		return "unknown error";
-}
+static struct regmap_config punit_regmap_config = {
+        .reg_bits = 32,
+        .reg_stride = 4,
+        .val_bits = 32,
+};
 
-static int intel_punit_ipc_check_status(IPC_DEV *ipcdev, IPC_TYPE type)
+int pre_simple_cmd_fn(u32 *cmd_list, u32 cmdlen)
 {
-	int loops = CMD_TIMEOUT_SECONDS * USEC_PER_SEC;
-	int errcode;
-	int status;
-
-	if (ipcdev->irq) {
-		if (!wait_for_completion_timeout(&ipcdev->cmd_complete,
-						 CMD_TIMEOUT_SECONDS * HZ)) {
-			dev_err(ipcdev->dev, "IPC timed out\n");
-			return -ETIMEDOUT;
-		}
-	} else {
-		while ((ipc_read_status(ipcdev, type) & CMD_RUN) && --loops)
-			udelay(1);
-		if (!loops) {
-			dev_err(ipcdev->dev, "IPC timed out\n");
-			return -ETIMEDOUT;
-		}
-	}
+	if (!cmd_list || cmdlen != PUNIT_PARAM_LEN)
+		return -EINVAL;
 
-	status = ipc_read_status(ipcdev, type);
-	errcode = status & CMD_ERRCODE_MASK;
-	if (errcode) {
-		dev_err(ipcdev->dev, "IPC failed: %s, IPC_STS=0x%x\n",
-			ipc_err_string(errcode), status);
-		return -EIO;
-	}
+	cmd_list[0] |= CMD_RUN | cmd_list[1] << CMD_PARA1_SHIFT |
+		cmd_list[2] << CMD_PARA1_SHIFT;
 
 	return 0;
 }
 
-/**
- * intel_punit_ipc_simple_command() - Simple IPC command
- * @cmd:	IPC command code.
- * @para1:	First 8bit parameter, set 0 if not used.
- * @para2:	Second 8bit parameter, set 0 if not used.
- *
- * Send a IPC command to P-Unit when there is no data transaction
- *
- * Return:	IPC error code or 0 on success.
- */
-int intel_punit_ipc_simple_command(int cmd, int para1, int para2)
-{
-	IPC_DEV *ipcdev = punit_ipcdev;
-	IPC_TYPE type;
-	u32 val;
-	int ret;
-
-	mutex_lock(&ipcdev->lock);
-
-	reinit_completion(&ipcdev->cmd_complete);
-	type = (cmd & IPC_PUNIT_CMD_TYPE_MASK) >> IPC_TYPE_OFFSET;
-
-	val = cmd & ~IPC_PUNIT_CMD_TYPE_MASK;
-	val |= CMD_RUN | para2 << CMD_PARA2_SHIFT | para1 << CMD_PARA1_SHIFT;
-	ipc_write_cmd(ipcdev, type, val);
-	ret = intel_punit_ipc_check_status(ipcdev, type);
-
-	mutex_unlock(&ipcdev->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(intel_punit_ipc_simple_command);
-
-/**
- * intel_punit_ipc_command() - IPC command with data and pointers
- * @cmd:	IPC command code.
- * @para1:	First 8bit parameter, set 0 if not used.
- * @para2:	Second 8bit parameter, set 0 if not used.
- * @in:		Input data, 32bit for BIOS cmd, two 32bit for GTD and ISPD.
- * @out:	Output data.
- *
- * Send a IPC command to P-Unit with data transaction
- *
- * Return:	IPC error code or 0 on success.
- */
-int intel_punit_ipc_command(u32 cmd, u32 para1, u32 para2, u32 *in, u32 *out)
-{
-	IPC_DEV *ipcdev = punit_ipcdev;
-	IPC_TYPE type;
-	u32 val;
-	int ret;
-
-	mutex_lock(&ipcdev->lock);
-
-	reinit_completion(&ipcdev->cmd_complete);
-	type = (cmd & IPC_PUNIT_CMD_TYPE_MASK) >> IPC_TYPE_OFFSET;
-
-	if (in) {
-		ipc_write_data_low(ipcdev, type, *in);
-		if (type == GTDRIVER_IPC || type == ISPDRIVER_IPC)
-			ipc_write_data_high(ipcdev, type, *++in);
-	}
-
-	val = cmd & ~IPC_PUNIT_CMD_TYPE_MASK;
-	val |= CMD_RUN | para2 << CMD_PARA2_SHIFT | para1 << CMD_PARA1_SHIFT;
-	ipc_write_cmd(ipcdev, type, val);
-
-	ret = intel_punit_ipc_check_status(ipcdev, type);
-	if (ret)
-		goto out;
-
-	if (out) {
-		*out = ipc_read_data_low(ipcdev, type);
-		if (type == GTDRIVER_IPC || type == ISPDRIVER_IPC)
-			*++out = ipc_read_data_high(ipcdev, type);
-	}
-
-out:
-	mutex_unlock(&ipcdev->lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(intel_punit_ipc_command);
-
-static irqreturn_t intel_punit_ioc(int irq, void *dev_id)
+/* Input data, 32bit for BIOS cmd, two 32bit for GTD and ISPD. */
+int pre_raw_cmd_fn(u32 *cmd_list, u32 cmdlen, u8 *in, u32 inlen, u32 *out,
+		u32 outlen, u32 dptr, u32 sptr)
 {
-	IPC_DEV *ipcdev = dev_id;
-
-	complete(&ipcdev->cmd_complete);
-	return IRQ_HANDLED;
+	return pre_simple_cmd_fn(cmd_list, cmdlen);
 }
 
 static int intel_punit_get_bars(struct platform_device *pdev)
@@ -282,9 +137,77 @@ static int intel_punit_get_bars(struct platform_device *pdev)
 	return 0;
 }
 
+static int punit_ipc_err_code(int status)
+{
+	return (status & CMD_ERRCODE_MASK);
+}
+
+static int punit_ipc_busy_check(int status)
+{
+	return status | CMD_RUN;
+}
+
+static struct intel_ipc_dev *intel_punit_ipc_dev_create(struct device *dev,
+		const char *devname,
+		int irq,
+		void __iomem *base,
+		void __iomem *data)
+{
+	struct intel_ipc_dev_ops *ops;
+	struct intel_ipc_dev_cfg *cfg;
+	struct regmap *cmd_regs, *data_regs;
+
+        cfg = devm_kzalloc(dev, sizeof(*cfg), GFP_KERNEL);
+        if (!cfg)
+                return ERR_PTR(-ENOMEM);
+
+	ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return ERR_PTR(-ENOMEM);
+
+	punit_regmap_config.name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
+						  devname, "base");
+
+	cmd_regs = devm_regmap_init_mmio_clk(dev, NULL, base,
+			&punit_regmap_config);
+	if (IS_ERR(cmd_regs)) {
+                dev_err(dev, "cmd_regs regmap init failed\n");
+                return ERR_CAST(cmd_regs);;
+        }
+
+	punit_regmap_config.name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
+						  devname, "data");
+
+        data_regs = devm_regmap_init_mmio_clk(dev, NULL, data,
+			&punit_regmap_config);
+        if (IS_ERR(data_regs)) {
+                dev_err(dev, "data_regs regmap init failed\n");
+                return ERR_CAST(data_regs);;
+        }
+
+	/* set IPC dev ops */
+	ops->to_err_code = punit_ipc_err_code;
+	ops->busy_check = punit_ipc_busy_check;
+	ops->pre_simple_cmd_fn = pre_simple_cmd_fn;
+	ops->pre_raw_cmd_fn = pre_raw_cmd_fn;
+
+	if (irq > 0)
+	        cfg->mode = IPC_DEV_MODE_IRQ;
+	else
+	        cfg->mode = IPC_DEV_MODE_POLLING;
+
+	cfg->chan_type = IPC_CHANNEL_IA_PUNIT;
+	cfg->irq = irq;
+	cfg->irqflags = IRQF_NO_SUSPEND | IRQF_SHARED;
+	cfg->cmd_regs = cmd_regs;
+	cfg->data_regs = data_regs;
+
+	return devm_intel_ipc_dev_create(dev, devname, cfg, ops);
+}
+
 static int intel_punit_ipc_probe(struct platform_device *pdev)
 {
-	int irq, ret;
+	int irq, ret, i;
 
 	punit_ipcdev = devm_kzalloc(&pdev->dev,
 				    sizeof(*punit_ipcdev), GFP_KERNEL);
@@ -294,35 +217,30 @@ static int intel_punit_ipc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, punit_ipcdev);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		punit_ipcdev->irq = 0;
-		dev_warn(&pdev->dev, "Invalid IRQ, using polling mode\n");
-	} else {
-		ret = devm_request_irq(&pdev->dev, irq, intel_punit_ioc,
-				       IRQF_NO_SUSPEND, "intel_punit_ipc",
-				       &punit_ipcdev);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request irq: %d\n", irq);
-			return ret;
-		}
-		punit_ipcdev->irq = irq;
-	}
 
 	ret = intel_punit_get_bars(pdev);
 	if (ret)
-		goto out;
+		return ret;
+
+	for (i = 0; i < RESERVED_IPC; i++) {
+		punit_ipcdev->ipc_dev[i] = intel_punit_ipc_dev_create(
+				&pdev->dev,
+				ipc_dev_name[i],
+				irq,
+				punit_ipcdev->base[i][BASE_IFACE],
+				punit_ipcdev->base[i][BASE_DATA]);
+
+		if (IS_ERR(punit_ipcdev->ipc_dev[i])) {
+			dev_err(&pdev->dev, "%s create failed\n",
+					ipc_dev_name[i]);
+			return PTR_ERR(punit_ipcdev->ipc_dev[i]);
+		}
+	}
 
 	punit_ipcdev->dev = &pdev->dev;
-	mutex_init(&punit_ipcdev->lock);
-	init_completion(&punit_ipcdev->cmd_complete);
 
-out:
 	return ret;
-}
 
-static int intel_punit_ipc_remove(struct platform_device *pdev)
-{
-	return 0;
 }
 
 static const struct acpi_device_id punit_ipc_acpi_ids[] = {
@@ -332,7 +250,6 @@ static const struct acpi_device_id punit_ipc_acpi_ids[] = {
 
 static struct platform_driver intel_punit_ipc_driver = {
 	.probe = intel_punit_ipc_probe,
-	.remove = intel_punit_ipc_remove,
 	.driver = {
 		.name = "intel_punit_ipc",
 		.acpi_match_table = ACPI_PTR(punit_ipc_acpi_ids),
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index e0424d5..bf8284a 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -98,6 +98,7 @@ struct telem_ssram_region {
 };
 
 static struct telemetry_plt_config *telm_conf;
+static struct intel_ipc_dev *punit_bios_ipc_dev;
 
 /*
  * The following counters are programmed by default during setup.
@@ -127,7 +128,6 @@ static struct telemetry_evtmap
 	{"PMC_S0IX_BLOCK_IPS_CLOCKS",           0x600B},
 };
 
-
 static struct telemetry_evtmap
 	telemetry_apl_pss_default_events[TELEM_MAX_OS_ALLOCATED_EVENTS] = {
 	{"IA_CORE0_C6_RES",			0x0400},
@@ -283,13 +283,12 @@ static inline int telemetry_plt_config_ioss_event(u32 evt_id, int index)
 static inline int telemetry_plt_config_pss_event(u32 evt_id, int index)
 {
 	u32 write_buf;
-	int ret;
+	u32 cmd[PUNIT_PARAM_LEN] = {0};
 
 	write_buf = evt_id | TELEM_EVENT_ENABLE;
-	ret = intel_punit_ipc_command(IPC_PUNIT_BIOS_WRITE_TELE_EVENT,
-				      index, 0, &write_buf, NULL);
-
-	return ret;
+	punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT, index, 0);
+	return ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+			(u8 *)&write_buf, sizeof(write_buf), NULL, 0, 0, 0);
 }
 
 static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
@@ -435,6 +434,7 @@ static int telemetry_setup_pssevtconfig(struct telemetry_evtconfig evtconfig,
 	int ret, index, idx;
 	u32 *pss_evtmap;
 	u32 telem_ctrl;
+	u32 cmd[PUNIT_PARAM_LEN] = {0};
 
 	num_pss_evts = evtconfig.num_evts;
 	pss_period = evtconfig.period;
@@ -442,8 +442,9 @@ static int telemetry_setup_pssevtconfig(struct telemetry_evtconfig evtconfig,
 
 	/* PSS Config */
 	/* Get telemetry EVENT CTL */
-	ret = intel_punit_ipc_command(IPC_PUNIT_BIOS_READ_TELE_EVENT_CTRL,
-				      0, 0, NULL, &telem_ctrl);
+	punit_cmd_init(cmd, IPC_PUNIT_BIOS_READ_TELE_EVENT_CTRL, 0, 0);
+	ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN, NULL,
+			0, &telem_ctrl, 1, 0, 0);
 	if (ret) {
 		pr_err("PSS TELEM_CTRL Read Failed\n");
 		return ret;
@@ -451,8 +452,9 @@ static int telemetry_setup_pssevtconfig(struct telemetry_evtconfig evtconfig,
 
 	/* Disable Telemetry */
 	TELEM_DISABLE(telem_ctrl);
-	ret = intel_punit_ipc_command(IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
-				      0, 0, &telem_ctrl, NULL);
+	punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL, 0, 0);
+	ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+			(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL, 0, 0, 0);
 	if (ret) {
 		pr_err("PSS TELEM_CTRL Event Disable Write Failed\n");
 		return ret;
@@ -463,9 +465,10 @@ static int telemetry_setup_pssevtconfig(struct telemetry_evtconfig evtconfig,
 		/* Clear All Events */
 		TELEM_CLEAR_EVENTS(telem_ctrl);
 
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
-				0, 0, &telem_ctrl, NULL);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL, 0, 0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
+				0, 0, 0);
 		if (ret) {
 			pr_err("PSS TELEM_CTRL Event Disable Write Failed\n");
 			return ret;
@@ -489,9 +492,10 @@ static int telemetry_setup_pssevtconfig(struct telemetry_evtconfig evtconfig,
 		/* Clear All Events */
 		TELEM_CLEAR_EVENTS(telem_ctrl);
 
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
-				0, 0, &telem_ctrl, NULL);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL, 0, 0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
+				0, 0, 0);
 		if (ret) {
 			pr_err("PSS TELEM_CTRL Event Disable Write Failed\n");
 			return ret;
@@ -540,8 +544,9 @@ static int telemetry_setup_pssevtconfig(struct telemetry_evtconfig evtconfig,
 	TELEM_ENABLE_PERIODIC(telem_ctrl);
 	telem_ctrl |= pss_period;
 
-	ret = intel_punit_ipc_command(IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
-				      0, 0, &telem_ctrl, NULL);
+	punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL, 0, 0);
+	ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+			(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL, 0, 0, 0);
 	if (ret) {
 		pr_err("PSS TELEM_CTRL Event Enable Write Failed\n");
 		return ret;
@@ -601,6 +606,7 @@ static int telemetry_setup(struct platform_device *pdev)
 {
 	struct telemetry_evtconfig pss_evtconfig, ioss_evtconfig;
 	u32 read_buf, events, event_regs;
+	u32 cmd[PUNIT_PARAM_LEN] = {0};
 	int ret;
 
 	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY, IOSS_TELEM_INFO_READ,
@@ -626,8 +632,9 @@ static int telemetry_setup(struct platform_device *pdev)
 	telm_conf->ioss_config.max_period = TELEM_MAX_PERIOD(read_buf);
 
 	/* PUNIT Mailbox Setup */
-	ret = intel_punit_ipc_command(IPC_PUNIT_BIOS_READ_TELE_INFO, 0, 0,
-				      NULL, &read_buf);
+	punit_cmd_init(cmd, IPC_PUNIT_BIOS_READ_TELE_INFO, 0, 0);
+	ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+			NULL, 0, &read_buf, 1, 0, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "PSS TELEM_INFO Read Failed\n");
 		return ret;
@@ -695,6 +702,7 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 {
 	u32 telem_ctrl = 0;
 	int ret = 0;
+	u32 cmd[PUNIT_PARAM_LEN] = {0};
 
 	mutex_lock(&(telm_conf->telem_lock));
 	if (ioss_period) {
@@ -752,9 +760,9 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		}
 
 		/* Get telemetry EVENT CTL */
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_READ_TELE_EVENT_CTRL,
-				0, 0, NULL, &telem_ctrl);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_READ_TELE_EVENT_CTRL, 0, 0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				NULL, 0, &telem_ctrl, 1, 0, 0);
 		if (ret) {
 			pr_err("PSS TELEM_CTRL Read Failed\n");
 			goto out;
@@ -762,9 +770,11 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 
 		/* Disable Telemetry */
 		TELEM_DISABLE(telem_ctrl);
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
-				0, 0, &telem_ctrl, NULL);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL, 0,
+				0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
+				0, 0, 0);
 		if (ret) {
 			pr_err("PSS TELEM_CTRL Event Disable Write Failed\n");
 			goto out;
@@ -776,9 +786,11 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		TELEM_ENABLE_PERIODIC(telem_ctrl);
 		telem_ctrl |= pss_period;
 
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
-				0, 0, &telem_ctrl, NULL);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL, 0,
+				0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
+				0, 0, 0);
 		if (ret) {
 			pr_err("PSS TELEM_CTRL Event Enable Write Failed\n");
 			goto out;
@@ -1013,6 +1025,7 @@ static int telemetry_plt_get_trace_verbosity(enum telemetry_unit telem_unit,
 {
 	u32 temp = 0;
 	int ret;
+	u32 cmd[PUNIT_PARAM_LEN] = {0};
 
 	if (verbosity == NULL)
 		return -EINVAL;
@@ -1020,9 +1033,9 @@ static int telemetry_plt_get_trace_verbosity(enum telemetry_unit telem_unit,
 	mutex_lock(&(telm_conf->telem_trace_lock));
 	switch (telem_unit) {
 	case TELEM_PSS:
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_READ_TELE_TRACE_CTRL,
-				0, 0, NULL, &temp);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_READ_TELE_TRACE_CTRL, 0, 0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				NULL, 0, &temp, 1, 0, 0);
 		if (ret) {
 			pr_err("PSS TRACE_CTRL Read Failed\n");
 			goto out;
@@ -1058,15 +1071,16 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
 {
 	u32 temp = 0;
 	int ret;
+	u32 cmd[PUNIT_PARAM_LEN] = {0};
 
 	verbosity &= TELEM_TRC_VERBOSITY_MASK;
 
 	mutex_lock(&(telm_conf->telem_trace_lock));
 	switch (telem_unit) {
 	case TELEM_PSS:
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_READ_TELE_TRACE_CTRL,
-				0, 0, NULL, &temp);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_READ_TELE_TRACE_CTRL, 0, 0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				NULL, 0, &temp, 1, 0, 0);
 		if (ret) {
 			pr_err("PSS TRACE_CTRL Read Failed\n");
 			goto out;
@@ -1074,10 +1088,10 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
 
 		TELEM_CLEAR_VERBOSITY_BITS(temp);
 		TELEM_SET_VERBOSITY_BITS(temp, verbosity);
-
-		ret = intel_punit_ipc_command(
-				IPC_PUNIT_BIOS_WRITE_TELE_TRACE_CTRL,
-				0, 0, &temp, NULL);
+		punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT_CTRL,
+				0, 0);
+		ret = ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd, PUNIT_PARAM_LEN,
+				(u8 *)&temp, sizeof(temp), NULL, 0, 0, 0);
 		if (ret) {
 			pr_err("PSS TRACE_CTRL Verbosity Set Failed\n");
 			goto out;
@@ -1139,6 +1153,10 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
 	if (!id)
 		return -ENODEV;
 
+	punit_bios_ipc_dev = intel_ipc_dev_get(PUNIT_BIOS_IPC_DEV);
+	if (IS_ERR_OR_NULL(punit_bios_ipc_dev))
+		return PTR_ERR(punit_bios_ipc_dev);
+
 	telm_conf = (struct telemetry_plt_config *)id->driver_data;
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1218,6 +1236,7 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
 static int telemetry_pltdrv_remove(struct platform_device *pdev)
 {
 	telemetry_clear_pltdata();
+	intel_ipc_dev_put(punit_bios_ipc_dev);
 	iounmap(telm_conf->pss_config.regmap);
 	iounmap(telm_conf->ioss_config.regmap);
 
-- 
2.7.4

