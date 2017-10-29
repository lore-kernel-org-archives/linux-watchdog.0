Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49818 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdJ2Juq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 29 Oct 2017 05:50:46 -0400
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
Subject: [RFC v8 6/7] platform/x86: intel_pmc_ipc: Use generic Intel IPC device calls
Date: Sun, 29 Oct 2017 02:49:59 -0700
Message-Id: <a579de15ef574eb2780b5fa40189ca0b6745d519.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Removed redundant IPC helper functions and refactored the driver to use
generic IPC device driver APIs. Also, cleaned up the driver to minimize
the usage of global variable ipcdev by propogating the struct
intel_pmc_ipc_dev pointer or by getting it from device private data.

This patch also cleans-up PMC IPC user drivers(intel_telemetry_pltdrv.c,
intel_soc_pmic_bxtwc.c) to use APIs provided by generic IPC driver.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/x86/include/asm/intel_pmc_ipc.h          |  31 +--
 drivers/mfd/intel_soc_pmic_bxtwc.c            |  37 ++-
 drivers/platform/x86/intel_pmc_ipc.c          | 382 ++++++++++----------------
 drivers/platform/x86/intel_telemetry_pltdrv.c | 128 ++++-----
 include/linux/mfd/intel_soc_pmic.h            |   2 +
 5 files changed, 247 insertions(+), 333 deletions(-)

Changes since v7:
 * Fixed style issues.

Changes since v6:
 * Fixed some style and rebase issues.

Changes since v5:
 * Adapted to change in arguments of ipc_dev_cmd() and ipc_dev_raw_cmd() APIs.

Changes since v4:
 * None

Changes since v3:
 * Added unique name to PMC regmaps.
 * Added support to clear interrupt bit.
 * Added intel_ipc_dev_put() support.

Changes since v1:
 * Removed custom APIs.
 * Cleaned up PMC IPC user drivers to use APIs provided by generic
   IPC driver.

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index fac89eb..ca2f5e3 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -1,10 +1,15 @@
 #ifndef _ASM_X86_INTEL_PMC_IPC_H_
 #define  _ASM_X86_INTEL_PMC_IPC_H_
 
+#include <linux/platform_data/x86/intel_ipc_dev.h>
+
+#define INTEL_PMC_IPC_DEV		"intel_pmc_ipc"
+#define PMC_PARAM_LEN			2
+
 /* Commands */
 #define PMC_IPC_PMIC_ACCESS		0xFF
-#define		PMC_IPC_PMIC_ACCESS_READ	0x0
-#define		PMC_IPC_PMIC_ACCESS_WRITE	0x1
+#define	PMC_IPC_PMIC_ACCESS_READ	0x0
+#define	PMC_IPC_PMIC_ACCESS_WRITE	0x1
 #define PMC_IPC_USB_PWR_CTRL		0xF0
 #define PMC_IPC_PMIC_BLACKLIST_SEL	0xEF
 #define PMC_IPC_PHY_CONFIG		0xEE
@@ -30,11 +35,6 @@
 
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
-int intel_pmc_ipc_simple_command(int cmd, int sub);
-int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
-		u32 *out, u32 outlen, u32 dptr, u32 sptr);
-int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
-		u32 *out, u32 outlen);
 int intel_pmc_s0ix_counter_read(u64 *data);
 int intel_pmc_gcr_read(u32 offset, u32 *data);
 int intel_pmc_gcr_write(u32 offset, u32 data);
@@ -42,23 +42,6 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val);
 
 #else
 
