Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Chakravarty, Souvik K" <souvik.k.chakravarty@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "x86@kernel.org" <x86@kernel.org>, "wim@iguana.be" <wim@iguana.be>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "Zha, Qipeng" <qipeng.zha@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "andy@infradead.org" <andy@infradead.org>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "sathyaosid@gmail.com" <sathyaosid@gmail.com>
Subject: RE: [RFC v5 7/8] platform/x86: intel_pmc_ipc: Use generic Intel IPC
 device calls
Date: Mon, 9 Oct 2017 05:18:37 +0000
Message-ID: <5F7315E704FA0841B5DFCE90329B2BB4661E2126@BGSMSX102.gar.corp.intel.com>
References: <cover.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dd7c7656d70de9621fa82d0175358492b39a187d.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <dd7c7656d70de9621fa82d0175358492b39a187d.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

> From: sathyanarayanan.kuppuswamy@linux.intel.com
> [mailto:sathyanarayanan.kuppuswamy@linux.intel.com]
> Sent: Sunday, October 8, 2017 3:50 AM
> To: a.zummo@towertech.it; x86@kernel.org; wim@iguana.be;
> mingo@redhat.com; alexandre.belloni@free-electrons.com; Zha, Qipeng
> <qipeng.zha@intel.com>; hpa@zytor.com; dvhart@infradead.org;
> tglx@linutronix.de; lee.jones@linaro.org; andy@infradead.org; Chakravarty,
> Souvik K <souvik.k.chakravarty@intel.com>
> Cc: linux-rtc@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> sathyaosid@gmail.com; Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Subject: [RFC v5 7/8] platform/x86: intel_pmc_ipc: Use generic Intel IPC
> device calls
> 
> From: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Removed redundant IPC helper functions and refactored the driver to use
> generic IPC device driver APIs. Also, cleaned up the driver to minimize the
> usage of global variable ipcdev by propogating the struct intel_pmc_ipc_dev
> pointer or by getting it from device private data.
> 
> This patch also cleans-up PMC IPC user drivers(intel_telemetry_pltdrv.c,
> intel_soc_pmic_bxtwc.c) to use APIs provided by generic IPC driver.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h          |  37 +--
>  drivers/mfd/intel_soc_pmic_bxtwc.c            |  21 +-
>  drivers/platform/x86/intel_pmc_ipc.c          | 393 ++++++++++----------------
>  drivers/platform/x86/intel_telemetry_pltdrv.c | 119 ++++----
>  include/linux/mfd/intel_soc_pmic.h            |   2 +
>  5 files changed, 238 insertions(+), 334 deletions(-)
> 
> Changes since v4:
>  * None
> 
> Changes since v3:
>  * Added unique name to PMC regmaps.
>  * Added support to clear interrupt bit.
>  * Added intel_ipc_dev_put() support.
> 
> Changes since v1:
>  * Removed custom APIs.
>  * Cleaned up PMC IPC user drivers to use APIs provided by generic
>    IPC driver.
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h
> b/arch/x86/include/asm/intel_pmc_ipc.h
> index fac89eb..9fc7c3c 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -1,10 +1,15 @@
>  #ifndef _ASM_X86_INTEL_PMC_IPC_H_
>  #define  _ASM_X86_INTEL_PMC_IPC_H_
> 
> +#include <linux/platform_data/x86/intel_ipc_dev.h>
> +
> +#define INTEL_PMC_IPC_DEV		"intel_pmc_ipc"
> +#define PMC_PARAM_LEN			2
> +
>  /* Commands */
>  #define PMC_IPC_PMIC_ACCESS		0xFF
> -#define		PMC_IPC_PMIC_ACCESS_READ	0x0
> -#define		PMC_IPC_PMIC_ACCESS_WRITE	0x1
> +#define	PMC_IPC_PMIC_ACCESS_READ	0x0
> +#define	PMC_IPC_PMIC_ACCESS_WRITE	0x1
>  #define PMC_IPC_USB_PWR_CTRL		0xF0
>  #define PMC_IPC_PMIC_BLACKLIST_SEL	0xEF
>  #define PMC_IPC_PHY_CONFIG		0xEE
> @@ -28,13 +33,14 @@
>  #define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
>  #define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
> 
> +static inline void pmc_cmd_init(u32 *cmd, u32 param1, u32 param2) {
> +	cmd[0] = param1;
> +	cmd[1] = param2;
> +}
> +
>  #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
> 
> -int intel_pmc_ipc_simple_command(int cmd, int sub); -int
> intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
> -		u32 *out, u32 outlen, u32 dptr, u32 sptr);
> -int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
> -		u32 *out, u32 outlen);
>  int intel_pmc_s0ix_counter_read(u64 *data);  int intel_pmc_gcr_read(u32
> offset, u32 *data);  int intel_pmc_gcr_write(u32 offset, u32 data); @@ -42,23
> +48,6 @@ int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val);
> 
>  #else
> 
> -static inline int intel_pmc_ipc_simple_command(int cmd, int sub) -{
> -	return -EINVAL;
> -}
> -
> -static inline int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32
> inlen,
> -		u32 *out, u32 outlen, u32 dptr, u32 sptr)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32
> inlen,
> -		u32 *out, u32 outlen)
> -{
> -	return -EINVAL;
> -}
> -
>  static inline int intel_pmc_s0ix_counter_read(u64 *data)  {
>  	return -EINVAL;
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c
> b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 15bc052..f9df9e7 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -271,6 +271,8 @@ static int regmap_ipc_byte_reg_read(void *context,
> unsigned int reg,
>  	u8 ipc_in[2];
>  	u8 ipc_out[4];
>  	struct intel_soc_pmic *pmic = context;
> +	u32 cmd[PMC_PARAM_LEN] = {PMC_IPC_PMIC_ACCESS,
> +		PMC_IPC_PMIC_ACCESS_READ};
> 
>  	if (!pmic)
>  		return -EINVAL;
> @@ -284,9 +286,8 @@ static int regmap_ipc_byte_reg_read(void *context,
> unsigned int reg,
> 
>  	ipc_in[0] = reg;
>  	ipc_in[1] = i2c_addr;
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
> -			PMC_IPC_PMIC_ACCESS_READ,
> -			ipc_in, sizeof(ipc_in), (u32 *)ipc_out, 1);
> +	ret = ipc_dev_raw_cmd(pmic->ipc_dev, cmd, PMC_PARAM_LEN,
> ipc_in,
> +			sizeof(ipc_in), (u32 *)ipc_out, 1, 0, 0);
>  	if (ret) {
>  		dev_err(pmic->dev, "Failed to read from PMIC\n");
>  		return ret;
> @@ -303,6 +304,8 @@ static int regmap_ipc_byte_reg_write(void *context,
> unsigned int reg,
>  	int i2c_addr;
>  	u8 ipc_in[3];
>  	struct intel_soc_pmic *pmic = context;
> +	u32 cmd[PMC_PARAM_LEN] = {PMC_IPC_PMIC_ACCESS,
> +		PMC_IPC_PMIC_ACCESS_WRITE};
> 
>  	if (!pmic)
>  		return -EINVAL;
> @@ -317,9 +320,8 @@ static int regmap_ipc_byte_reg_write(void *context,
> unsigned int reg,
>  	ipc_in[0] = reg;
>  	ipc_in[1] = i2c_addr;
>  	ipc_in[2] = val;
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
> -			PMC_IPC_PMIC_ACCESS_WRITE,
> -			ipc_in, sizeof(ipc_in), NULL, 0);
> +	ret = ipc_dev_raw_cmd(pmic->ipc_dev, cmd, PMC_PARAM_LEN,
> ipc_in,
> +			sizeof(ipc_in), NULL, 0, 0, 0);
>  	if (ret) {
>  		dev_err(pmic->dev, "Failed to write to PMIC\n");
>  		return ret;
> @@ -445,6 +447,10 @@ static int bxtwc_probe(struct platform_device
> *pdev)
>  	if (!pmic)
>  		return -ENOMEM;
> 
> +	pmic->ipc_dev = intel_ipc_dev_get(INTEL_PMC_IPC_DEV);
> +	if (IS_ERR_OR_NULL(pmic->ipc_dev))
> +		return PTR_ERR(pmic->ipc_dev);
> +
>  	ret = platform_get_irq(pdev, 0);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Invalid IRQ\n"); @@ -562,7 +568,10
> @@ static int bxtwc_probe(struct platform_device *pdev)
> 
>  static int bxtwc_remove(struct platform_device *pdev)  {
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
> +
>  	sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
> +	intel_ipc_dev_put(pmic->ipc_dev);
> 
>  	return 0;
>  }
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c
> b/drivers/platform/x86/intel_pmc_ipc.c
> index fd5bcdf..35d4734 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -47,18 +47,8 @@
>   * The ARC handles the interrupt and services it, writing optional data to
>   * the IPC1 registers, updates the IPC_STS response register with the status.
>   */
> -#define IPC_CMD			0x0
> -#define		IPC_CMD_MSI		0x100
>  #define		IPC_CMD_SIZE		16
>  #define		IPC_CMD_SUBCMD		12
> -#define IPC_STATUS		0x04
> -#define		IPC_STATUS_IRQ		0x4
> -#define		IPC_STATUS_ERR		0x2
> -#define		IPC_STATUS_BUSY		0x1
> -#define IPC_SPTR		0x08
> -#define IPC_DPTR		0x0C
> -#define IPC_WRITE_BUFFER	0x80
> -#define IPC_READ_BUFFER		0x90
> 
>  /* Residency with clock rate at 19.2MHz to usecs */
>  #define S0IX_RESIDENCY_IN_USECS(d, s)		\
> @@ -73,11 +63,6 @@
>   */
>  #define IPC_DATA_BUFFER_SIZE	16
> 
> -#define IPC_LOOP_CNT		3000000
> -#define IPC_MAX_SEC		3
> -
> -#define IPC_TRIGGER_MODE_IRQ		true
> -
>  /* exported resources from IFWI */
>  #define PLAT_RESOURCE_IPC_INDEX		0
>  #define PLAT_RESOURCE_IPC_SIZE		0x1000
> @@ -117,36 +102,41 @@
>  #define PMC_CFG_NO_REBOOT_EN		(1 << 4)
>  #define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
> 
> +/* IPC PMC commands */
> +#define	IPC_DEV_PMC_CMD_MSI			BIT(8)
> +#define	IPC_DEV_PMC_CMD_SIZE			16
> +#define	IPC_DEV_PMC_CMD_SUBCMD			12
> +#define	IPC_DEV_PMC_CMD_STATUS			BIT(2)
> +#define	IPC_DEV_PMC_CMD_STATUS_IRQ		BIT(2)
> +#define	IPC_DEV_PMC_CMD_STATUS_ERR		BIT(1)
> +#define	IPC_DEV_PMC_CMD_STATUS_ERR_MASK
> 	GENMASK(7, 0)
> +#define	IPC_DEV_PMC_CMD_STATUS_BUSY		BIT(0)
> +
> +/*IPC PMC reg offsets */
> +#define IPC_DEV_PMC_STATUS_OFFSET		0x04
> +#define IPC_DEV_PMC_SPTR_OFFSET			0x08
> +#define IPC_DEV_PMC_DPTR_OFFSET			0x0C
> +#define IPC_DEV_PMC_WRBUF_OFFSET		0x80
> +#define IPC_DEV_PMC_RBUF_OFFSET			0x90
> +
>  static struct intel_pmc_ipc_dev {
>  	struct device *dev;
> +	struct intel_ipc_dev *pmc_ipc_dev;
> +	struct intel_ipc_dev_ops ops;
> +	struct intel_ipc_dev_cfg cfg;
>  	void __iomem *ipc_base;
> -	bool irq_mode;
> -	int irq;
> -	int cmd;
> -	struct completion cmd_complete;
> 
>  	/* gcr */
>  	void __iomem *gcr_mem_base;
>  	struct regmap *gcr_regs;
>  } ipcdev;
> 
> -static char *ipc_err_sources[] = {
> -	[IPC_ERR_NONE] =
> -		"no error",
> -	[IPC_ERR_CMD_NOT_SUPPORTED] =
> -		"command not supported",
> -	[IPC_ERR_CMD_NOT_SERVICED] =
> -		"command not serviced",
> -	[IPC_ERR_UNABLE_TO_SERVICE] =
> -		"unable to service",
> -	[IPC_ERR_CMD_INVALID] =
> -		"command invalid",
> -	[IPC_ERR_CMD_FAILED] =
> -		"command failed",
> -	[IPC_ERR_EMSECURITY] =
> -		"Invalid Battery",
> -	[IPC_ERR_UNSIGNEDKERNEL] =
> -		"Unsigned kernel",
> +static struct regmap_config pmc_regmap_config = {
> +	.name = "intel_pmc_regs",
> +        .reg_bits = 32,
> +        .reg_stride = 4,
> +        .val_bits = 32,
> +	.fast_io = true,
>  };
> 
>  static struct regmap_config gcr_regmap_config = { @@ -158,40 +148,6 @@
> static struct regmap_config gcr_regmap_config = {
>  	.max_register = PLAT_RESOURCE_GCR_SIZE,  };
> 
> -/* Prevent concurrent calls to the PMC */ -static DEFINE_MUTEX(ipclock);
> -
> -static inline void ipc_send_command(u32 cmd) -{
> -	ipcdev.cmd = cmd;
> -	if (ipcdev.irq_mode) {
> -		reinit_completion(&ipcdev.cmd_complete);
> -		cmd |= IPC_CMD_MSI;
> -	}
> -	writel(cmd, ipcdev.ipc_base + IPC_CMD);
> -}
> -
> -static inline u32 ipc_read_status(void) -{
> -	return readl(ipcdev.ipc_base + IPC_STATUS);
> -}
> -
> -static inline void ipc_data_writel(u32 data, u32 offset) -{
> -	writel(data, ipcdev.ipc_base + IPC_WRITE_BUFFER + offset);
> -}
> -
> -static inline u8 __maybe_unused ipc_data_readb(u32 offset) -{
> -	return readb(ipcdev.ipc_base + IPC_READ_BUFFER + offset);
> -}
> -
> -static inline u32 ipc_data_readl(u32 offset) -{
> -	return readl(ipcdev.ipc_base + IPC_READ_BUFFER + offset);
> -}
> -
> -
>  /**
>   * intel_pmc_gcr_read() - Read PMC GCR register
>   * @offset:	offset of GCR register from GCR address base
> @@ -263,160 +219,109 @@ static int update_no_reboot_bit(void *priv, bool
> set)
>  				    PMC_CFG_NO_REBOOT_MASK, value);  }
> 
> -static int intel_pmc_ipc_check_status(void)
> +static int pre_simple_cmd_fn(u32 *cmd_list, u32 cmdlen)
>  {
> -	int status;
> -	int ret = 0;
> -
> -	if (ipcdev.irq_mode) {
> -		if (0 == wait_for_completion_timeout(
> -				&ipcdev.cmd_complete, IPC_MAX_SEC * HZ))
> -			ret = -ETIMEDOUT;
> -	} else {
> -		int loop_count = IPC_LOOP_CNT;
> -
> -		while ((ipc_read_status() & IPC_STATUS_BUSY) && --
> loop_count)
> -			udelay(1);
> -		if (loop_count == 0)
> -			ret = -ETIMEDOUT;
> -	}
> -
> -	status = ipc_read_status();
> -	if (ret == -ETIMEDOUT) {
> -		dev_err(ipcdev.dev,
> -			"IPC timed out, TS=0x%x, CMD=0x%x\n",
> -			status, ipcdev.cmd);
> -		return ret;
> -	}
> +	if (!cmd_list || cmdlen != PMC_PARAM_LEN)
> +		return -EINVAL;
> 
> -	if (status & IPC_STATUS_ERR) {
> -		int i;
> -
> -		ret = -EIO;
> -		i = (status >> IPC_CMD_SIZE) & 0xFF;
> -		if (i < ARRAY_SIZE(ipc_err_sources))
> -			dev_err(ipcdev.dev,
> -				"IPC failed: %s, STS=0x%x, CMD=0x%x\n",
> -				ipc_err_sources[i], status, ipcdev.cmd);
> -		else
> -			dev_err(ipcdev.dev,
> -				"IPC failed: unknown, STS=0x%x,
> CMD=0x%x\n",
> -				status, ipcdev.cmd);
> -		if ((i == IPC_ERR_UNSIGNEDKERNEL) || (i ==
> IPC_ERR_EMSECURITY))
> -			ret = -EACCES;
> -	}
> +	cmd_list[0] |= (cmd_list[1] << IPC_CMD_SUBCMD);
> 
> -	return ret;
> +	return 0;
>  }
> 
> -/**
> - * intel_pmc_ipc_simple_command() - Simple IPC command
> - * @cmd:	IPC command code.
> - * @sub:	IPC command sub type.
> - *
> - * Send a simple IPC command to PMC when don't need to specify
> - * input/output data and source/dest pointers.
> - *
> - * Return:	an IPC error code or 0 on success.
> - */
> -int intel_pmc_ipc_simple_command(int cmd, int sub)
> +static int pre_raw_cmd_fn(u32 *cmd_list, u32 cmdlen, u8 *in, u32 inlen,
> +		u32 *out, u32 outlen, u32 dptr, u32 sptr)
>  {
>  	int ret;
> 
> -	mutex_lock(&ipclock);
> -	if (ipcdev.dev == NULL) {
> -		mutex_unlock(&ipclock);
> -		return -ENODEV;
> -	}
> -	ipc_send_command(sub << IPC_CMD_SUBCMD | cmd);
> -	ret = intel_pmc_ipc_check_status();
> -	mutex_unlock(&ipclock);
> +	if (inlen > IPC_DATA_BUFFER_SIZE || outlen >
> IPC_DATA_BUFFER_SIZE/4)
> +		return -EINVAL;
> 
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(intel_pmc_ipc_simple_command);
> +	ret = pre_simple_cmd_fn(cmd_list, cmdlen);
> +	if (ret < 0)
> +		return ret;
> 
> -/**
> - * intel_pmc_ipc_raw_cmd() - IPC command with data and pointers
> - * @cmd:	IPC command code.
> - * @sub:	IPC command sub type.
> - * @in:		input data of this IPC command.
> - * @inlen:	input data length in bytes.
> - * @out:	output data of this IPC command.
> - * @outlen:	output data length in dwords.
> - * @sptr:	data writing to SPTR register.
> - * @dptr:	data writing to DPTR register.
> - *
> - * Send an IPC command to PMC with input/output data and source/dest
> pointers.
> - *
> - * Return:	an IPC error code or 0 on success.
> - */
> -int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen, u32 *out,
> -			  u32 outlen, u32 dptr, u32 sptr)
> -{
> -	u32 wbuf[4] = { 0 };
> -	int ret;
> -	int i;
> +	cmd_list[0] |= (inlen << IPC_CMD_SIZE);
> 
> -	if (inlen > IPC_DATA_BUFFER_SIZE || outlen >
> IPC_DATA_BUFFER_SIZE / 4)
> -		return -EINVAL;
> +	return 0;
> +}
> 
> -	mutex_lock(&ipclock);
> -	if (ipcdev.dev == NULL) {
> -		mutex_unlock(&ipclock);
> -		return -ENODEV;
> -	}
> -	memcpy(wbuf, in, inlen);
> -	writel(dptr, ipcdev.ipc_base + IPC_DPTR);
> -	writel(sptr, ipcdev.ipc_base + IPC_SPTR);
> -	/* The input data register is 32bit register and inlen is in Byte */
> -	for (i = 0; i < ((inlen + 3) / 4); i++)
> -		ipc_data_writel(wbuf[i], 4 * i);
> -	ipc_send_command((inlen << IPC_CMD_SIZE) |
> -			(sub << IPC_CMD_SUBCMD) | cmd);
> -	ret = intel_pmc_ipc_check_status();
> -	if (!ret) {
> -		/* out is read from 32bit register and outlen is in 32bit */
> -		for (i = 0; i < outlen; i++)
> -			*out++ = ipc_data_readl(4 * i);
> -	}
> -	mutex_unlock(&ipclock);
> +static int pre_irq_handler_fn(struct intel_ipc_dev *ipc_dev, int irq) {
> +	return regmap_write_bits(ipc_dev->cfg->cmd_regs,
> +				  ipc_dev->cfg->status_reg,
> +				  IPC_DEV_PMC_CMD_STATUS_IRQ,
> +				  IPC_DEV_PMC_CMD_STATUS_IRQ);
> +}
> 
> -	return ret;
> +static int pmc_ipc_err_code(int status) {
> +	return ((status >> IPC_DEV_PMC_CMD_SIZE) &
> +			IPC_DEV_PMC_CMD_STATUS_ERR_MASK);
>  }
> -EXPORT_SYMBOL_GPL(intel_pmc_ipc_raw_cmd);
> 
> -/**
> - * intel_pmc_ipc_command() -  IPC command with input/output data
> - * @cmd:	IPC command code.
> - * @sub:	IPC command sub type.
> - * @in:		input data of this IPC command.
> - * @inlen:	input data length in bytes.
> - * @out:	output data of this IPC command.
> - * @outlen:	output data length in dwords.
> - *
> - * Send an IPC command to PMC with input/output data.
> - *
> - * Return:	an IPC error code or 0 on success.
> - */
> -int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
> -			  u32 *out, u32 outlen)
> +static int pmc_ipc_busy_check(int status)
>  {
> -	return intel_pmc_ipc_raw_cmd(cmd, sub, in, inlen, out, outlen, 0, 0);
> +	return status | IPC_DEV_PMC_CMD_STATUS_BUSY;
>  }
> -EXPORT_SYMBOL_GPL(intel_pmc_ipc_command);
> 
> -static irqreturn_t ioc(int irq, void *dev_id)
> +static u32 pmc_ipc_enable_msi(u32 cmd)
>  {
> -	int status;
> +	return cmd | IPC_DEV_PMC_CMD_MSI;
> +}
> 
> -	if (ipcdev.irq_mode) {
> -		status = ipc_read_status();
> -		writel(status | IPC_STATUS_IRQ, ipcdev.ipc_base +
> IPC_STATUS);
> -	}
> -	complete(&ipcdev.cmd_complete);
> +static struct intel_ipc_dev *intel_pmc_ipc_dev_create(
> +		struct device *pmc_dev,
> +		void __iomem *base,
> +		int irq)
> +{
> +	struct intel_ipc_dev_ops *ops;
> +	struct intel_ipc_dev_cfg *cfg;
> +	struct regmap *cmd_regs;
> +
> +	cfg = devm_kzalloc(pmc_dev, sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ops = devm_kzalloc(pmc_dev, sizeof(*ops), GFP_KERNEL);
> +	if (!ops)
> +		return ERR_PTR(-ENOMEM);
> +
> +        cmd_regs = devm_regmap_init_mmio_clk(pmc_dev, NULL, base,
> +			&pmc_regmap_config);
> +        if (IS_ERR(cmd_regs)) {
> +                dev_err(pmc_dev, "cmd_regs regmap init failed\n");
> +                return ERR_CAST(cmd_regs);;
> +        }
> 
> -	return IRQ_HANDLED;
> +	/* set IPC dev ops */
> +	ops->to_err_code = pmc_ipc_err_code;
> +	ops->busy_check = pmc_ipc_busy_check;
> +	ops->enable_msi = pmc_ipc_enable_msi;
> +	ops->pre_raw_cmd_fn = pre_raw_cmd_fn;
> +	ops->pre_simple_cmd_fn = pre_simple_cmd_fn;
> +	ops->pre_irq_handler_fn = pre_irq_handler_fn;
> +
> +	/* set cfg options */
> +	if (irq > 0)
> +		cfg->mode = IPC_DEV_MODE_IRQ;
> +	else
> +		cfg->mode = IPC_DEV_MODE_POLLING;
> +
> +	cfg->chan_type = IPC_CHANNEL_IA_PMC;
> +	cfg->irq = irq;
> +	cfg->use_msi = true;
> +	cfg->support_sptr = true;
> +	cfg->support_dptr = true;
> +	cfg->cmd_regs = cmd_regs;
> +	cfg->data_regs = cmd_regs;
> +	cfg->wrbuf_reg = IPC_DEV_PMC_WRBUF_OFFSET;
> +	cfg->rbuf_reg = IPC_DEV_PMC_RBUF_OFFSET;
> +	cfg->sptr_reg = IPC_DEV_PMC_SPTR_OFFSET;
> +	cfg->dptr_reg = IPC_DEV_PMC_DPTR_OFFSET;
> +	cfg->status_reg = IPC_DEV_PMC_STATUS_OFFSET;
> +
> +	return devm_intel_ipc_dev_create(pmc_dev, INTEL_PMC_IPC_DEV,
> cfg,
> +ops);
>  }
> 
>  static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> @@ -428,8 +333,6 @@ static int ipc_pci_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>  	if (pmc->dev)
>  		return -EBUSY;
> 
> -	pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
> -
>  	ret = pcim_enable_device(pdev);
>  	if (ret)
>  		return ret;
> @@ -438,15 +341,14 @@ static int ipc_pci_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  	if (ret)
>  		return ret;
> 
> -	init_completion(&pmc->cmd_complete);
> -
>  	pmc->ipc_base = pcim_iomap_table(pdev)[0];
> 
> -	ret = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0,
> "intel_pmc_ipc",
> -				pmc);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request irq\n");
> -		return ret;
> +	pmc->pmc_ipc_dev = intel_pmc_ipc_dev_create(&pdev->dev,
> +			pmc->ipc_base, pdev->irq);
> +	if (IS_ERR(pmc->pmc_ipc_dev)) {
> +		dev_err(&pdev->dev,
> +				"Failed to create PMC IPC device\n");
> +		return PTR_ERR(pmc->pmc_ipc_dev);
>  	}
> 
>  	pmc->dev = &pdev->dev;
> @@ -474,19 +376,19 @@ static ssize_t
> intel_pmc_ipc_simple_cmd_store(struct device *dev,
>  					      struct device_attribute *attr,
>  					      const char *buf, size_t count)  {
> -	int subcmd;
> -	int cmd;
> +	struct intel_pmc_ipc_dev *pmc = dev_get_drvdata(dev);
> +	int cmd[2];
>  	int ret;
> 
> -	ret = sscanf(buf, "%d %d", &cmd, &subcmd);
> +	ret = sscanf(buf, "%d %d", &cmd[0], &cmd[2]);
>  	if (ret != 2) {
>  		dev_err(dev, "Error args\n");
>  		return -EINVAL;
>  	}
> 
> -	ret = intel_pmc_ipc_simple_command(cmd, subcmd);
> +	ret = ipc_dev_simple_cmd(pmc->pmc_ipc_dev, cmd, 2);
>  	if (ret) {
> -		dev_err(dev, "command %d error with %d\n", cmd, ret);
> +		dev_err(dev, "command %d error with %d\n", cmd[0], ret);
>  		return ret;
>  	}
>  	return (ssize_t)count;
> @@ -496,22 +398,23 @@ static ssize_t
> intel_pmc_ipc_northpeak_store(struct device *dev,
>  					     struct device_attribute *attr,
>  					     const char *buf, size_t count)  {
> +	struct intel_pmc_ipc_dev *pmc = dev_get_drvdata(dev);
>  	unsigned long val;
> -	int subcmd;
> +	int cmd[2] = {PMC_IPC_NORTHPEAK_CTRL, 0};
>  	int ret;
> 
>  	if (kstrtoul(buf, 0, &val))
>  		return -EINVAL;
> 
>  	if (val)
> -		subcmd = 1;
> -	else
> -		subcmd = 0;
> -	ret = intel_pmc_ipc_simple_command(PMC_IPC_NORTHPEAK_CTRL,
> subcmd);
> +		cmd[1] = 1;
> +
> +	ret = ipc_dev_simple_cmd(pmc->pmc_ipc_dev, cmd, 2);
>  	if (ret) {
> -		dev_err(dev, "command north %d error with %d\n", subcmd,
> ret);
> +		dev_err(dev, "command north %d error with %d\n", cmd[1],
> ret);
>  		return ret;
>  	}
> +
>  	return (ssize_t)count;
>  }
> 
> @@ -689,6 +592,7 @@ static int ipc_create_pmc_devices(struct
> platform_device *pdev)
> 
>  static int ipc_plat_get_res(struct platform_device *pdev)  {
> +	struct intel_pmc_ipc_dev *pmc = dev_get_drvdata(&pdev->dev);
>  	struct resource *res;
>  	void __iomem *addr;
> 
> @@ -707,9 +611,9 @@ static int ipc_plat_get_res(struct platform_device
> *pdev)
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> 
> -	ipcdev.ipc_base = addr;
> -	ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
> -	dev_dbg(&pdev->dev, "PMC IPC resource %pR\n", res);
> +	pmc->ipc_base = addr;
> +	pmc->gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
> +	dev_info(&pdev->dev, "PMC IPC resource %pR\n", res);
> 
>  	return 0;
>  }
> @@ -755,14 +659,15 @@ MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
> 
>  static int ipc_plat_probe(struct platform_device *pdev)  {
> -	int ret;
> +	int ret, irq;
> +	struct intel_pmc_ipc_dev *pmc = &ipcdev;
> +
> +	pmc->dev = &pdev->dev;
> 
> -	ipcdev.dev = &pdev->dev;
> -	ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
> -	init_completion(&ipcdev.cmd_complete);
> +	dev_set_drvdata(&pdev->dev, pmc);
> 
> -	ipcdev.irq = platform_get_irq(pdev, 0);
> -	if (ipcdev.irq < 0) {
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
>  		dev_err(&pdev->dev, "Failed to get irq\n");
>  		return -EINVAL;
>  	}
> @@ -773,11 +678,11 @@ static int ipc_plat_probe(struct platform_device
> *pdev)
>  		return ret;
>  	}
> 
> -        ipcdev.gcr_regs = devm_regmap_init_mmio_clk(ipcdev.dev, NULL,
> -			ipcdev.gcr_mem_base, &gcr_regmap_config);
> -        if (IS_ERR(ipcdev.gcr_regs)) {
> -                dev_err(ipcdev.dev, "gcr_regs regmap init failed\n");
> -                return PTR_ERR(ipcdev.gcr_regs);;
> +        pmc->gcr_regs = devm_regmap_init_mmio_clk(pmc->dev, NULL,
> +			pmc->gcr_mem_base, &gcr_regmap_config);
> +        if (IS_ERR(pmc->gcr_regs)) {
> +                dev_err(&pdev->dev, "gcr_regs regmap init failed\n");
> +                return PTR_ERR(pmc->gcr_regs);;

Extra semicolon on preceding line.

>          }
> 
>  	ret = ipc_create_pmc_devices(pdev);
> @@ -786,20 +691,20 @@ static int ipc_plat_probe(struct platform_device
> *pdev)
>  		return ret;
>  	}
> 
> -	if (devm_request_irq(&pdev->dev, ipcdev.irq, ioc,
> IRQF_NO_SUSPEND,
> -			     "intel_pmc_ipc", &ipcdev)) {
> -		dev_err(&pdev->dev, "Failed to request irq\n");
> -		return -EBUSY;
> -	}
> -
>  	ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
>  			ret);
> -		devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
>  		return ret;
>  	}
> 
> +	ipcdev.pmc_ipc_dev = intel_pmc_ipc_dev_create(&pdev->dev,
> +			pmc->ipc_base, irq);
> +	if (IS_ERR(pmc->pmc_ipc_dev)) {
> +		dev_err(&pdev->dev, "Failed to create PMC IPC device\n");
> +		return PTR_ERR(pmc->pmc_ipc_dev);
> +	}
> +
>  	return 0;
>  }
> 

This part below can logically be a separate patch (alongwith intel_soc_pmic_bxtwc.c file too)

> diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c
> b/drivers/platform/x86/intel_telemetry_pltdrv.c
> index bf8284a..a08a620 100644
> --- a/drivers/platform/x86/intel_telemetry_pltdrv.c
> +++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
> @@ -56,10 +56,6 @@
>  #define IOSS_TELEM_TRACE_CTL_WRITE	0x6
>  #define IOSS_TELEM_EVENT_CTL_READ	0x7
>  #define IOSS_TELEM_EVENT_CTL_WRITE	0x8
> -#define IOSS_TELEM_EVT_CTRL_WRITE_SIZE	0x4
> -#define IOSS_TELEM_READ_WORD		0x1
> -#define IOSS_TELEM_WRITE_FOURBYTES	0x4
> -#define IOSS_TELEM_EVT_WRITE_SIZE	0x3
> 
>  #define TELEM_INFO_SRAMEVTS_MASK	0xFF00
>  #define TELEM_INFO_SRAMEVTS_SHIFT	0x8
> @@ -98,7 +94,7 @@ struct telem_ssram_region {  };
> 
>  static struct telemetry_plt_config *telm_conf; -static struct intel_ipc_dev
> *punit_bios_ipc_dev;
> +static struct intel_ipc_dev *punit_bios_ipc_dev, *pmc_ipc_dev;
> 
>  /*
>   * The following counters are programmed by default during setup.
> @@ -267,17 +263,16 @@ static int telemetry_check_evtid(enum
> telemetry_unit telem_unit,  static inline int
> telemetry_plt_config_ioss_event(u32 evt_id, int index)  {
>  	u32 write_buf;
> -	int ret;
> +	u32 cmd[PMC_PARAM_LEN] = {0};
> 
>  	write_buf = evt_id | TELEM_EVENT_ENABLE;
>  	write_buf <<= BITS_PER_BYTE;
>  	write_buf |= index;
> 
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				    IOSS_TELEM_EVENT_WRITE, (u8
> *)&write_buf,
> -				    IOSS_TELEM_EVT_WRITE_SIZE, NULL, 0);
> +	pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_EVENT_WRITE);
> 
> -	return ret;
> +	return ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN,
> +			(u8 *)&write_buf, sizeof(write_buf), NULL, 0, 0, 0);

1) Why use raw_cmd here? It should use ipc_dev_cmd() according to original design. Same everywhere though this file.
2) pmc_cmd_init and ipc_dev_raw_cmd are repeated multiple time thoughout the file. They can be made into a separate local API inside telemetry, like telemetry_pmc_send_cmd(). Same thoughout.

>  }
> 
>  static inline int telemetry_plt_config_pss_event(u32 evt_id, int index) @@ -
> 287,6 +282,7 @@ static inline int telemetry_plt_config_pss_event(u32
> evt_id, int index)
> 
>  	write_buf = evt_id | TELEM_EVENT_ENABLE;
>  	punit_cmd_init(cmd, IPC_PUNIT_BIOS_WRITE_TELE_EVENT, index, 0);
> +
>  	return ipc_dev_raw_cmd(punit_bios_ipc_dev, cmd,
> PUNIT_PARAM_LEN,
>  			(u8 *)&write_buf, sizeof(write_buf), NULL, 0, 0, 0);  }
> @@ -298,15 +294,16 @@ static int telemetry_setup_iossevtconfig(struct
> telemetry_evtconfig evtconfig,
>  	int ret, index, idx;
>  	u32 *ioss_evtmap;
>  	u32 telem_ctrl;
> +	u32 cmd[PMC_PARAM_LEN] = {0};
> 
>  	num_ioss_evts = evtconfig.num_evts;
>  	ioss_period = evtconfig.period;
>  	ioss_evtmap = evtconfig.evtmap;
> 
>  	/* Get telemetry EVENT CTL */
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
> -				    &telem_ctrl, IOSS_TELEM_READ_WORD);
> +	pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_EVENT_CTL_READ);
> +	ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN, NULL,
> 0,
> +			&telem_ctrl, 1, 0, 0);
>  	if (ret) {
>  		pr_err("IOSS TELEM_CTRL Read Failed\n");
>  		return ret;
> @@ -314,12 +311,9 @@ static int telemetry_setup_iossevtconfig(struct
> telemetry_evtconfig evtconfig,
> 
>  	/* Disable Telemetry */
>  	TELEM_DISABLE(telem_ctrl);
> -
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				    IOSS_TELEM_EVENT_CTL_WRITE,
> -				    (u8 *)&telem_ctrl,
> -				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -				    NULL, 0);
> +	pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_EVENT_CTL_WRITE);
> +	ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN,
> +			(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL, 0, 0, 0);
>  	if (ret) {
>  		pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
>  		return ret;
> @@ -330,12 +324,11 @@ static int telemetry_setup_iossevtconfig(struct
> telemetry_evtconfig evtconfig,
>  	if (action == TELEM_RESET) {
>  		/* Clear All Events */
>  		TELEM_CLEAR_EVENTS(telem_ctrl);
> -
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -
> IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -					    NULL, 0);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_EVENT_CTL_WRITE);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN,
> +				(u8 *)&telem_ctrl, sizeof(telem_ctrl),
> +				NULL, 0, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Disable Write
> Failed\n");
>  			return ret;
> @@ -360,11 +353,11 @@ static int telemetry_setup_iossevtconfig(struct
> telemetry_evtconfig evtconfig,
>  		/* Clear All Events */
>  		TELEM_CLEAR_EVENTS(telem_ctrl);
> 
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -
> IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -					    NULL, 0);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_EVENT_CTL_WRITE);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN,
> +				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
> +				0, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Disable Write
> Failed\n");
>  			return ret;
> @@ -412,10 +405,9 @@ static int telemetry_setup_iossevtconfig(struct
> telemetry_evtconfig evtconfig,
>  	TELEM_ENABLE_PERIODIC(telem_ctrl);
>  	telem_ctrl |= ioss_period;
> 
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				    IOSS_TELEM_EVENT_CTL_WRITE,
> -				    (u8 *)&telem_ctrl,
> -				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE, NULL,
> 0);
> +	pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_EVENT_CTL_WRITE);
> +	ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN,
> +			(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL, 0, 0, 0);
>  	if (ret) {
>  		pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
>  		return ret;
> @@ -609,8 +601,9 @@ static int telemetry_setup(struct platform_device
> *pdev)
>  	u32 cmd[PUNIT_PARAM_LEN] = {0};
>  	int ret;
> 
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_INFO_READ,
> -				    NULL, 0, &read_buf,
> IOSS_TELEM_READ_WORD);
> +	pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_INFO_READ);
> +	ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd, PMC_PARAM_LEN, NULL,
> 0,
> +			&read_buf, 1, 0, 0);
>  	if (ret) {
>  		dev_err(&pdev->dev, "IOSS TELEM_INFO Read Failed\n");
>  		return ret;
> @@ -713,9 +706,10 @@ static int telemetry_plt_set_sampling_period(u8
> pss_period, u8 ioss_period)
>  		}
> 
>  		/* Get telemetry EVENT CTL */
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_READ,
> NULL, 0,
> -					    &telem_ctrl,
> IOSS_TELEM_READ_WORD);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_EVENT_CTL_READ);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN, NULL, 0,
> +				&telem_ctrl, 1, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Read Failed\n");
>  			goto out;
> @@ -723,12 +717,11 @@ static int telemetry_plt_set_sampling_period(u8
> pss_period, u8 ioss_period)
> 
>  		/* Disable Telemetry */
>  		TELEM_DISABLE(telem_ctrl);
> -
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -
> IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -					    NULL, 0);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_EVENT_CTL_WRITE);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN,
> +				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
> +				0, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Disable Write
> Failed\n");
>  			goto out;
> @@ -740,11 +733,11 @@ static int telemetry_plt_set_sampling_period(u8
> pss_period, u8 ioss_period)
>  		TELEM_ENABLE_PERIODIC(telem_ctrl);
>  		telem_ctrl |= ioss_period;
> 
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -
> IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -					    NULL, 0);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_EVENT_CTL_WRITE);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN,
> +				(u8 *)&telem_ctrl, sizeof(telem_ctrl), NULL,
> +				0, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Enable Write
> Failed\n");
>  			goto out;
> @@ -1044,9 +1037,10 @@ static int
> telemetry_plt_get_trace_verbosity(enum telemetry_unit telem_unit,
>  		break;
> 
>  	case TELEM_IOSS:
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				IOSS_TELEM_TRACE_CTL_READ, NULL, 0,
> &temp,
> -				IOSS_TELEM_READ_WORD);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_TRACE_CTL_READ);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN, NULL, 0,
> +				&temp, 1, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TRACE_CTL Read Failed\n");
>  			goto out;
> @@ -1099,9 +1093,10 @@ static int
> telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
>  		break;
> 
>  	case TELEM_IOSS:
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				IOSS_TELEM_TRACE_CTL_READ, NULL, 0,
> &temp,
> -				IOSS_TELEM_READ_WORD);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> +				IOSS_TELEM_TRACE_CTL_READ);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN, NULL, 0,
> +				&temp, 1, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TRACE_CTL Read Failed\n");
>  			goto out;
> @@ -1109,10 +1104,9 @@ static int
> telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
> 
>  		TELEM_CLEAR_VERBOSITY_BITS(temp);
>  		TELEM_SET_VERBOSITY_BITS(temp, verbosity);
> -
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				IOSS_TELEM_TRACE_CTL_WRITE, (u8
> *)&temp,
> -				IOSS_TELEM_WRITE_FOURBYTES, NULL, 0);
> +		pmc_cmd_init(cmd, PMC_IPC_PMC_TELEMTRY,
> IOSS_TELEM_TRACE_CTL_WRITE);
> +		ret = ipc_dev_raw_cmd(pmc_ipc_dev, cmd,
> PMC_PARAM_LEN,
> +				(u8 *)&temp, sizeof(temp), NULL, 0, 0, 0);
>  		if (ret) {
>  			pr_err("IOSS TRACE_CTL Verbosity Set Failed\n");
>  			goto out;
> @@ -1157,6 +1151,10 @@ static int telemetry_pltdrv_probe(struct
> platform_device *pdev)
>  	if (IS_ERR_OR_NULL(punit_bios_ipc_dev))
>  		return PTR_ERR(punit_bios_ipc_dev);
> 
> +	pmc_ipc_dev = intel_ipc_dev_get(INTEL_PMC_IPC_DEV);
> +	if (IS_ERR_OR_NULL(pmc_ipc_dev))
> +		return PTR_ERR(pmc_ipc_dev);
> +
>  	telm_conf = (struct telemetry_plt_config *)id->driver_data;
> 
>  	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0); @@ -
> 1236,6 +1234,7 @@ static int telemetry_pltdrv_probe(struct platform_device
> *pdev)  static int telemetry_pltdrv_remove(struct platform_device *pdev)  {
>  	telemetry_clear_pltdata();
> +	intel_ipc_dev_put(pmc_ipc_dev);
>  	intel_ipc_dev_put(punit_bios_ipc_dev);
>  	iounmap(telm_conf->pss_config.regmap);
>  	iounmap(telm_conf->ioss_config.regmap);
> diff --git a/include/linux/mfd/intel_soc_pmic.h
> b/include/linux/mfd/intel_soc_pmic.h
> index 5aacdb0..7cc39b6 100644
> --- a/include/linux/mfd/intel_soc_pmic.h
> +++ b/include/linux/mfd/intel_soc_pmic.h
> @@ -20,6 +20,7 @@
>  #define __INTEL_SOC_PMIC_H__
> 
>  #include <linux/regmap.h>
> +#include <linux/platform_data/x86/intel_ipc_dev.h>
> 
>  struct intel_soc_pmic {
>  	int irq;
> @@ -31,6 +32,7 @@ struct intel_soc_pmic {
>  	struct regmap_irq_chip_data *irq_chip_data_chgr;
>  	struct regmap_irq_chip_data *irq_chip_data_crit;
>  	struct device *dev;
> +	struct intel_ipc_dev *ipc_dev;
>  };
> 
>  #endif	/* __INTEL_SOC_PMIC_H__ */
> --
> 2.7.4
