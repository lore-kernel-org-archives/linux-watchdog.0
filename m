Return-path: <timur@codeaurora.org>
Message-ID: <5555027B.6010701@codeaurora.org>
Date: Thu, 14 May 2015 15:15:55 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] [v2] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1431622353-11196-1-git-send-email-timur@codeaurora.org> <3074350.inBBIzlShL@wuerfel>
In-Reply-To: <3074350.inBBIzlShL@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/14/2015 03:03 PM, Arnd Bergmann wrote:
>> >+       writel(cpu_to_le32(wor), &data->control->wor);
> Why the double endianess swap? Are the registers defined to be CPU-endian?
>
> You probably mean le32_to_cpu() here, not the other way round, although
> the effect is the same.

Maybe I'd doing the whole __le32 thing wrong, but I think 
cpu_to_le32(wor) is correct.  'wor' is a normal integer, so it's in 
"cpu" format.  I want to convert it to le32 format so that I write an 
le32 value to memory.  Therefore, cpu_to_le32().  Most calls to writel() 
use cpu_to_le32():

$ git grep -l "writel(cpu_to_le32"
arch/m68k/coldfire/pci.c
arch/mips/pci/ops-bcm63xx.c
arch/mips/pci/ops-bonito64.c
arch/mips/pci/ops-loongson2.c
arch/parisc/include/asm/io.h
drivers/atm/fore200e.c
drivers/block/umem.c
drivers/isdn/hardware/mISDN/hfcmulti.c
drivers/mtd/nand/r852.c
drivers/net/ethernet/brocade/bna/bfa_ioc.c
drivers/parisc/eisa.c
drivers/scsi/bfa/bfa_ioc.c
drivers/scsi/bnx2fc/bnx2fc_hwi.c
drivers/scsi/bnx2i/bnx2i_hwi.c
drivers/scsi/hptiop.c
drivers/scsi/mpt2sas/mpt2sas_base.c
drivers/scsi/mpt3sas/mpt3sas_base.c
drivers/scsi/nsp32_io.h
drivers/staging/i2o/i2o.h
drivers/usb/isp1760/isp1760-hcd.c
sound/pci/mixart/mixart_hwdep.h

$ git grep -l "writel(le32_to_cpu"
drivers/scsi/hpsa.c
drivers/scsi/megaraid/megaraid_sas_fusion.c
drivers/virtio/virtio_mmio.c



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