-static inline int intel_pmc_ipc_simple_command(int cmd, int sub)
-{
-	return -EINVAL;
-}
-
-static inline int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
-		u32 *out, u32 outlen, u32 dptr, u32 sptr)
-{
-	return -EINVAL;
-}
-
-static inline int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
-		u32 *out, u32 outlen)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_s0ix_counter_read(u64 *data)
 {
 	return -EINVAL;
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 15bc052..55ffcae 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -271,6 +271,9 @@ static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
 	u8 ipc_in[2];
 	u8 ipc_out[4];
 	struct intel_soc_pmic *pmic = context;
+	struct intel_ipc_raw_cmd ipc_raw_cmd;
+	u32 cmd[PMC_PARAM_LEN] = {PMC_IPC_PMIC_ACCESS,
+		PMC_IPC_PMIC_ACCESS_READ};
 
 	if (!pmic)
 		return -EINVAL;
@@ -284,9 +287,15 @@ static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
 
 	ipc_in[0] = reg;
 	ipc_in[1] = i2c_addr;
-	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
-			PMC_IPC_PMIC_ACCESS_READ,
-			ipc_in, sizeof(ipc_in), (u32 *)ipc_out, 1);
+
+	ipc_raw_cmd.cmd_list = cmd;
+	ipc_raw_cmd.cmdlen = PMC_PARAM_LEN;
+	ipc_raw_cmd.in = ipc_in;
+	ipc_raw_cmd.inlen = sizeof(ipc_in);
+	ipc_raw_cmd.out = (u32 *)ipc_out;
+	ipc_raw_cmd.outlen = 1;
+
+	ret = ipc_dev_raw_cmd(pmic->ipc_dev, &ipc_raw_cmd);
 	if (ret) {
 		dev_err(pmic->dev, "Failed to read from PMIC\n");
 		return ret;
@@ -303,6 +312,9 @@ static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
 	int i2c_addr;
 	u8 ipc_in[3];
 	struct intel_soc_pmic *pmic = context;
+	struct intel_ipc_raw_cmd ipc_raw_cmd;
+	u32 cmd[PMC_PARAM_LEN] = {PMC_IPC_PMIC_ACCESS,
+		PMC_IPC_PMIC_ACCESS_WRITE};
 
 	if (!pmic)
 		return -EINVAL;
@@ -317,9 +329,15 @@ static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
 	ipc_in[0] = reg;
 	ipc_in[1] = i2c_addr;
 	ipc_in[2] = val;
-	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
-			PMC_IPC_PMIC_ACCESS_WRITE,
-			ipc_in, sizeof(ipc_in), NULL, 0);
+
+	ipc_raw_cmd.cmd_list = cmd;
+	ipc_raw_cmd.cmdlen = PMC_PARAM_LEN;
+	ipc_raw_cmd.in = ipc_in;
+	ipc_raw_cmd.inlen = sizeof(ipc_in);
+	ipc_raw_cmd.out = NULL;
+	ipc_raw_cmd.outlen = 0;
+
+	ret = ipc_dev_raw_cmd(pmic->ipc_dev, &ipc_raw_cmd);
 	if (ret) {
 		dev_err(pmic->dev, "Failed to write to PMIC\n");
 		return ret;
@@ -445,6 +463,10 @@ static int bxtwc_probe(struct platform_device *pdev)
 	if (!pmic)
 		return -ENOMEM;
 
+	pmic->ipc_dev = intel_ipc_dev_get(INTEL_PMC_IPC_DEV);
+	if (IS_ERR_OR_NULL(pmic->ipc_dev))
+		return PTR_ERR(pmic->ipc_dev);
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Invalid IRQ\n");
@@ -562,7 +584,10 @@ static int bxtwc_probe(struct platform_device *pdev)
 
 static int bxtwc_remove(struct platform_device *pdev)
 {
+	struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
+
 	sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
+	intel_ipc_dev_put(pmic->ipc_dev);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index df6af1f..7d6a82d 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -48,18 +48,8 @@
  * The ARC handles the interrupt and services it, writing optional data to
  * the IPC1 registers, updates the IPC_STS response register with the status.
  */
-#define IPC_CMD			0x0
-#define		IPC_CMD_MSI		0x100
 #define		IPC_CMD_SIZE		16
 #define		IPC_CMD_SUBCMD		12
-#define IPC_STATUS		0x04
-#define		IPC_STATUS_IRQ		0x4
-#define		IPC_STATUS_ERR		0x2
-#define		IPC_STATUS_BUSY		0x1
-#define IPC_SPTR		0x08
-#define IPC_DPTR		0x0C
-#define IPC_WRITE_BUFFER	0x80
-#define IPC_READ_BUFFER		0x90
 
 /* Residency with clock rate at 19.2MHz to usecs */
 #define S0IX_RESIDENCY_IN_USECS(d, s)		\
@@ -74,11 +64,6 @@
  */
 #define IPC_DATA_BUFFER_SIZE	16
 
-#define IPC_LOOP_CNT		3000000
-#define IPC_MAX_SEC		3
-
-#define IPC_TRIGGER_MODE_IRQ		true
-
 /* exported resources from IFWI */
 #define PLAT_RESOURCE_IPC_INDEX		0
 #define PLAT_RESOURCE_IPC_SIZE		0x1000
@@ -118,36 +103,41 @@
 #define PMC_CFG_NO_REBOOT_EN		(1 << 4)
 #define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
 
+/* IPC PMC commands */
+#define	IPC_DEV_PMC_CMD_MSI			BIT(8)
+#define	IPC_DEV_PMC_CMD_SIZE			16
+#define	IPC_DEV_PMC_CMD_SUBCMD			12
+#define	IPC_DEV_PMC_CMD_STATUS			BIT(2)
+#define	IPC_DEV_PMC_CMD_STATUS_IRQ		BIT(2)
+#define	IPC_DEV_PMC_CMD_STATUS_ERR		BIT(1)
+#define	IPC_DEV_PMC_CMD_STATUS_ERR_MASK		GENMASK(7, 0)
+#define	IPC_DEV_PMC_CMD_STATUS_BUSY		BIT(0)
+
+/*IPC PMC reg offsets */
+#define IPC_DEV_PMC_STATUS_OFFSET		0x04
+#define IPC_DEV_PMC_SPTR_OFFSET			0x08
+#define IPC_DEV_PMC_DPTR_OFFSET			0x0C
+#define IPC_DEV_PMC_WRBUF_OFFSET		0x80
+#define IPC_DEV_PMC_RBUF_OFFSET			0x90
+
 static struct intel_pmc_ipc_dev {
 	struct device *dev;
+	struct intel_ipc_dev *pmc_ipc_dev;
+	struct intel_ipc_dev_ops ops;
+	struct intel_ipc_dev_cfg cfg;
 	void __iomem *ipc_base;
-	bool irq_mode;
-	int irq;
-	int cmd;
-	struct completion cmd_complete;
 
 	/* gcr */
 	void __iomem *gcr_mem_base;
 	struct regmap *gcr_regs;
 } ipcdev;
 
-static char *ipc_err_sources[] = {
-	[IPC_ERR_NONE] =
-		"no error",
-	[IPC_ERR_CMD_NOT_SUPPORTED] =
-		"command not supported",
-	[IPC_ERR_CMD_NOT_SERVICED] =
-		"command not serviced",
-	[IPC_ERR_UNABLE_TO_SERVICE] =
-		"unable to service",
-	[IPC_ERR_CMD_INVALID] =
-		"command invalid",
-	[IPC_ERR_CMD_FAILED] =
-		"command failed",
-	[IPC_ERR_EMSECURITY] =
-		"Invalid Battery",
-	[IPC_ERR_UNSIGNEDKERNEL] =
-		"Unsigned kernel",
+static struct regmap_config pmc_regmap_config = {
+	.name = "intel_pmc_regs",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
 };
 
 static struct regmap_config gcr_regmap_config = {
@@ -159,40 +149,6 @@ static struct regmap_config gcr_regmap_config = {
 	.max_register = PLAT_RESOURCE_GCR_SIZE,
 };
 
-/* Prevent concurrent calls to the PMC */
-static DEFINE_MUTEX(ipclock);
-
-static inline void ipc_send_command(u32 cmd)
-{
-	ipcdev.cmd = cmd;
-	if (ipcdev.irq_mode) {
-		reinit_completion(&ipcdev.cmd_complete);
-		cmd |= IPC_CMD_MSI;
-	}
-	writel(cmd, ipcdev.ipc_base + IPC_CMD);
-}
-
-static inline u32 ipc_read_status(void)
-{
-	return readl(ipcdev.ipc_base + IPC_STATUS);
-}
-
-static inline void ipc_data_writel(u32 data, u32 offset)
-{
-	writel(data, ipcdev.ipc_base + IPC_WRITE_BUFFER + offset);
-}
-
-static inline u8 __maybe_unused ipc_data_readb(u32 offset)
-{
-	return readb(ipcdev.ipc_base + IPC_READ_BUFFER + offset);
-}
-
-static inline u32 ipc_data_readl(u32 offset)
-{
-	return readl(ipcdev.ipc_base + IPC_READ_BUFFER + offset);
-}
-
-
 /**
  * intel_pmc_gcr_read() - Read PMC GCR register
  * @offset:	offset of GCR register from GCR address base
@@ -264,160 +220,109 @@ static int update_no_reboot_bit(void *priv, bool set)
 				    PMC_CFG_NO_REBOOT_MASK, value);
 }
 
-static int intel_pmc_ipc_check_status(void)
+static int pre_simple_cmd_fn(u32 *cmd_list, u32 cmdlen)
 {
-	int status;
-	int ret = 0;
-
-	if (ipcdev.irq_mode) {
-		if (0 == wait_for_completion_timeout(
-				&ipcdev.cmd_complete, IPC_MAX_SEC * HZ))
-			ret = -ETIMEDOUT;
-	} else {
-		int loop_count = IPC_LOOP_CNT;
-
-		while ((ipc_read_status() & IPC_STATUS_BUSY) && --loop_count)
-			udelay(1);
-		if (loop_count == 0)
-			ret = -ETIMEDOUT;
-	}
-
-	status = ipc_read_status();
-	if (ret == -ETIMEDOUT) {
-		dev_err(ipcdev.dev,
-			"IPC timed out, TS=0x%x, CMD=0x%x\n",
-			status, ipcdev.cmd);
-		return ret;
-	}
+	if (!cmd_list || cmdlen != PMC_PARAM_LEN)
+		return -EINVAL;
 
-	if (status & IPC_STATUS_ERR) {
-		int i;
-
-		ret = -EIO;
-		i = (status >> IPC_CMD_SIZE) & 0xFF;
-		if (i < ARRAY_SIZE(ipc_err_sources))
-			dev_err(ipcdev.dev,
-				"IPC failed: %s, STS=0x%x, CMD=0x%x\n",
-				ipc_err_sources[i], status, ipcdev.cmd);
-		else
-			dev_err(ipcdev.dev,
-				"IPC failed: unknown, STS=0x%x, CMD=0x%x\n",
-				status, ipcdev.cmd);
-		if ((i == IPC_ERR_UNSIGNEDKERNEL) || (i == IPC_ERR_EMSECURITY))
-			ret = -EACCES;
-	}
+	cmd_list[0] |= (cmd_list[1] << IPC_CMD_SUBCMD);
 
-	return ret;
+	return 0;
 }
 
-/**
- * intel_pmc_ipc_simple_command() - Simple IPC command
- * @cmd:	IPC command code.
- * @sub:	IPC command sub type.
- *
- * Send a simple IPC command to PMC when don't need to specify
- * input/output data and source/dest pointers.
- *
- * Return:	an IPC error code or 0 on success.
- */
-int intel_pmc_ipc_simple_command(int cmd, int sub)
+static int pre_raw_cmd_fn(struct intel_ipc_raw_cmd *ipc_raw_cmd)
 {
 	int ret;
 
-	mutex_lock(&ipclock);
-	if (ipcdev.dev == NULL) {
-		mutex_unlock(&ipclock);
-		return -ENODEV;
-	}
-	ipc_send_command(sub << IPC_CMD_SUBCMD | cmd);
-	ret = intel_pmc_ipc_check_status();
-	mutex_unlock(&ipclock);
+	if (ipc_raw_cmd->inlen > IPC_DATA_BUFFER_SIZE ||
+	    ipc_raw_cmd->outlen > (IPC_DATA_BUFFER_SIZE / 4))
+		return -EINVAL;
 
-	return ret;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_simple_command);
+	ret = pre_simple_cmd_fn(ipc_raw_cmd->cmd_list, ipc_raw_cmd->cmdlen);
+	if (ret < 0)
+		return ret;
 
-/**
- * intel_pmc_ipc_raw_cmd() - IPC command with data and pointers
- * @cmd:	IPC command code.
- * @sub:	IPC command sub type.
- * @in:		input data of this IPC command.
- * @inlen:	input data length in bytes.
- * @out:	output data of this IPC command.
- * @outlen:	output data length in dwords.
- * @sptr:	data writing to SPTR register.
- * @dptr:	data writing to DPTR register.
- *
- * Send an IPC command to PMC with input/output data and source/dest pointers.
- *
- * Return:	an IPC error code or 0 on success.
- */
-int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen, u32 *out,
-			  u32 outlen, u32 dptr, u32 sptr)
-{
-	u32 wbuf[4] = { 0 };
-	int ret;
-	int i;
+	ipc_raw_cmd->cmd_list[0] |= (ipc_raw_cmd->inlen << IPC_CMD_SIZE);
 
-	if (inlen > IPC_DATA_BUFFER_SIZE || outlen > IPC_DATA_BUFFER_SIZE / 4)
-		return -EINVAL;
+	return 0;
+}
 
-	mutex_lock(&ipclock);
-	if (ipcdev.dev == NULL) {
-		mutex_unlock(&ipclock);
-		return -ENODEV;
-	}
-	memcpy(wbuf, in, inlen);
-	writel(dptr, ipcdev.ipc_base + IPC_DPTR);
-	writel(sptr, ipcdev.ipc_base + IPC_SPTR);
-	/* The input data register is 32bit register and inlen is in Byte */
-	for (i = 0; i < ((inlen + 3) / 4); i++)
-		ipc_data_writel(wbuf[i], 4 * i);
-	ipc_send_command((inlen << IPC_CMD_SIZE) |
-			(sub << IPC_CMD_SUBCMD) | cmd);
-	ret = intel_pmc_ipc_check_status();
-	if (!ret) {
-		/* out is read from 32bit register and outlen is in 32bit */
-		for (i = 0; i < outlen; i++)
-			*out++ = ipc_data_readl(4 * i);
-	}
-	mutex_unlock(&ipclock);
+static int pre_irq_handler_fn(struct intel_ipc_dev *ipc_dev, int irq)
+{
+	return regmap_write_bits(ipc_dev->cfg->cmd_regs,
+				 ipc_dev->cfg->status_reg,
+				 IPC_DEV_PMC_CMD_STATUS_IRQ,
+				 IPC_DEV_PMC_CMD_STATUS_IRQ);
+}
 
-	return ret;
+static int pmc_ipc_err_code(int status)
+{
+	return ((status >> IPC_DEV_PMC_CMD_SIZE) &
+		IPC_DEV_PMC_CMD_STATUS_ERR_MASK);
 }
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_raw_cmd);
 
-/**
- * intel_pmc_ipc_command() -  IPC command with input/output data
- * @cmd:	IPC command code.
- * @sub:	IPC command sub type.
- * @in:		input data of this IPC command.
- * @inlen:	input data length in bytes.
- * @out:	output data of this IPC command.
- * @outlen:	output data length in dwords.
- *
- * Send an IPC command to PMC with input/output data.
- *
- * Return:	an IPC error code or 0 on success.
- */
-int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
-			  u32 *out, u32 outlen)
+static int pmc_ipc_busy_check(int status)
 {
-	return intel_pmc_ipc_raw_cmd(cmd, sub, in, inlen, out, outlen, 0, 0);
+	return status | IPC_DEV_PMC_CMD_STATUS_BUSY;
 }
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_command);
 
