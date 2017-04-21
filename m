Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35946 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423512AbdDUSVG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Apr 2017 14:21:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170417192942.32219-8-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-8-hauke@hauke-m.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 21 Apr 2017 20:20:27 +0200
Message-ID: <CAFBinCCKPEbpjt=vju9Pj95O_CyjzbORZhVc_opXHNvQ3eD=sg@mail.gmail.com>
Subject: Re: [PATCH 07/13] MIPS: lantiq: remove ltq_reset_cause() and ltq_boot_select()
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 17, 2017 at 9:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Do not export the ltq_reset_cause() and ltq_boot_select() function any
> more. ltq_reset_cause() was accessed by the watchdog driver before to
> see why the last reset happened, this is now done through direct access
> of the register over regmap. The bits in this register are anyway
> different between the xrx200 and the falcon SoC.
> ltq_boot_select() is not used any more and was used by the flash
> drivers to check if the system was booted from this flash type, now the
> drivers should depend on the device tree only.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

(you could make yourself the author of this patch as I didn't touch
this - but I think that this is a good thing to do!)

> ---
>  arch/mips/include/asm/mach-lantiq/lantiq.h |  4 ----
>  arch/mips/lantiq/falcon/reset.c            | 22 ----------------------
>  arch/mips/lantiq/xway/reset.c              | 19 -------------------
>  3 files changed, 45 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
> index 8064d7a4b33d..fa045b4c0cdd 100644
> --- a/arch/mips/include/asm/mach-lantiq/lantiq.h
> +++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
> @@ -44,10 +44,6 @@ extern struct clk *clk_get_fpi(void);
>  extern struct clk *clk_get_io(void);
>  extern struct clk *clk_get_ppe(void);
>
> -/* find out what bootsource we have */
> -extern unsigned char ltq_boot_select(void);
> -/* find out what caused the last cpu reset */
> -extern int ltq_reset_cause(void);
>  /* find out the soc type */
>  extern int ltq_soc_type(void);
>
> diff --git a/arch/mips/lantiq/falcon/reset.c b/arch/mips/lantiq/falcon/reset.c
> index 7a535d72f541..722114d7409d 100644
> --- a/arch/mips/lantiq/falcon/reset.c
> +++ b/arch/mips/lantiq/falcon/reset.c
> @@ -15,28 +15,6 @@
>
>  #include <lantiq_soc.h>
>
> -/* CPU0 Reset Source Register */
> -#define SYS1_CPU0RS            0x0040
> -/* reset cause mask */
> -#define CPU0RS_MASK            0x0003
> -/* CPU0 Boot Mode Register */
> -#define SYS1_BM                        0x00a0
> -/* boot mode mask */
> -#define BM_MASK                        0x0005
> -
> -/* allow platform code to find out what surce we booted from */
> -unsigned char ltq_boot_select(void)
> -{
> -       return ltq_sys1_r32(SYS1_BM) & BM_MASK;
> -}
> -
> -/* allow the watchdog driver to find out what the boot reason was */
> -int ltq_reset_cause(void)
> -{
> -       return ltq_sys1_r32(SYS1_CPU0RS) & CPU0RS_MASK;
> -}
> -EXPORT_SYMBOL_GPL(ltq_reset_cause);
> -
>  #define BOOT_REG_BASE  (KSEG1 | 0x1F200000)
>  #define BOOT_PW1_REG   (BOOT_REG_BASE | 0x20)
>  #define BOOT_PW2_REG   (BOOT_REG_BASE | 0x24)
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> index b6752c95a600..2dedcf939901 100644
> --- a/arch/mips/lantiq/xway/reset.c
> +++ b/arch/mips/lantiq/xway/reset.c
> @@ -119,25 +119,6 @@ static void ltq_rcu_w32_mask(uint32_t clr, uint32_t set, uint32_t reg_off)
>         spin_unlock_irqrestore(&ltq_rcu_lock, flags);
>  }
>
> -/* This function is used by the watchdog driver */
> -int ltq_reset_cause(void)
> -{
> -       u32 val = ltq_rcu_r32(RCU_RST_STAT);
> -       return val >> RCU_STAT_SHIFT;
> -}
> -EXPORT_SYMBOL_GPL(ltq_reset_cause);
> -
> -/* allow platform code to find out what source we booted from */
> -unsigned char ltq_boot_select(void)
> -{
> -       u32 val = ltq_rcu_r32(RCU_RST_STAT);
> -
> -       if (of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200"))
> -               return RCU_BOOT_SEL_XRX200(val);
> -
> -       return RCU_BOOT_SEL(val);
> -}
> -
>  struct ltq_gphy_reset {
>         u32 rd;
>         u32 addr;
> --
> 2.11.0
>
