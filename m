Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11489 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdDIWEC (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Apr 2017 18:04:02 -0400
From: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To: andy@infradead.org, qipeng.zha@intel.com, dvhart@infradead.org,
        linux@roeck-us.net
Cc: wim@iguana.be, sathyaosid@gmail.com, david.e.box@linux.intel.com,
        rajneesh.bhardwaj@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v7 2/6] platform/x86: intel_pmc_ipc: Add pmc gcr read/write/update api's
Date: Sun,  9 Apr 2017 15:00:17 -0700
Message-Id: <316b561ad374b8a117a654828c6586bac4bde972.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <aefdf4f6a7b0cf4af92d51ce2b9b73284cc03ffe.1491773609.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds API's to read/write/update PMC GC registers.
PMC dependent devices like iTCO_wdt, Telemetry has requirement
to acces GCR registers. These API's can be used for this
purpose.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h |  21 +++++++
 drivers/platform/x86/intel_pmc_ipc.c | 115 +++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

Changes since v6:
 * None

Changes since v5:
 * Removed redundant temp variable in intel_pmc_gcr_update().
 * Changed label name from "gcr_update_err" to "gcr_ipc_unlock"
 * Fixed some style issues.

Changes since v4:
 * Fixed style issue in commit history
 * Added mutex locks in read/write/update API's.

Changes since v3:
 * Added usage comments for read/write/update api
 * Created a helper function to handle GCR related range checks.

Changes since v2:
 * Removed unused reg offset from header file.
 * Modified read/write api's signatures for better error handling
 * Added function for bit level update of gcr register.

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 4291b6a..8402efe 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -23,6 +23,9 @@
 #define IPC_ERR_EMSECURITY		6
 #define IPC_ERR_UNSIGNEDKERNEL		7
 
+/* GCR reg offsets from gcr base*/
+#define PMC_GCR_PMC_CFG_REG		0x08
+
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
 int intel_pmc_ipc_simple_command(int cmd, int sub);
@@ -31,6 +34,9 @@ int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen);
 int intel_pmc_s0ix_counter_read(u64 *data);
+int intel_pmc_gcr_read(u32 offset, u32 *data);
+int intel_pmc_gcr_write(u32 offset, u32 data);
+int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val);
 
 #else
 
@@ -56,6 +62,21 @@ static inline int intel_pmc_s0ix_counter_read(u64 *data)
 	return -EINVAL;
 }
 
+static inline int intel_pmc_gcr_read(u32 offset, u32 *data)
+{
+	return -EINVAL;
+}
+
+static inline int intel_pmc_gcr_write(u32 offset, u32 data)
+{
+	return -EINVAL;
+}
+
+static inline int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
+{
+	return -EINVAL;
+}
+
 #endif /*CONFIG_INTEL_PMC_IPC*/
 
 #endif
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 0a33592..a0c773b 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -128,6 +128,7 @@ static struct intel_pmc_ipc_dev {
 	/* gcr */
 	resource_size_t gcr_base;
 	int gcr_size;
+	void __iomem *gcr_mem_base;
 	bool has_gcr_regs;
 
 	/* punit */
@@ -199,6 +200,119 @@ static inline u64 gcr_data_readq(u32 offset)
 	return readq(ipcdev.ipc_base + offset);
 }
 
+static inline int is_gcr_valid(u32 offset)
+{
+	if (!ipcdev.has_gcr_regs)
+		return -EACCES;
+
+	if (offset > PLAT_RESOURCE_GCR_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * intel_pmc_gcr_read() - Read PMC GCR register
+ * @offset:	offset of GCR register from GCR address base
+ * @data:	data pointer for storing the register output
+ *
+ * Reads the PMC GCR register of given offset.
+ *
+ * Return:	negative value on error or 0 on success.
+ */
+int intel_pmc_gcr_read(u32 offset, u32 *data)
+{
+	int ret;
+
+	mutex_lock(&ipclock);
+
+	ret = is_gcr_valid(offset);
+	if (ret < 0) {
+		mutex_unlock(&ipclock);
+		return ret;
+	}
+
+	*data = readl(ipcdev.gcr_mem_base + offset);
+
+	mutex_unlock(&ipclock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_pmc_gcr_read);
+
+/**
+ * intel_pmc_gcr_write() - Write PMC GCR register
+ * @offset:	offset of GCR register from GCR address base
+ * @data:	register update value
+ *
+ * Writes the PMC GCR register of given offset with given
+ * value.
+ *
+ * Return:	negative value on error or 0 on success.
+ */
+int intel_pmc_gcr_write(u32 offset, u32 data)
+{
+	int ret;
+
+	mutex_lock(&ipclock);
+
+	ret = is_gcr_valid(offset);
+	if (ret < 0) {
+		mutex_unlock(&ipclock);
+		return ret;
+	}
+
+	writel(data, ipcdev.gcr_mem_base + offset);
+
+	mutex_unlock(&ipclock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_pmc_gcr_write);
+
+/**
+ * intel_pmc_gcr_update() - Update PMC GCR register bits
+ * @offset:	offset of GCR register from GCR address base
+ * @mask:	bit mask for update operation
+ * @val:	update value
+ *
+ * Updates the bits of given GCR register as specified by
+ * @mask and @val.
+ *
+ * Return:	negative value on error or 0 on success.
+ */
+int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
+{
+	u32 new_val;
+	int ret = 0;
+
+	mutex_lock(&ipclock);
+
+	ret = is_gcr_valid(offset);
+	if (ret < 0)
+		goto gcr_ipc_unlock;
+
+	new_val = readl(ipcdev.gcr_mem_base + offset);
+
+	new_val &= ~mask;
+	new_val |= val & mask;
+
+	writel(new_val, ipcdev.gcr_mem_base + offset);
+
+	new_val = readl(ipcdev.gcr_mem_base + offset);
+
+	/* check whether the bit update is successful */
+	if ((new_val & mask) != (val & mask)) {
+		ret = -EIO;
+		goto gcr_ipc_unlock;
+	}
+
+gcr_ipc_unlock:
+	mutex_unlock(&ipclock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_pmc_gcr_update);
+
 static int intel_pmc_ipc_check_status(void)
 {
 	int status;
@@ -747,6 +861,7 @@ static int ipc_plat_get_res(struct platform_device *pdev)
 	ipcdev.ipc_base = addr;
 
 	ipcdev.gcr_base = res->start + PLAT_RESOURCE_GCR_OFFSET;
+	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
 	ipcdev.gcr_size = PLAT_RESOURCE_GCR_SIZE;
 	dev_info(&pdev->dev, "ipc res: %pR\n", res);
 
-- 
2.7.4