-static irqreturn_t ioc(int irq, void *dev_id)
+static u32 pmc_ipc_enable_msi(u32 cmd)
 {
-	int status;
+	return cmd | IPC_DEV_PMC_CMD_MSI;
+}
 
-	if (ipcdev.irq_mode) {
-		status = ipc_read_status();
-		writel(status | IPC_STATUS_IRQ, ipcdev.ipc_base + IPC_STATUS);
+static struct intel_ipc_dev *intel_pmc_ipc_dev_create(
+		struct device *pmc_dev,
+		void __iomem *base,
+		int irq)
+{
+	struct intel_ipc_dev_ops *ops;
+	struct intel_ipc_dev_cfg *cfg;
+	struct regmap *cmd_regs;
+
+	cfg = devm_kzalloc(pmc_dev, sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	ops = devm_kzalloc(pmc_dev, sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return ERR_PTR(-ENOMEM);
+
+	cmd_regs = devm_regmap_init_mmio_clk(pmc_dev, NULL, base,
+					     &pmc_regmap_config);
+	if (IS_ERR(cmd_regs)) {
+		dev_err(pmc_dev, "cmd_regs regmap init failed\n");
+		return ERR_CAST(cmd_regs);
 	}
-	complete(&ipcdev.cmd_complete);
 
-	return IRQ_HANDLED;
+	/* set IPC dev ops */
+	ops->to_err_code = pmc_ipc_err_code;
+	ops->busy_check = pmc_ipc_busy_check;
+	ops->enable_msi = pmc_ipc_enable_msi;
+	ops->pre_raw_cmd_fn = pre_raw_cmd_fn;
+	ops->pre_simple_cmd_fn = pre_simple_cmd_fn;
+	ops->pre_irq_handler_fn = pre_irq_handler_fn;
+
+	/* set cfg options */
+	if (irq > 0)
+		cfg->mode = IPC_DEV_MODE_IRQ;
+	else
+		cfg->mode = IPC_DEV_MODE_POLLING;
+
+	cfg->chan_type = IPC_CHANNEL_IA_PMC;
+	cfg->irq = irq;
+	cfg->use_msi = true;
+	cfg->support_sptr = true;
+	cfg->support_dptr = true;
+	cfg->cmd_regs = cmd_regs;
+	cfg->data_regs = cmd_regs;
+	cfg->wrbuf_reg = IPC_DEV_PMC_WRBUF_OFFSET;
+	cfg->rbuf_reg = IPC_DEV_PMC_RBUF_OFFSET;
+	cfg->sptr_reg = IPC_DEV_PMC_SPTR_OFFSET;
+	cfg->dptr_reg = IPC_DEV_PMC_DPTR_OFFSET;
+	cfg->status_reg = IPC_DEV_PMC_STATUS_OFFSET;
+
+	return devm_intel_ipc_dev_create(pmc_dev, INTEL_PMC_IPC_DEV, cfg, ops);
 }
 
 static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -429,8 +334,6 @@ static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pmc->dev)
 		return -EBUSY;
 
-	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
-
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -439,15 +342,13 @@ static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	init_completion(&pmc->cmd_complete);
-
 	pmc->ipc_base = pcim_iomap_table(pdev)[0];
 
-	ret = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_pmc_ipc",
-				pmc);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request IRQ\n");
-		return ret;
+	pmc->pmc_ipc_dev = intel_pmc_ipc_dev_create(&pdev->dev, pmc->ipc_base,
+						    pdev->irq);
+	if (IS_ERR(pmc->pmc_ipc_dev)) {
+		dev_err(&pdev->dev, "Failed to create PMC IPC device\n");
+		return PTR_ERR(pmc->pmc_ipc_dev);
 	}
 
 	pmc->dev = &pdev->dev;
@@ -475,19 +376,19 @@ static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t count)
 {
-	int subcmd;
-	int cmd;
+	struct intel_pmc_ipc_dev *pmc = dev_get_drvdata(dev);
+	int cmd[2];
 	int ret;
 
-	ret = sscanf(buf, "%d %d", &cmd, &subcmd);
+	ret = sscanf(buf, "%d %d", &cmd[0], &cmd[2]);
 	if (ret != 2) {
 		dev_err(dev, "Error args\n");
 		return -EINVAL;
 	}
 
-	ret = intel_pmc_ipc_simple_command(cmd, subcmd);
+	ret = ipc_dev_simple_cmd(pmc->pmc_ipc_dev, cmd, 2);
 	if (ret) {
-		dev_err(dev, "command %d error with %d\n", cmd, ret);
+		dev_err(dev, "command %d error with %d\n", cmd[0], ret);
 		return ret;
 	}
 	return (ssize_t)count;
@@ -497,22 +398,23 @@ static ssize_t intel_pmc_ipc_northpeak_store(struct device *dev,
 					     struct device_attribute *attr,
 					     const char *buf, size_t count)
 {
+	struct intel_pmc_ipc_dev *pmc = dev_get_drvdata(dev);
 	unsigned long val;
-	int subcmd;
+	int cmd[2] = {PMC_IPC_NORTHPEAK_CTRL, 0};
 	int ret;
 
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
 	if (val)
-		subcmd = 1;
-	else
-		subcmd = 0;
-	ret = intel_pmc_ipc_simple_command(PMC_IPC_NORTHPEAK_CTRL, subcmd);
+		cmd[1] = 1;
+
+	ret = ipc_dev_simple_cmd(pmc->pmc_ipc_dev, cmd, 2);
 	if (ret) {
-		dev_err(dev, "command north %d error with %d\n", subcmd, ret);
+		dev_err(dev, "command north %d error with %d\n", cmd[1], ret);
 		return ret;
 	}
+
 	return (ssize_t)count;
 }
 
@@ -688,6 +590,7 @@ static int ipc_create_pmc_devices(struct platform_device *pdev)
 
 static int ipc_plat_get_res(struct platform_device *pdev)
 {
+	struct intel_pmc_ipc_dev *pmc = dev_get_drvdata(&pdev->dev);
 	struct resource *res;
 	void __iomem *addr;
 
@@ -706,9 +609,9 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
-	ipcdev.ipc_base = addr;
-	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
-	dev_dbg(&pdev->dev, "PMC IPC resource %pR\n", res);
+	pmc->ipc_base = addr;
+	pmc->gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
+	dev_info(&pdev->dev, "PMC IPC resource %pR\n", res);
 
 	return 0;
 }
@@ -754,14 +657,15 @@ MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
 
 static int ipc_plat_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, irq;
+	struct intel_pmc_ipc_dev *pmc = &ipcdev;
 
-	ipcdev.dev = &pdev->dev;
-	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
-	init_completion(&ipcdev.cmd_complete);
+	pmc->dev = &pdev->dev;
 
-	ipcdev.irq = platform_get_irq(pdev, 0);
-	if (ipcdev.irq < 0) {
+	dev_set_drvdata(&pdev->dev, pmc);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ\n");
 		return -EINVAL;
 	}
@@ -786,28 +690,26 @@ static int ipc_plat_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_irq(&pdev->dev, ipcdev.irq, ioc, IRQF_NO_SUSPEND,
-			       "intel_pmc_ipc", &ipcdev);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to request IRQ\n");
-		return ret;
-	}
-
 	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
 			ret);
