Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10023 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdJDAzh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Oct 2017 20:55:37 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [RFC v3 7/7] platform/x86: intel_scu_ipc: Use generic Intel IPC
 device calls
To: Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, qipeng.zha@intel.com, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, lee.jones@linaro.org,
        andy@infradead.org, souvik.k.chakravarty@intel.com,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sathyaosid@gmail.com
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <90f4d15c9ca0430f6ac4cfafe0eaf6ece6c8761c.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170928125519.ol5suebaoqsiixm5@piout.net>
 <c8f64c42-9802-9746-3032-b932522659e5@roeck-us.net>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a728adc5-e136-e603-27c1-66357870e169@linux.intel.com>
Date: Tue, 3 Oct 2017 17:55:21 -0700
MIME-Version: 1.0
In-Reply-To: <c8f64c42-9802-9746-3032-b932522659e5@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,


On 09/28/2017 06:35 AM, Guenter Roeck wrote:
> On 09/28/2017 05:55 AM, Alexandre Belloni wrote:
>> On 04/09/2017 at 22:37:27 -0700, 
>> sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>> From: Kuppuswamy Sathyanarayanan 
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> Removed redundant IPC helper functions and refactored the driver to use
>>> generic IPC device driver APIs.
>>>
>>> This patch also cleans-up SCU IPC user drivers to use APIs provided
>>> by generic IPC driver.
>>>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> For the RTC part:
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>  >
>>> ---
>>>   arch/x86/include/asm/intel_scu_ipc.h    |  23 +-
>>>   arch/x86/platform/intel-mid/intel-mid.c |  12 +-
>>>   drivers/platform/x86/Kconfig            |   1 +
>>>   drivers/platform/x86/intel_scu_ipc.c    | 483 
>>> +++++++++++++-------------------
>>>   drivers/rtc/rtc-mrst.c                  |  15 +-
>>>   drivers/watchdog/intel-mid_wdt.c        |  12 +-
>>>   drivers/watchdog/intel_scu_watchdog.c   |  17 +-
>>>   7 files changed, 251 insertions(+), 312 deletions(-)
>
> I think it would help in general to mention at least in the 
> description which drivers are touched.
I will add this info in my next patch version.
>
> I see calls to intel_ipc_dev_get() but not associated put calls. 
> Missing the context, it may
> well be that those are not necessary, but then how does the ipc code 
> know that the device
> reference is no longer needed ?
I also noticed this issue. Initially I thought we don't need to deal 
with ref count because in most
cases IPC client drivers are compiled as built-in drivers ( because 
these APIs are required during
early boot process to send IPC commands to ARC processor) and hence will 
have life-time until the
device is powered-off.

But after looking into Kconfig params, I noticed that at least 
intel_pmc_ipc and intel_punit_ipc drivers can be
compiled as modules. And hence we will have dangling pointer reference 
issue if we don't maintain
proper refcount for device references.

So, I have already fixed this problem by adding intel_ipc_dev_put() and  
devm_intel_ipc_dev_get() APIs.

This fix will be available in next version.