-		devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
 		return ret;
 	}
 
+	ipcdev.pmc_ipc_dev = intel_pmc_ipc_dev_create(&pdev->dev,
+			pmc->ipc_base, irq);
+	if (IS_ERR(pmc->pmc_ipc_dev)) {
+		dev_err(&pdev->dev, "Failed to create PMC IPC device\n");
+		return PTR_ERR(pmc->pmc_ipc_dev);
+	}
+
 	return 0;
 }
 
 static int ipc_plat_remove(struct platform_device *pdev)
 {
 	sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
-	devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
 	ipcdev.dev = NULL;
 
 	return 0;
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index 0dbd7be..74868bb 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -56,10 +56,6 @@
 #define IOSS_TELEM_TRACE_CTL_WRITE	0x6
 #define IOSS_TELEM_EVENT_CTL_READ	0x7
 #define IOSS_TELEM_EVENT_CTL_WRITE	0x8
-#define IOSS_TELEM_EVT_CTRL_WRITE_SIZE	0x4
-#define IOSS_TELEM_READ_WORD		0x1
-#define IOSS_TELEM_WRITE_FOURBYTES	0x4
-#define IOSS_TELEM_EVT_WRITE_SIZE	0x3
 
 #define TELEM_INFO_SRAMEVTS_MASK	0xFF00
 #define TELEM_INFO_SRAMEVTS_SHIFT	0x8
@@ -98,7 +94,7 @@ struct telem_ssram_region {
 };
 
 static struct telemetry_plt_config *telm_conf;
-static struct intel_ipc_dev *punit_ipc_dev;
+static struct intel_ipc_dev *punit_ipc_dev, *pmc_ipc_dev;
 
 /*
  * The following counters are programmed by default during setup.
@@ -226,6 +222,29 @@ static int telem_punit_cmd(struct intel_ipc_dev *ipc_dev, u32 cmd, u32 sub,
 	return ipc_dev_cmd(ipc_dev, &ipc_cmd);
 }
 
+static int telem_pmc_cmd(struct intel_ipc_dev *ipc_dev, u32 cmd, u32 sub,
+			 u8 *in, u32 *out)
+{
+	struct intel_ipc_raw_cmd ipc_raw_cmd = {0};
+	u32 cmd_list[PMC_PARAM_LEN] = {0};
+
+	cmd_list[0] = cmd;
+	cmd_list[1] = sub;
+
+	ipc_raw_cmd.cmd_list = cmd_list;
+	ipc_raw_cmd.cmdlen = PMC_PARAM_LEN;
+	ipc_raw_cmd.in = in;
+	ipc_raw_cmd.out = out;
+
+	if (in)
+		ipc_raw_cmd.inlen = 4;
+	if (out)
+		ipc_raw_cmd.outlen = 1;
+
+	return ipc_dev_raw_cmd(ipc_dev, &ipc_raw_cmd);
+}
+
+
 static inline int telem_get_unitconfig(enum telemetry_unit telem_unit,
 				     struct telemetry_unit_config **unit_config)
 {
@@ -289,17 +308,13 @@ static int telemetry_check_evtid(enum telemetry_unit telem_unit,
 static inline int telemetry_plt_config_ioss_event(u32 evt_id, int index)
 {
 	u32 write_buf;
-	int ret;
 
 	write_buf = evt_id | TELEM_EVENT_ENABLE;
 	write_buf <<= BITS_PER_BYTE;
 	write_buf |= index;
 
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				    IOSS_TELEM_EVENT_WRITE, (u8 *)&write_buf,
-				    IOSS_TELEM_EVT_WRITE_SIZE, NULL, 0);
-
-	return ret;
+	return telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+			     IOSS_TELEM_EVENT_WRITE, (u8 *)&write_buf, NULL);
 }
 
 static inline int telemetry_plt_config_pss_event(u32 evt_id, int index)
@@ -325,9 +340,8 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	ioss_evtmap = evtconfig.evtmap;
 
 	/* Get telemetry EVENT CTL */
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
-				    &telem_ctrl, IOSS_TELEM_READ_WORD);
+	ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+			    IOSS_TELEM_EVENT_CTL_READ, NULL, &telem_ctrl);
 	if (ret) {
 		pr_err("IOSS TELEM_CTRL Read Failed\n");
 		return ret;
@@ -335,12 +349,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 
 	/* Disable Telemetry */
 	TELEM_DISABLE(telem_ctrl);
-
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				    IOSS_TELEM_EVENT_CTL_WRITE,
-				    (u8 *)&telem_ctrl,
-				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-				    NULL, 0);
+	ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+			    IOSS_TELEM_EVENT_CTL_WRITE, (u8 *)&telem_ctrl,
+			    NULL);
 	if (ret) {
 		pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
 		return ret;
@@ -351,12 +362,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	if (action == TELEM_RESET) {
 		/* Clear All Events */
 		TELEM_CLEAR_EVENTS(telem_ctrl);
-
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-					    NULL, 0);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_EVENT_CTL_WRITE,
+				    (u8 *)&telem_ctrl, NULL);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
 			return ret;
@@ -380,12 +388,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	if (action == TELEM_UPDATE) {
 		/* Clear All Events */
 		TELEM_CLEAR_EVENTS(telem_ctrl);
-
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-					    NULL, 0);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_EVENT_CTL_WRITE,
+				    (u8 *)&telem_ctrl, NULL);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
 			return ret;
@@ -432,11 +437,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
 	TELEM_ENABLE_SRAM_EVT_TRACE(telem_ctrl);
 	TELEM_ENABLE_PERIODIC(telem_ctrl);
 	telem_ctrl |= ioss_period;
-
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				    IOSS_TELEM_EVENT_CTL_WRITE,
-				    (u8 *)&telem_ctrl,
-				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE, NULL, 0);
+	ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+			    IOSS_TELEM_EVENT_CTL_WRITE, (u8 *)&telem_ctrl,
+			    NULL);
 	if (ret) {
 		pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
 		return ret;
@@ -626,8 +629,8 @@ static int telemetry_setup(struct platform_device *pdev)
 	u32 read_buf, events, event_regs;
 	int ret;
 
-	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY, IOSS_TELEM_INFO_READ,
-				    NULL, 0, &read_buf, IOSS_TELEM_READ_WORD);
+	ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+			    IOSS_TELEM_INFO_READ, NULL, &read_buf);
 	if (ret) {
 		dev_err(&pdev->dev, "IOSS TELEM_INFO Read Failed\n");
 		return ret;
@@ -728,9 +731,9 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		}
 
 		/* Get telemetry EVENT CTL */
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
-					    &telem_ctrl, IOSS_TELEM_READ_WORD);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_EVENT_CTL_READ, NULL,
+				    &telem_ctrl);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Read Failed\n");
 			goto out;