> Guenter
>
>>>
>>> diff --git a/arch/x86/include/asm/intel_scu_ipc.h 
>>> b/arch/x86/include/asm/intel_scu_ipc.h
>>> index 81d3d87..5842534 100644
>>> --- a/arch/x86/include/asm/intel_scu_ipc.h
>>> +++ b/arch/x86/include/asm/intel_scu_ipc.h
>>> @@ -14,9 +14,19 @@
>>>   #define IPCMSG_COLD_BOOT    0xF3
>>>     #define IPCMSG_VRTC        0xFA     /* Set vRTC device */
>>> -    /* Command id associated with message IPCMSG_VRTC */
>>> -    #define IPC_CMD_VRTC_SETTIME      1 /* Set time */
>>> -    #define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
>>> +
>>> +/* Command id associated with message IPCMSG_VRTC */
>>> +#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
>>> +#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
>>> +
>>> +#define INTEL_SCU_IPC_DEV    "intel_scu_ipc"
>>> +#define SCU_PARAM_LEN        2
>>> +
>>> +static inline void scu_cmd_init(u32 *cmd, u32 param1, u32 param2)
>>> +{
>>> +    cmd[0] = param1;
>>> +    cmd[1] = param2;
>>> +}
>>>     /* Read single register */
>>>   int intel_scu_ipc_ioread8(u16 addr, u8 *data);
>>> @@ -45,13 +55,6 @@ int intel_scu_ipc_writev(u16 *addr, u8 *data, int 
>>> len);
>>>   /* Update single register based on the mask */
>>>   int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
>>>   -/* Issue commands to the SCU with or without data */
>>> -int intel_scu_ipc_simple_command(int cmd, int sub);
>>> -int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>>> -              u32 *out, int outlen);
>>> -int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
>>> -                  u32 *out, int outlen, u32 dptr, u32 sptr);
>>> -
>>>   /* I2C control api */
>>>   int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data);
>>>   diff --git a/arch/x86/platform/intel-mid/intel-mid.c 
>>> b/arch/x86/platform/intel-mid/intel-mid.c
>>> index 12a2725..27541e9 100644
>>> --- a/arch/x86/platform/intel-mid/intel-mid.c
>>> +++ b/arch/x86/platform/intel-mid/intel-mid.c
>>> @@ -22,6 +22,7 @@
>>>   #include <linux/irq.h>
>>>   #include <linux/export.h>
>>>   #include <linux/notifier.h>
>>> +#include <linux/platform_data/x86/intel_ipc_dev.h>
>>>     #include <asm/setup.h>
>>>   #include <asm/mpspec_def.h>
>>> @@ -68,18 +69,23 @@ static void *(*get_intel_mid_ops[])(void) = 
>>> INTEL_MID_OPS_INIT;
>>>   enum intel_mid_cpu_type __intel_mid_cpu_chip;
>>>   EXPORT_SYMBOL_GPL(__intel_mid_cpu_chip);
>>>   +static struct intel_ipc_dev *ipc_dev;
>>> +
>>>   static void intel_mid_power_off(void)
>>>   {
>>> +    u32 cmds[SCU_PARAM_LEN] = {IPCMSG_COLD_OFF, 1};
>>>       /* Shut down South Complex via PWRMU */
>>>       intel_mid_pwr_power_off();
>>>         /* Only for Tangier, the rest will ignore this command */
>>> -    intel_scu_ipc_simple_command(IPCMSG_COLD_OFF, 1);
>>> +    ipc_dev_simple_cmd(ipc_dev, cmds, SCU_PARAM_LEN);
>>>   };
>>>     static void intel_mid_reboot(void)
>>>   {
>>> -    intel_scu_ipc_simple_command(IPCMSG_COLD_BOOT, 0);
>>> +    u32 cmds[SCU_PARAM_LEN] = {IPCMSG_COLD_BOOT, 0};
>>> +
>>> +    ipc_dev_simple_cmd(ipc_dev, cmds, SCU_PARAM_LEN);
>>>   }
>>>     static unsigned long __init intel_mid_calibrate_tsc(void)
>>> @@ -206,6 +212,8 @@ void __init x86_intel_mid_early_setup(void)
>>>       x86_init.mpparse.find_smp_config = x86_init_noop;
>>>       x86_init.mpparse.get_smp_config = x86_init_uint_noop;
>>>       set_bit(MP_BUS_ISA, mp_bus_not_pci);
>>> +
>>> +    ipc_dev = intel_ipc_dev_get(INTEL_SCU_IPC_DEV);
>>>   }
>>>     /*
>>> diff --git a/drivers/platform/x86/Kconfig 
>>> b/drivers/platform/x86/Kconfig
>>> index 82479ca..e4e5822 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -850,6 +850,7 @@ config INTEL_VBTN
>>>   config INTEL_SCU_IPC
>>>       bool "Intel SCU IPC Support"
>>>       depends on X86_INTEL_MID
>>> +    select REGMAP_MMIO
>>>       default y
>>>       ---help---
>>>         IPC is used to bridge the communications between kernel and 
>>> SCU on
>>> diff --git a/drivers/platform/x86/intel_scu_ipc.c 
>>> b/drivers/platform/x86/intel_scu_ipc.c
>>> index f7cf981..78013e4 100644
>>> --- a/drivers/platform/x86/intel_scu_ipc.c
>>> +++ b/drivers/platform/x86/intel_scu_ipc.c
>>> @@ -24,6 +24,8 @@
>>>   #include <linux/pci.h>
>>>   #include <linux/interrupt.h>
>>>   #include <linux/sfi.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/platform_data/x86/intel_ipc_dev.h>
>>>   #include <asm/intel-mid.h>
>>>   #include <asm/intel_scu_ipc.h>
>>>   @@ -39,6 +41,25 @@
>>>   #define IPC_CMD_PCNTRL_R      1 /* Register read */
>>>   #define IPC_CMD_PCNTRL_M      2 /* Register read-modify-write */
>>>   +/* IPC dev register offsets */
>>> +/*
>>> + * IPC Read Buffer (Read Only):
>>> + * 16 byte buffer for receiving data from SCU, if IPC command
>>> + * processing results in response data
>>> + */
>>> +#define IPC_DEV_SCU_RBUF_OFFSET            0x90
>>> +#define IPC_DEV_SCU_WRBUF_OFFSET        0x80
>>> +#define IPC_DEV_SCU_SPTR_OFFSET            0x08
>>> +#define IPC_DEV_SCU_DPTR_OFFSET            0x0C
>>> +#define IPC_DEV_SCU_STATUS_OFFSET        0x04
>>> +
>>> +/* IPC dev commands */
>>> +/* IPC command register IOC bit */
>>> +#define    IPC_DEV_SCU_CMD_MSI            BIT(8)
>>> +#define    IPC_DEV_SCU_CMD_STATUS_ERR        BIT(1)
>>> +#define    IPC_DEV_SCU_CMD_STATUS_ERR_MASK        GENMASK(7, 0)
>>> +#define    IPC_DEV_SCU_CMD_STATUS_BUSY        BIT(0)
>>> +
>>>   /*
>>>    * IPC register summary
>>>    *
>>> @@ -59,6 +80,11 @@
>>>   #define IPC_WWBUF_SIZE    20        /* IPC Write buffer Size */
>>>   #define IPC_RWBUF_SIZE    20        /* IPC Read buffer Size */
>>>   #define IPC_IOC              0x100        /* IPC command register 
>>> IOC bit */
>>> +#define    IPC_CMD_SIZE            16
>>> +#define    IPC_CMD_SUBCMD          12
>>> +#define    IPC_RWBUF_SIZE_DWORD    5
>>> +#define    IPC_WWBUF_SIZE_DWORD    5
>>> +
>>>     #define PCI_DEVICE_ID_LINCROFT        0x082a
>>>   #define PCI_DEVICE_ID_PENWELL        0x080e
>>> @@ -93,140 +119,49 @@ static struct intel_scu_ipc_pdata_t 
>>> intel_scu_ipc_tangier_pdata = {
>>>     struct intel_scu_ipc_dev {
>>>       struct device *dev;
>>> +    struct intel_ipc_dev *ipc_dev;
>>>       void __iomem *ipc_base;
>>>       void __iomem *i2c_base;
>>> -    struct completion cmd_complete;
>>> +    struct regmap *ipc_regs;
>>> +    struct regmap *i2c_regs;
>>>       u8 irq_mode;
>>>   };
>>>   -static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
>>> +static struct regmap_config ipc_regmap_config = {
>>> +        .reg_bits = 32,
>>> +        .reg_stride = 4,
>>> +        .val_bits = 32,
>>> +};
>>>   -/*
>>> - * IPC Read Buffer (Read Only):
>>> - * 16 byte buffer for receiving data from SCU, if IPC command
>>> - * processing results in response data
>>> - */
>>> -#define IPC_READ_BUFFER        0x90
>>> +static struct regmap_config i2c_regmap_config = {
>>> +        .reg_bits = 32,
>>> +        .reg_stride = 4,
>>> +        .val_bits = 32,
>>> +    .fast_io = true,
>>> +};
>>> +
>>> +static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
>>>     #define IPC_I2C_CNTRL_ADDR    0
>>>   #define I2C_DATA_ADDR        0x04
>>>   -static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple 
>>> call to SCU */
>>> -
>>> -/*
>>> - * Send ipc command
>>> - * Command Register (Write Only):
>>> - * A write to this register results in an interrupt to the SCU core 
>>> processor
>>> - * Format:
>>> - * |rfu2(8) | size(8) | command id(4) | rfu1(3) | ioc(1) | command(8)|
>>> - */
>>> -static inline void ipc_command(struct intel_scu_ipc_dev *scu, u32 cmd)
>>> -{
>>> -    if (scu->irq_mode) {
>>> -        reinit_completion(&scu->cmd_complete);
>>> -        writel(cmd | IPC_IOC, scu->ipc_base);
>>> -    }
>>> -    writel(cmd, scu->ipc_base);
>>> -}
>>> -
>>> -/*
>>> - * Write ipc data
>>> - * IPC Write Buffer (Write Only):
>>> - * 16-byte buffer for sending data associated with IPC command to
>>> - * SCU. Size of the data is specified in the IPC_COMMAND_REG register
>>> - */
>>> -static inline void ipc_data_writel(struct intel_scu_ipc_dev *scu, 
>>> u32 data, u32 offset)
>>> -{
>>> -    writel(data, scu->ipc_base + 0x80 + offset);
>>> -}
>>> -
>>> -/*
>>> - * Status Register (Read Only):
>>> - * Driver will read this register to get the ready/busy status of 
>>> the IPC
>>> - * block and error status of the IPC command that was just 
>>> processed by SCU
>>> - * Format:
>>> - * |rfu3(8)|error code(8)|initiator id(8)|cmd 
>>> id(4)|rfu1(2)|error(1)|busy(1)|
>>> - */
>>> -static inline u8 ipc_read_status(struct intel_scu_ipc_dev *scu)
>>> -{
>>> -    return __raw_readl(scu->ipc_base + 0x04);
>>> -}
>>> -
>>> -/* Read ipc byte data */
>>> -static inline u8 ipc_data_readb(struct intel_scu_ipc_dev *scu, u32 
>>> offset)
>>> -{
>>> -    return readb(scu->ipc_base + IPC_READ_BUFFER + offset);
>>> -}
>>> -
>>> -/* Read ipc u32 data */
>>> -static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 
>>> offset)
>>> -{
>>> -    return readl(scu->ipc_base + IPC_READ_BUFFER + offset);
>>> -}
>>> -
>>> -/* Wait till scu status is busy */
>>> -static inline int busy_loop(struct intel_scu_ipc_dev *scu)
>>> -{
>>> -    u32 status = ipc_read_status(scu);
>>> -    u32 loop_count = 100000;
>>> -
>>> -    /* break if scu doesn't reset busy bit after huge retry */
>>> -    while ((status & BIT(0)) && --loop_count) {
>>> -        udelay(1); /* scu processing time is in few u secods */
>>> -        status = ipc_read_status(scu);
>>> -    }
>>> -
>>> -    if (status & BIT(0)) {
>>> -        dev_err(scu->dev, "IPC timed out");
>>> -        return -ETIMEDOUT;
>>> -    }
>>> -
>>> -    if (status & BIT(1))
>>> -        return -EIO;
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -/* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
>>> -static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev 
>>> *scu)
>>> -{
>>> -    int status;
>>> -
>>> -    if (!wait_for_completion_timeout(&scu->cmd_complete, 3 * HZ)) {
>>> -        dev_err(scu->dev, "IPC timed out\n");
>>> -        return -ETIMEDOUT;
>>> -    }
>>> -
>>> -    status = ipc_read_status(scu);
>>> -    if (status & BIT(1))
>>> -        return -EIO;
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
>>> -{
>>> -    return scu->irq_mode ? ipc_wait_for_interrupt(scu) : 
>>> busy_loop(scu);
>>> -}
>>> -
>>>   /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) 
>>> registers */
>>>   static int pwr_reg_rdwr(u16 *addr, u8 *data, u32 count, u32 op, 
>>> u32 id)
>>>   {
>>>       struct intel_scu_ipc_dev *scu = &ipcdev;
>>>       int nc;
>>>       u32 offset = 0;
>>> -    int err;
>>> +    int err = -EIO;
>>>       u8 cbuf[IPC_WWBUF_SIZE];
>>>       u32 *wbuf = (u32 *)&cbuf;
>>> +    u32 cmd[SCU_PARAM_LEN] = {0};
>>> +    /* max rbuf size is 20 bytes */
>>> +    u8 rbuf[IPC_RWBUF_SIZE] = {0};
>>> +    u32 rbuflen = DIV_ROUND_UP(count, 4);
>>>         memset(cbuf, 0, sizeof(cbuf));
>>>   -    mutex_lock(&ipclock);
>>> -
>>> -    if (scu->dev == NULL) {
>>> -        mutex_unlock(&ipclock);
>>> -        return -ENODEV;
>>> -    }
>>> +    scu_cmd_init(cmd, op, id);
>>>         for (nc = 0; nc < count; nc++, offset += 2) {
>>>           cbuf[offset] = addr[nc];
>>> @@ -234,30 +169,30 @@ static int pwr_reg_rdwr(u16 *addr, u8 *data, 
>>> u32 count, u32 op, u32 id)
>>>       }
>>>         if (id == IPC_CMD_PCNTRL_R) {
>>> -        for (nc = 0, offset = 0; nc < count; nc++, offset += 4)
>>> -            ipc_data_writel(scu, wbuf[nc], offset);
>>> -        ipc_command(scu, (count * 2) << 16 | id << 12 | 0 << 8 | op);
>>> +        err = ipc_dev_raw_cmd(scu->ipc_dev, cmd, SCU_PARAM_LEN,
>>> +                (u8 *)wbuf, count * 2, (u32 *)rbuf,
>>> +                IPC_RWBUF_SIZE_DWORD, 0, 0);
>>>       } else if (id == IPC_CMD_PCNTRL_W) {
>>>           for (nc = 0; nc < count; nc++, offset += 1)
>>>               cbuf[offset] = data[nc];
>>> -        for (nc = 0, offset = 0; nc < count; nc++, offset += 4)
>>> -            ipc_data_writel(scu, wbuf[nc], offset);
>>> -        ipc_command(scu, (count * 3) << 16 | id << 12 | 0 << 8 | op);
>>> +        err = ipc_dev_raw_cmd(scu->ipc_dev, cmd, SCU_PARAM_LEN,
>>> +                (u8 *)wbuf, count * 3, NULL, 0, 0, 0);
>>> +
>>>       } else if (id == IPC_CMD_PCNTRL_M) {
>>>           cbuf[offset] = data[0];
>>>           cbuf[offset + 1] = data[1];
>>> -        ipc_data_writel(scu, wbuf[0], 0); /* Write wbuff */
>>> -        ipc_command(scu, 4 << 16 | id << 12 | 0 << 8 | op);
>>> +        err = ipc_dev_raw_cmd(scu->ipc_dev, cmd, SCU_PARAM_LEN,
>>> +                (u8 *)wbuf, 4, NULL, 0, 0, 0);
>>>       }
>>>   -    err = intel_scu_ipc_check_status(scu);
>>>       if (!err && id == IPC_CMD_PCNTRL_R) { /* Read rbuf */
>>>           /* Workaround: values are read as 0 without memcpy_fromio */
>>>           memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
>>> -        for (nc = 0; nc < count; nc++)
>>> -            data[nc] = ipc_data_readb(scu, nc);
>>> +        regmap_bulk_read(scu->ipc_regs, IPC_DEV_SCU_RBUF_OFFSET,
>>> +                    rbuf, rbuflen);
>>> +        memcpy(data, rbuf, count);
>>>       }
>>> -    mutex_unlock(&ipclock);
>>> +
>>>       return err;
>>>   }
>>>   @@ -422,138 +357,6 @@ int intel_scu_ipc_update_register(u16 addr, 
>>> u8 bits, u8 mask)
>>>   }
>>>   EXPORT_SYMBOL(intel_scu_ipc_update_register);
>>>   -/**
>>> - *    intel_scu_ipc_simple_command    -    send a simple command
>>> - *    @cmd: command
>>> - *    @sub: sub type
>>> - *
>>> - *    Issue a simple command to the SCU. Do not use this interface if
>>> - *    you must then access data as any data values may be overwritten
>>> - *    by another SCU access by the time this function returns.
>>> - *
>>> - *    This function may sleep. Locking for SCU accesses is handled for
>>> - *    the caller.
>>> - */
>>> -int intel_scu_ipc_simple_command(int cmd, int sub)
>>> -{
>>> -    struct intel_scu_ipc_dev *scu = &ipcdev;
>>> -    int err;
>>> -
>>> -    mutex_lock(&ipclock);
>>> -    if (scu->dev == NULL) {
>>> -        mutex_unlock(&ipclock);
>>> -        return -ENODEV;
>>> -    }
>>> -    ipc_command(scu, sub << 12 | cmd);
>>> -    err = intel_scu_ipc_check_status(scu);
>>> -    mutex_unlock(&ipclock);
>>> -    return err;
>>> -}
>>> -EXPORT_SYMBOL(intel_scu_ipc_simple_command);
>>> -
>>> -/**
>>> - *    intel_scu_ipc_command    -    command with data
>>> - *    @cmd: command
>>> - *    @sub: sub type
>>> - *    @in: input data
>>> - *    @inlen: input length in dwords
>>> - *    @out: output data
>>> - *    @outlein: output length in dwords
>>> - *
>>> - *    Issue a command to the SCU which involves data transfers. Do the
>>> - *    data copies under the lock but leave it for the caller to 
>>> interpret
>>> - */
>>> -int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
>>> -              u32 *out, int outlen)
>>> -{
>>> -    struct intel_scu_ipc_dev *scu = &ipcdev;
>>> -    int i, err;
>>> -
>>> -    mutex_lock(&ipclock);
>>> -    if (scu->dev == NULL) {
>>> -        mutex_unlock(&ipclock);
>>> -        return -ENODEV;
>>> -    }
>>> -
>>> -    for (i = 0; i < inlen; i++)
>>> -        ipc_data_writel(scu, *in++, 4 * i);
>>> -
>>> -    ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
>>> -    err = intel_scu_ipc_check_status(scu);
>>> -
>>> -    if (!err) {
>>> -        for (i = 0; i < outlen; i++)
>>> -            *out++ = ipc_data_readl(scu, 4 * i);
>>> -    }
>>> -
>>> -    mutex_unlock(&ipclock);
>>> -    return err;
>>> -}
>>> -EXPORT_SYMBOL(intel_scu_ipc_command);
>>> -
>>> -#define IPC_SPTR        0x08
>>> -#define IPC_DPTR        0x0C
>>> -
>>> -/**
>>> - * intel_scu_ipc_raw_command() - IPC command with data and pointers
>>> - * @cmd:    IPC command code.
>>> - * @sub:    IPC command sub type.
>>> - * @in:        input data of this IPC command.
>>> - * @inlen:    input data length in dwords.
>>> - * @out:    output data of this IPC command.
>>> - * @outlen:    output data length in dwords.
>>> - * @sptr:    data writing to SPTR register.
>>> - * @dptr:    data writing to DPTR register.
>>> - *
>>> - * Send an IPC command to SCU with input/output data and 
>>> source/dest pointers.
>>> - *
>>> - * Return:    an IPC error code or 0 on success.
>>> - */
>>> -int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
>>> -                  u32 *out, int outlen, u32 dptr, u32 sptr)
>>> -{
>>> -    struct intel_scu_ipc_dev *scu = &ipcdev;
>>> -    int inbuflen = DIV_ROUND_UP(inlen, 4);
>>> -    u32 inbuf[4];
>>> -    int i, err;
>>> -
>>> -    /* Up to 16 bytes */
>>> -    if (inbuflen > 4)
>>> -        return -EINVAL;
>>> -
>>> -    mutex_lock(&ipclock);
>>> -    if (scu->dev == NULL) {
>>> -        mutex_unlock(&ipclock);
>>> -        return -ENODEV;
>>> -    }
>>> -
>>> -    writel(dptr, scu->ipc_base + IPC_DPTR);
>>> -    writel(sptr, scu->ipc_base + IPC_SPTR);
>>> -
>>> -    /*
>>> -     * SRAM controller doesn't support 8-bit writes, it only
>>> -     * supports 32-bit writes, so we have to copy input data into
>>> -     * the temporary buffer, and SCU FW will use the inlen to
>>> -     * determine the actual input data length in the temporary
>>> -     * buffer.
>>> -     */
>>> -    memcpy(inbuf, in, inlen);
>>> -
>>> -    for (i = 0; i < inbuflen; i++)
>>> -        ipc_data_writel(scu, inbuf[i], 4 * i);
>>> -
>>> -    ipc_command(scu, (inlen << 16) | (sub << 12) | cmd);
>>> -    err = intel_scu_ipc_check_status(scu);
>>> -    if (!err) {
>>> -        for (i = 0; i < outlen; i++)
>>> -            *out++ = ipc_data_readl(scu, 4 * i);
>>> -    }
>>> -
>>> -    mutex_unlock(&ipclock);
>>> -    return err;
>>> -}
>>> -EXPORT_SYMBOL_GPL(intel_scu_ipc_raw_command);
>>> -
>>>   /* I2C commands */
>>>   #define IPC_I2C_WRITE 1 /* I2C Write command */
>>>   #define IPC_I2C_READ  2 /* I2C Read command */
>>> @@ -575,48 +378,143 @@ int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data)
>>>       struct intel_scu_ipc_dev *scu = &ipcdev;
>>>       u32 cmd = 0;
>>>   -    mutex_lock(&ipclock);
>>> -    if (scu->dev == NULL) {
>>> -        mutex_unlock(&ipclock);
>>> -        return -ENODEV;
>>> -    }
>>>       cmd = (addr >> 24) & 0xFF;
>>>       if (cmd == IPC_I2C_READ) {
>>> -        writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
>>> +        regmap_write(scu->i2c_regs, IPC_I2C_CNTRL_ADDR, addr);
>>>           /* Write not getting updated without delay */
>>>           mdelay(1);
>>> -        *data = readl(scu->i2c_base + I2C_DATA_ADDR);
>>> +        regmap_read(scu->i2c_regs, I2C_DATA_ADDR, data);
>>>       } else if (cmd == IPC_I2C_WRITE) {
>>> -        writel(*data, scu->i2c_base + I2C_DATA_ADDR);
>>> +        regmap_write(scu->i2c_regs, I2C_DATA_ADDR, *data);
>>>           mdelay(1);
>>> -        writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
>>> +        regmap_write(scu->i2c_regs, IPC_I2C_CNTRL_ADDR, addr);
>>>       } else {
>>>           dev_err(scu->dev,
>>>               "intel_scu_ipc: I2C INVALID_CMD = 0x%x\n", cmd);
>>>   -        mutex_unlock(&ipclock);
>>>           return -EIO;
>>>       }
>>> -    mutex_unlock(&ipclock);
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL(intel_scu_ipc_i2c_cntrl);
>>>   -/*
>>> - * Interrupt handler gets called when ioc bit of IPC_COMMAND_REG 
>>> set to 1
>>> - * When ioc bit is set to 1, caller api must wait for interrupt 
>>> handler called
>>> - * which in turn unlocks the caller api. Currently this is not used
>>> - *
>>> - * This is edge triggered so we need take no action to clear anything
>>> - */
>>> -static irqreturn_t ioc(int irq, void *dev_id)
>>> +static int pre_simple_cmd_fn(u32 *cmd_list, u32 cmdlen)
>>>   {
>>> -    struct intel_scu_ipc_dev *scu = dev_id;
>>> +    if (!cmd_list || cmdlen != SCU_PARAM_LEN)
>>> +        return -EINVAL;
>>>   -    if (scu->irq_mode)
>>> -        complete(&scu->cmd_complete);
>>> +    cmd_list[0] |= (cmd_list[1] << IPC_CMD_SUBCMD);
>>>   -    return IRQ_HANDLED;
>>> +    return 0;
>>> +}
>>> +
>>> +static int pre_cmd_fn(u32 *cmd_list, u32 cmdlen, u32 *in, u32 inlen,
>>> +        u32 *out, u32 outlen)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (inlen > IPC_WWBUF_SIZE_DWORD || outlen > IPC_RWBUF_SIZE_DWORD)
>>> +        return -EINVAL;
>>> +
>>> +    ret = pre_simple_cmd_fn(cmd_list, cmdlen);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    cmd_list[0] |= (inlen << IPC_CMD_SIZE);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int pre_raw_cmd_fn(u32 *cmd_list, u32 cmdlen, u8 *in, u32 
>>> inlen,
>>> +        u32 *out, u32 outlen, u32 dptr, u32 sptr)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (inlen > IPC_WWBUF_SIZE || outlen > IPC_RWBUF_SIZE_DWORD)
>>> +        return -EINVAL;
>>> +
>>> +    ret = pre_simple_cmd_fn(cmd_list, cmdlen);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    cmd_list[0] |= (inlen << IPC_CMD_SIZE);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int scu_ipc_err_code(int status)
>>> +{
>>> +    if (status & IPC_DEV_SCU_CMD_STATUS_ERR)
>>> +        return (status & IPC_DEV_SCU_CMD_STATUS_ERR_MASK);
>>> +    else
>>> +        return 0;
>>> +}
>>> +
>>> +static int scu_ipc_busy_check(int status)
>>> +{
>>> +    return status | IPC_DEV_SCU_CMD_STATUS_BUSY;
>>> +}
>>> +
>>> +static u32 scu_ipc_enable_msi(u32 cmd)
>>> +{
>>> +    return cmd | IPC_DEV_SCU_CMD_MSI;
>>> +}
>>> +
>>> +static struct intel_ipc_dev *intel_scu_ipc_dev_create(
>>> +        struct device *dev,
>>> +        void __iomem *base,
>>> +        int irq)
>>> +{
>>> +    struct intel_ipc_dev_ops *ops;
>>> +    struct intel_ipc_dev_cfg *cfg;
>>> +    struct regmap *ipc_regs;
>>> +    struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
>>> +
>>> +    cfg = devm_kzalloc(dev, sizeof(*cfg), GFP_KERNEL);
>>> +    if (!cfg)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
>>> +    if (!ops)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +        ipc_regs = devm_regmap_init_mmio_clk(dev, NULL, base,
>>> +            &ipc_regmap_config);
>>> +        if (IS_ERR(ipc_regs)) {
>>> +                dev_err(dev, "ipc_regs regmap init failed\n");
>>> +                return ERR_CAST(ipc_regs);;
>>> +        }
>>> +
>>> +    scu->ipc_regs = ipc_regs;
>>> +
>>> +    /* set IPC dev ops */
>>> +    ops->to_err_code = scu_ipc_err_code;
>>> +    ops->busy_check = scu_ipc_busy_check;
>>> +    ops->enable_msi = scu_ipc_enable_msi;
>>> +    ops->pre_cmd_fn = pre_cmd_fn;
>>> +    ops->pre_raw_cmd_fn = pre_raw_cmd_fn;
>>> +    ops->pre_simple_cmd_fn = pre_simple_cmd_fn;
>>> +
>>> +    /* set cfg options */
>>> +    if (scu->irq_mode)
>>> +        cfg->mode = IPC_DEV_MODE_IRQ;
>>> +    else
>>> +        cfg->mode = IPC_DEV_MODE_POLLING;
>>> +
>>> +    cfg->chan_type = IPC_CHANNEL_IA_SCU;
>>> +    cfg->irq = irq;
>>> +    cfg->use_msi = true;
>>> +    cfg->support_sptr = true;
>>> +    cfg->support_dptr = true;
>>> +    cfg->cmd_regs = ipc_regs;
>>> +    cfg->data_regs = ipc_regs;
>>> +    cfg->wrbuf_reg = IPC_DEV_SCU_WRBUF_OFFSET;
>>> +    cfg->rbuf_reg = IPC_DEV_SCU_RBUF_OFFSET;
>>> +    cfg->sptr_reg = IPC_DEV_SCU_SPTR_OFFSET;
>>> +    cfg->dptr_reg = IPC_DEV_SCU_DPTR_OFFSET;
>>> +    cfg->status_reg = IPC_DEV_SCU_STATUS_OFFSET;
>>> +
>>> +    return devm_intel_ipc_dev_create(dev, INTEL_SCU_IPC_DEV, cfg, 
>>> ops);
>>>   }
>>>     /**
>>> @@ -650,25 +548,34 @@ static int ipc_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>       if (err)
>>>           return err;
>>>   -    init_completion(&scu->cmd_complete);
>>> -
>>>       scu->ipc_base = pcim_iomap_table(pdev)[0];
>>>   -    scu->i2c_base = ioremap_nocache(pdata->i2c_base, 
>>> pdata->i2c_len);
>>> +    scu->i2c_base = devm_ioremap_nocache(&pdev->dev, pdata->i2c_base,
>>> +            pdata->i2c_len);
>>>       if (!scu->i2c_base)
>>>           return -ENOMEM;
>>>   -    err = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, 
>>> "intel_scu_ipc",
>>> -                   scu);
>>> -    if (err)
>>> -        return err;
>>> +    pci_set_drvdata(pdev, scu);
>>> +
>>> +        scu->i2c_regs = devm_regmap_init_mmio_clk(&pdev->dev, NULL,
>>> +            scu->i2c_base, &i2c_regmap_config);
>>> +        if (IS_ERR(scu->i2c_regs)) {
>>> +                dev_err(&pdev->dev, "i2c_regs regmap init failed\n");
>>> +                return PTR_ERR(scu->i2c_regs);;
>>> +        }
>>> +
>>> +    scu->ipc_dev = intel_scu_ipc_dev_create(&pdev->dev, scu->ipc_base,
>>> +            pdev->irq);
>>> +    if (IS_ERR(scu->ipc_dev)) {
>>> +        dev_err(&pdev->dev, "Failed to create SCU IPC device\n");
>>> +        return PTR_ERR(scu->ipc_dev);
>>> +    }
>>>         /* Assign device at last */
>>>       scu->dev = &pdev->dev;
>>>         intel_scu_devices_create();
>>>   -    pci_set_drvdata(pdev, scu);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/rtc/rtc-mrst.c b/drivers/rtc/rtc-mrst.c
>>> index 7334c44..a2d87e8 100644
>>> --- a/drivers/rtc/rtc-mrst.c
>>> +++ b/drivers/rtc/rtc-mrst.c
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/module.h>
>>>   #include <linux/init.h>
>>>   #include <linux/sfi.h>
>>> +#include <linux/platform_data/x86/intel_ipc_dev.h>
>>>     #include <asm/intel_scu_ipc.h>
>>>   #include <asm/intel-mid.h>
>>> @@ -46,6 +47,7 @@ struct mrst_rtc {
>>>       struct device        *dev;
>>>       int            irq;
>>>       struct resource        *iomem;
>>> +    struct intel_ipc_dev    *ipc_dev;
>>>         u8            enabled_wake;
>>>       u8            suspend_ctrl;
>>> @@ -110,10 +112,11 @@ static int mrst_read_time(struct device *dev, 
>>> struct rtc_time *time)
>>>     static int mrst_set_time(struct device *dev, struct rtc_time *time)
>>>   {
>>> -    int ret;
>>>       unsigned long flags;
>>>       unsigned char mon, day, hrs, min, sec;
>>>       unsigned int yrs;
>>> +    struct mrst_rtc    *mrst = dev_get_drvdata(dev);
>>> +    u32 cmds[SCU_PARAM_LEN] = {IPCMSG_VRTC, IPC_CMD_VRTC_SETTIME};
>>>         yrs = time->tm_year;
>>>       mon = time->tm_mon + 1;   /* tm_mon starts at zero */
>>> @@ -137,8 +140,7 @@ static int mrst_set_time(struct device *dev, 
>>> struct rtc_time *time)
>>>         spin_unlock_irqrestore(&rtc_lock, flags);
>>>   -    ret = intel_scu_ipc_simple_command(IPCMSG_VRTC, 
>>> IPC_CMD_VRTC_SETTIME);
>>> -    return ret;
>>> +    return ipc_dev_simple_cmd(mrst->ipc_dev, cmds, SCU_PARAM_LEN);
>>>   }
>>>     static int mrst_read_alarm(struct device *dev, struct rtc_wkalrm 
>>> *t)
>>> @@ -210,6 +212,7 @@ static int mrst_set_alarm(struct device *dev, 
>>> struct rtc_wkalrm *t)
>>>       struct mrst_rtc    *mrst = dev_get_drvdata(dev);
>>>       unsigned char hrs, min, sec;
>>>       int ret = 0;
>>> +    u32 cmds[SCU_PARAM_LEN] = {IPCMSG_VRTC, IPC_CMD_VRTC_SETALARM};
>>>         if (!mrst->irq)
>>>           return -EIO;
>>> @@ -229,7 +232,7 @@ static int mrst_set_alarm(struct device *dev, 
>>> struct rtc_wkalrm *t)
>>>         spin_unlock_irq(&rtc_lock);
>>>   -    ret = intel_scu_ipc_simple_command(IPCMSG_VRTC, 
>>> IPC_CMD_VRTC_SETALARM);
>>> +    ret = ipc_dev_simple_cmd(mrst->ipc_dev, cmds, SCU_PARAM_LEN);
>>>       if (ret)
>>>           return ret;
>>>   @@ -329,6 +332,10 @@ static int vrtc_mrst_do_probe(struct device 
>>> *dev, struct resource *iomem,
>>>       if (!iomem)
>>>           return -ENODEV;
>>>   +    mrst_rtc.ipc_dev = intel_ipc_dev_get(INTEL_SCU_IPC_DEV);
>>> +    if (IS_ERR_OR_NULL(mrst_rtc.ipc_dev))
>>> +        return PTR_ERR(mrst_rtc.ipc_dev);
>>> +
>>>       iomem = request_mem_region(iomem->start, resource_size(iomem),
>>>                      driver_name);
>>>       if (!iomem) {
>>> diff --git a/drivers/watchdog/intel-mid_wdt.c 
>>> b/drivers/watchdog/intel-mid_wdt.c
>>> index 72c108a..a73559b 100644
>>> --- a/drivers/watchdog/intel-mid_wdt.c
>>> +++ b/drivers/watchdog/intel-mid_wdt.c
>>> @@ -18,6 +18,7 @@
>>>   #include <linux/platform_device.h>
>>>   #include <linux/watchdog.h>
>>>   #include <linux/platform_data/intel-mid_wdt.h>
>>> +#include <linux/platform_data/x86/intel_ipc_dev.h>
>>>     #include <asm/intel_scu_ipc.h>
>>>   #include <asm/intel-mid.h>
>>> @@ -29,6 +30,8 @@
>>>   #define MID_WDT_TIMEOUT_MAX        170
>>>   #define MID_WDT_DEFAULT_TIMEOUT        90
>>>   +static struct intel_ipc_dev *scu_ipc_dev;
>>> +
>>>   /* SCU watchdog messages */
>>>   enum {
>>>       SCU_WATCHDOG_START = 0,
>>> @@ -38,7 +41,10 @@ enum {
>>>     static inline int wdt_command(int sub, u32 *in, int inlen)
>>>   {
>>> -    return intel_scu_ipc_command(IPC_WATCHDOG, sub, in, inlen, 
>>> NULL, 0);
>>> +    u32 cmds[SCU_PARAM_LEN] = {IPC_WATCHDOG, sub};
>>> +
>>> +    return ipc_dev_cmd(scu_ipc_dev, cmds, SCU_PARAM_LEN, in,
>>> +            inlen, NULL, 0);
>>>   }
>>>     static int wdt_start(struct watchdog_device *wd)
>>> @@ -129,6 +135,10 @@ static int mid_wdt_probe(struct platform_device 
>>> *pdev)
>>>       if (!wdt_dev)
>>>           return -ENOMEM;
>>>   +    scu_ipc_dev = intel_ipc_dev_get(INTEL_SCU_IPC_DEV);
>>> +    if (IS_ERR_OR_NULL(scu_ipc_dev))
>>> +        return PTR_ERR(scu_ipc_dev);
>>> +
>>>       wdt_dev->info = &mid_wdt_info;
>>>       wdt_dev->ops = &mid_wdt_ops;
>>>       wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
>>> diff --git a/drivers/watchdog/intel_scu_watchdog.c 
>>> b/drivers/watchdog/intel_scu_watchdog.c
>>> index 0caab62..9457c7a 100644
>>> --- a/drivers/watchdog/intel_scu_watchdog.c
>>> +++ b/drivers/watchdog/intel_scu_watchdog.c
>>> @@ -49,6 +49,7 @@
>>>   #include <asm/intel_scu_ipc.h>
>>>   #include <asm/apb_timer.h>
>>>   #include <asm/intel-mid.h>
>>> +#include <linux/platform_data/x86/intel_ipc_dev.h>
>>>     #include "intel_scu_watchdog.h"
>>>   @@ -94,6 +95,8 @@ MODULE_PARM_DESC(force_boot,
>>>     static struct intel_scu_watchdog_dev watchdog_device;
>>>   +static struct intel_ipc_dev *scu_ipc_dev;
>>> +
>>>   /* Forces restart, if force_reboot is set */
>>>   static void watchdog_fire(void)
>>>   {
>>> @@ -128,18 +131,14 @@ static int watchdog_set_ipc(int 
>>> soft_threshold, int threshold)
>>>       u32    *ipc_wbuf;
>>>       u8     cbuf[16] = { '\0' };
>>>       int     ipc_ret = 0;
>>> +    u32 cmds[SCU_PARAM_LEN] = {IPC_SET_WATCHDOG_TIMER, 0};
>>>         ipc_wbuf = (u32 *)&cbuf;
>>>       ipc_wbuf[0] = soft_threshold;
>>>       ipc_wbuf[1] = threshold;
>>>   -    ipc_ret = intel_scu_ipc_command(
>>> -            IPC_SET_WATCHDOG_TIMER,
>>> -            0,
>>> -            ipc_wbuf,
>>> -            2,
>>> -            NULL,
>>> -            0);
>>> +    ipc_ret = ipc_dev_cmd(scu_ipc_dev, cmds, SCU_PARAM_LEN, ipc_wbuf,
>>> +            2, NULL, 0);
>>>         if (ipc_ret != 0)
>>>           pr_err("Error setting SCU watchdog timer: %x\n", ipc_ret);
>>> @@ -460,6 +459,10 @@ static int __init intel_scu_watchdog_init(void)
>>>       if (check_timer_margin(timer_margin))
>>>           return -EINVAL;
>>>   +    scu_ipc_dev = intel_ipc_dev_get(INTEL_SCU_IPC_DEV);
>>> +    if (IS_ERR_OR_NULL(scu_ipc_dev))
>>> +        return PTR_ERR(scu_ipc_dev);
>>> +
>>>       watchdog_device.timer_tbl_ptr = sfi_get_mtmr(sfi_mtimer_num-1);
>>>         if (watchdog_device.timer_tbl_ptr == NULL) {
>>> -- 
>>> 2.7.4
>>>
>>
>
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