@@ -738,12 +741,9 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 
 		/* Disable Telemetry */
 		TELEM_DISABLE(telem_ctrl);
-
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-					    NULL, 0);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_EVENT_CTL_WRITE,
+				    (u8 *)&telem_ctrl, NULL);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
 			goto out;
@@ -755,11 +755,9 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
 		TELEM_ENABLE_PERIODIC(telem_ctrl);
 		telem_ctrl |= ioss_period;
 
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-					    IOSS_TELEM_EVENT_CTL_WRITE,
-					    (u8 *)&telem_ctrl,
-					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
-					    NULL, 0);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_EVENT_CTL_WRITE,
+				    (u8 *)&telem_ctrl, NULL);
 		if (ret) {
 			pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
 			goto out;
@@ -1054,9 +1052,9 @@ static int telemetry_plt_get_trace_verbosity(enum telemetry_unit telem_unit,
 		break;
 
 	case TELEM_IOSS:
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				IOSS_TELEM_TRACE_CTL_READ, NULL, 0, &temp,
-				IOSS_TELEM_READ_WORD);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_TRACE_CTL_READ,
+				    NULL, &temp);
 		if (ret) {
 			pr_err("IOSS TRACE_CTL Read Failed\n");
 			goto out;
@@ -1107,9 +1105,9 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
 		break;
 
 	case TELEM_IOSS:
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				IOSS_TELEM_TRACE_CTL_READ, NULL, 0, &temp,
-				IOSS_TELEM_READ_WORD);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_TRACE_CTL_READ,
+				    NULL, &temp);
 		if (ret) {
 			pr_err("IOSS TRACE_CTL Read Failed\n");
 			goto out;
@@ -1117,10 +1115,9 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
 
 		TELEM_CLEAR_VERBOSITY_BITS(temp);
 		TELEM_SET_VERBOSITY_BITS(temp, verbosity);
-
-		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
-				IOSS_TELEM_TRACE_CTL_WRITE, (u8 *)&temp,
-				IOSS_TELEM_WRITE_FOURBYTES, NULL, 0);
+		ret = telem_pmc_cmd(pmc_ipc_dev, PMC_IPC_PMC_TELEMTRY,
+				    IOSS_TELEM_TRACE_CTL_WRITE,
+				    (u8 *)&temp, NULL);
 		if (ret) {
 			pr_err("IOSS TRACE_CTL Verbosity Set Failed\n");
 			goto out;
@@ -1165,6 +1162,10 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
 	if (IS_ERR_OR_NULL(punit_ipc_dev))
 		return PTR_ERR(punit_ipc_dev);
 
+	pmc_ipc_dev = intel_ipc_dev_get(INTEL_PMC_IPC_DEV);
+	if (IS_ERR_OR_NULL(pmc_ipc_dev))
+		return PTR_ERR(pmc_ipc_dev);
+
 	telm_conf = (struct telemetry_plt_config *)id->driver_data;
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1244,6 +1245,7 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
 static int telemetry_pltdrv_remove(struct platform_device *pdev)
 {
 	telemetry_clear_pltdata();
+	intel_ipc_dev_put(pmc_ipc_dev);
 	intel_ipc_dev_put(punit_ipc_dev);
 	iounmap(telm_conf->pss_config.regmap);
 	iounmap(telm_conf->ioss_config.regmap);
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index 5aacdb0..7cc39b6 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -20,6 +20,7 @@
 #define __INTEL_SOC_PMIC_H__
 
 #include <linux/regmap.h>
+#include <linux/platform_data/x86/intel_ipc_dev.h>
 
 struct intel_soc_pmic {
 	int irq;
@@ -31,6 +32,7 @@ struct intel_soc_pmic {
 	struct regmap_irq_chip_data *irq_chip_data_chgr;
 	struct regmap_irq_chip_data *irq_chip_data_crit;
 	struct device *dev;
+	struct intel_ipc_dev *ipc_dev;
 };
 
 #endif	/* __INTEL_SOC_PMIC_H__ */
-- 
2.7.4

