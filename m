Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32819 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041602AbdDUSmD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Apr 2017 14:42:03 -0400
MIME-Version: 1.0
In-Reply-To: <20170417192942.32219-12-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-12-hauke@hauke-m.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 21 Apr 2017 20:41:40 +0200
Message-ID: <CAFBinCCK6Kb44TjLW=41w+kZFt_zk978mkKXPrsKPs5tLG8mLw@mail.gmail.com>
Subject: Re: [PATCH 11/13] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
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
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  59 ++++
>  arch/mips/lantiq/xway/reset.c                      |  43 ---
>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 325 +++++++++++++++++++++
>  6 files changed, 405 insertions(+), 55 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/phy-lantiq-rcu-usb2.c
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..0ec9f790b6e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,59 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible           : Should be one of
> +                               "lantiq,ase-rcu-usb2-phy"
> +                               "lantiq,danube-rcu-usb2-phy"
> +                               "lantiq,xrx100-rcu-usb2-phy"
> +                               "lantiq,xrx200-rcu-usb2-phy"
> +                               "lantiq,xrx300-rcu-usb2-phy"
> +- lantiq,rcu-syscon    : A phandle to the RCU module and the offsets to the
> +                         USB PHY configuration and USB MAC registers.
> +- address-cells                : should be 1
> +- size-cells           : should be 0
> +- phy-cells            : from the generic PHY bindings, must be 1
> +
> +Optional properties (controller (parent) node):
> +- vbus-gpio            : References a GPIO which enables VBUS all given USB
> +                         ports.
> +
> +Required nodes         :  A sub-node is required for each USB PHY port.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (port (child) node):
> +- reg          : The ID of the USB port, usually 0 or 1.
> +- clocks       : References to the (PMU) "ctrl" and "phy" clk gates.
> +- clock-names  : Must be one of the following:
> +                       "ctrl"
> +                       "phy"
> +- resets       : References to the RCU USB configuration reset bits.
> +- reset-names  : Must be one of the following:
> +                       "analog-config" (optional)
> +                       "statemachine-soft" (optional)
> +
> +Optional properties (port (child) node):
> +- vbus-gpio    : References a GPIO which enables VBUS for the USB port.
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the USB PHYs on an xRX200 SoC:
> +       usb_phys0: rcu-usb2-phy@0 {
> +               compatible      = "lantiq,xrx200-rcu-usb2-phy";
> +               reg = <0>;
> +
> +               lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
> +               clocks = <&pmu PMU_GATE_USB0_CTRL>,
> +                        <&pmu PMU_GATE_USB0_PHY>;
> +               clock-names = "ctrl", "phy";
> +               vbus-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>;
> +               resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
> +               reset-names = "phy", "ctrl";
> +               #phy-cells = <0>;
> +       };
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> index 3f30fb81a50f..5aec1f54275b 100644
> --- a/arch/mips/lantiq/xway/reset.c
> +++ b/arch/mips/lantiq/xway/reset.c
> @@ -124,45 +124,6 @@ static void ltq_machine_power_off(void)
>         unreachable();
>  }
>
> -static void ltq_usb_init(void)
> -{
> -       /* Power for USB cores 1 & 2 */
> -       ltq_pmu_enable(PMU_AHBM);
> -       ltq_pmu_enable(PMU_USB0);
> -       ltq_pmu_enable(PMU_USB1);
> -
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1A) | BIT(0), RCU_CFG1A);
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1B) | BIT(0), RCU_CFG1B);
> -
> -       /* Enable USB PHY power for cores 1 & 2 */
> -       ltq_pmu_enable(PMU_USB0_P);
> -       ltq_pmu_enable(PMU_USB1_P);
> -
> -       /* Configure cores to host mode */
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_HDSEL_BIT,
> -               RCU_USB1CFG);
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_USB2CFG) & ~RCU_USBCFG_HDSEL_BIT,
> -               RCU_USB2CFG);
> -
> -       /* Select DMA endianness (Host-endian: big-endian) */
> -       ltq_rcu_w32((ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_SLV_END_BIT)
> -               | RCU_USBCFG_HOST_END_BIT, RCU_USB1CFG);
> -       ltq_rcu_w32(ltq_rcu_r32((RCU_USB2CFG) & ~RCU_USBCFG_SLV_END_BIT)
> -               | RCU_USBCFG_HOST_END_BIT, RCU_USB2CFG);
> -
> -       /* Hard reset USB state machines */
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) | USBRESET_BIT, RCU_USBRESET);
> -       udelay(50 * 1000);
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) & ~USBRESET_BIT, RCU_USBRESET);
> -
> -       /* Soft reset USB state machines */
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
> -               | USB1RESET_BIT | USB2RESET_BIT, RCU_USBRESET2);
> -       udelay(50 * 1000);
> -       ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
> -               & ~(USB1RESET_BIT | USB2RESET_BIT), RCU_USBRESET2);
> -}
> -
>  static int __init mips_reboot_setup(void)
>  {
>         struct resource res;
> @@ -186,10 +147,6 @@ static int __init mips_reboot_setup(void)
>         if (!ltq_rcu_membase)
>                 panic("Failed to remap core memory");
>
> -       if (of_machine_is_compatible("lantiq,ar9") ||
> -           of_machine_is_compatible("lantiq,vr9"))
> -               ltq_usb_init();
> -
>         _machine_restart = ltq_machine_restart;
>         _machine_halt = ltq_machine_halt;
>         pm_power_off = ltq_machine_power_off;
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 5764d3ddce69..18725f2d5b67 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
> @@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
>
>         if (of_machine_is_compatible("lantiq,grx390") ||
>             of_machine_is_compatible("lantiq,ar10")) {
> -               clkdev_add_pmu("1e101000.usb", "phy", 1, 2, PMU_ANALOG_USB0_P);
> -               clkdev_add_pmu("1e106000.usb", "phy", 1, 2, PMU_ANALOG_USB1_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "phy", 1, 2, PMU_ANALOG_USB0_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@1", "phy", 1, 2, PMU_ANALOG_USB1_P);
>                 /* rc 0 */
>                 clkdev_add_pmu("1d900000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE0_P);
>                 clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
> @@ -490,8 +490,8 @@ void __init ltq_soc_init(void)
>                 else
>                         clkdev_add_static(CLOCK_133M, CLOCK_133M,
>                                                 CLOCK_133M, CLOCK_133M);
> -               clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -               clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "ctrl", 1, 0, PMU_USB0);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
>                 clkdev_add_pmu("1e180000.etop", "ppe", 1, 0, PMU_PPE);
>                 clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
>                 clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
> @@ -525,10 +525,10 @@ void __init ltq_soc_init(void)
>         } else if (of_machine_is_compatible("lantiq,vr9")) {
>                 clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
>                                 ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
> -               clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> -               clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0 | PMU_AHBM);
> -               clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
> -               clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1 | PMU_AHBM);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "ctrl", 1, 0, PMU_USB0 | PMU_AHBM);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@1", "phy", 1, 0, PMU_USB1_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@1", "ctrl", 1, 0, PMU_USB1 | PMU_AHBM);
>                 clkdev_add_pmu("1d900000.pcie", "phy", 1, 1, PMU1_PCIE_PHY);
>                 clkdev_add_pmu("1d900000.pcie", "bus", 1, 0, PMU_PCIE_CLK);
>                 clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
> @@ -548,8 +548,8 @@ void __init ltq_soc_init(void)
>         } else if (of_machine_is_compatible("lantiq,ar9")) {
>                 clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
>                                 ltq_ar9_fpi_hz(), CLOCK_250M);
> -               clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -               clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "ctrl", 1, 0, PMU_USB0);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
>                 clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
>                 clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
>                 clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
> @@ -560,8 +560,8 @@ void __init ltq_soc_init(void)
>         } else {
>                 clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
>                                 ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
> -               clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
> -               clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "ctrl", 1, 0, PMU_USB0);
> +               clkdev_add_pmu("1f203000.rcu:rcu-usb2-phy@0", "phy", 1, 0, PMU_USB0_P);
>                 clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
>                 clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
>                 clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 005cadb7a3f8..dbb450e3ba04 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -488,6 +488,14 @@ config PHY_CYGNUS_PCIE
>           Enable this to support the Broadcom Cygnus PCIe PHY.
>           If unsure, say N.
>
> +config PHY_LANTIQ_RCU_USB2
> +       tristate "Lantiq XWAY SoC RCU based USB PHY"
> +       depends on SOC_TYPE_XWAY
> +       depends on OF
> +       select GENERIC_PHY
> +       help
> +         Support for the USB PHY(s) on the Lantiq XWAY family SoCs.
> +
>  source "drivers/phy/tegra/Kconfig"
>
>  config PHY_NS2_PCIE
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index dd8f3b5d2918..52631f5ac470 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_PHY_TUSB1210)            += phy-tusb1210.o
>  obj-$(CONFIG_PHY_BRCM_SATA)            += phy-brcm-sata.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)                += phy-pistachio-usb.o
>  obj-$(CONFIG_PHY_CYGNUS_PCIE)          += phy-bcm-cygnus-pcie.o
> +obj-$(CONFIG_PHY_LANTIQ_RCU_USB2)      += phy-lantiq-rcu-usb2.o
>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>  obj-$(CONFIG_PHY_NS2_PCIE)             += phy-bcm-ns2-pcie.o
>  obj-$(CONFIG_PHY_MESON8B_USB2)         += phy-meson8b-usb2.o
> diff --git a/drivers/phy/phy-lantiq-rcu-usb2.c b/drivers/phy/phy-lantiq-rcu-usb2.c
> new file mode 100644
> index 000000000000..9bff42afd256
> --- /dev/null
> +++ b/drivers/phy/phy-lantiq-rcu-usb2.c
> @@ -0,0 +1,325 @@
> +/*
> + * Lantiq XWAY SoC RCU module based USB 1.1/2.0 PHY driver
> + *
> + * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + * Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define MAX_VBUS_GPIO          2
> +
> +/* Transmitter HS Pre-Emphasis Enable */
> +#define RCU_CFG1_TX_PEE                BIT(0)
> +/* Disconnect Threshold */
> +#define RCU_CFG1_DIS_THR_MASK  0x00038000
> +#define RCU_CFG1_DIS_THR_SHIFT 15
> +
> +struct ltq_rcu_usb2_bits {
> +       u8 hostmode;
> +       u8 slave_endianness;
> +       u8 host_endianness;
> +       bool have_ana_cfg;
> +};
> +
> +struct ltq_rcu_usb2_priv {
> +       struct regmap                   *regmap;
> +       u32                             phy_reg_offset;
> +       u32                             ana_cfg1_reg_offset;
> +       const struct ltq_rcu_usb2_bits  *reg_bits;
> +       struct device                   *dev;
> +       struct gpio_desc                *gpiod_vbus[MAX_VBUS_GPIO];
> +       struct phy                      *phy;
> +       struct clk                      *ctrl_gate_clk;
> +       struct clk                      *phy_gate_clk;
> +       struct reset_control            *ctrl_reset;
> +       struct reset_control            *phy_reset;
> +};
> +
> +static const struct ltq_rcu_usb2_bits xway_rcu_usb2_reg_bits = {
> +       .hostmode = 11,
> +       .slave_endianness = 9,
> +       .host_endianness = 10,
> +       .have_ana_cfg = false,
> +};
> +
> +static const struct ltq_rcu_usb2_bits xrx100_rcu_usb2_reg_bits = {
> +       .hostmode = 11,
> +       .slave_endianness = 17,
> +       .host_endianness = 10,
> +       .have_ana_cfg = false,
> +};
> +
> +static const struct ltq_rcu_usb2_bits xrx200_rcu_usb2_reg_bits = {
> +       .hostmode = 11,
> +       .slave_endianness = 9,
> +       .host_endianness = 10,
> +       .have_ana_cfg = true,
> +};
> +
> +static const struct of_device_id ltq_rcu_usb2_phy_of_match[] = {
> +       {
> +               .compatible = "lantiq,ase-rcu-usb2-phy",
> +               .data = &xway_rcu_usb2_reg_bits,
> +       },
> +       {
> +               .compatible = "lantiq,danube-rcu-usb2-phy",
> +               .data = &xway_rcu_usb2_reg_bits,
> +       },
> +       {
> +               .compatible = "lantiq,xrx100-rcu-usb2-phy",
> +               .data = &xrx100_rcu_usb2_reg_bits,
> +       },
> +       {
> +               .compatible = "lantiq,xrx200-rcu-usb2-phy",
> +               .data = &xrx200_rcu_usb2_reg_bits,
> +       },
> +       {
> +               .compatible = "lantiq,xrx300-rcu-usb2-phy",
> +               .data = &xrx200_rcu_usb2_reg_bits,
> +       },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, ltq_rcu_usb2_phy_of_match);
> +
> +static void ltq_rcu_usb2_set_vbus_gpio_value(struct gpio_desc **gpiods,
> +                                               int value)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_VBUS_GPIO; i++)
> +               if (!IS_ERR_OR_NULL(gpiods[i]))
> +                       gpiod_set_value(gpiods[i], value);
> +}
> +
> +static int ltq_rcu_usb2_phy_power_on(struct phy *phy)
> +{
> +       struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +       if (priv->phy_reset)
> +               reset_control_deassert(priv->phy_reset);
> +
> +       /* enable the port-specific VBUS GPIOs if available */
> +       ltq_rcu_usb2_set_vbus_gpio_value(priv->gpiod_vbus, 1);
as I mentioned in my previous mail, if you pass a fixed regulator then
the PHY framework handles this, see [1] (regulator_enable is called
right before .phy_power_on and regulator_disable is called right after
.phy_power_off)

> +       return 0;
> +}
> +
> +static int ltq_rcu_usb2_phy_power_off(struct phy *phy)
> +{
> +       struct ltq_rcu_usb2_priv *priv = phy_get_drvdata(phy);
> +
> +       /*
> +        * only disable the port-specific VBUS GPIO here (if available), the
> +        * shared VBUS GPIO might still be used by another port
> +        */
> +       ltq_rcu_usb2_set_vbus_gpio_value(priv->gpiod_vbus, 0);
> +
> +       if (priv->phy_reset)
> +               reset_control_assert(priv->phy_reset);
> +
> +       return 0;
> +}
> +
> +static struct phy_ops ltq_rcu_usb2_phy_ops = {
> +       .power_on       = ltq_rcu_usb2_phy_power_on,
> +       .power_off      = ltq_rcu_usb2_phy_power_off,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static void ltq_rcu_usb2_start_cores(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct ltq_rcu_usb2_priv *priv = dev_get_drvdata(dev);
> +
> +       /* Power on the USB core. */
> +       if (clk_prepare_enable(priv->ctrl_gate_clk)) {
> +               dev_err(dev, "failed to enable CTRL gate\n");
> +               return;
> +       }
> +
> +       /*
> +        * Power on the USB PHY. We have to do it early because
> +        * otherwise the second core won't turn on properly.
> +        */
> +       if (clk_prepare_enable(priv->phy_gate_clk)) {
> +               dev_err(dev, "failed to enable PHY gate\n");
> +               return;
> +       }
> +
> +       if (priv->reg_bits->have_ana_cfg) {
> +               regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
> +                       RCU_CFG1_TX_PEE, RCU_CFG1_TX_PEE);
> +               regmap_update_bits(priv->regmap, priv->ana_cfg1_reg_offset,
> +                       RCU_CFG1_DIS_THR_MASK, 7 << RCU_CFG1_DIS_THR_SHIFT);
> +       }
> +
> +       /* Configure core to host mode */
> +       regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +                          BIT(priv->reg_bits->hostmode), 0);
> +
> +       /* Select DMA endianness (Host-endian: big-endian) */
> +       regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +               BIT(priv->reg_bits->slave_endianness), 0);
> +       regmap_update_bits(priv->regmap, priv->phy_reg_offset,
> +               BIT(priv->reg_bits->host_endianness),
> +               BIT(priv->reg_bits->host_endianness));
> +
> +       /* Reset USB core throgh reset controller */
> +       reset_control_deassert(priv->ctrl_reset);
> +
> +       if (priv->phy_reset)
> +               reset_control_assert(priv->phy_reset);
> +}
> +
> +static int ltq_rcu_usb2_get_vbus_gpios(struct device *dev,
> +                                         struct gpio_desc **gpios)
> +{
> +       int i;
> +
> +       for (i = 0; i < MAX_VBUS_GPIO; i++) {
> +               gpios[i] = devm_gpiod_get_index_optional(dev, "vbus", i,
> +                                                        GPIOD_OUT_LOW);
> +               if (IS_ERR(gpios[i]))
> +                       return PTR_ERR(gpios[i]);
> +       }
> +
> +       return 0;
> +}
> +
> +static int ltq_rcu_usb2_of_probe(struct device_node *phynode,
> +                                   struct ltq_rcu_usb2_priv *priv)
> +{
> +       struct device *dev = priv->dev;
> +       const struct of_device_id *match =
> +               of_match_node(ltq_rcu_usb2_phy_of_match, phynode);
> +       int ret;
> +
> +       if (!match) {
> +               dev_err(dev, "Not a compatible Lantiq RCU USB PHY\n");
> +               return -EINVAL;
> +       }
> +
> +       priv->reg_bits = match->data;
> +
> +       priv->regmap = syscon_regmap_lookup_by_phandle(phynode,
> +                                                      "lantiq,rcu-syscon");
> +       if (IS_ERR(priv->regmap)) {
> +               dev_err(dev, "Failed to lookup RCU regmap\n");
> +               return PTR_ERR(priv->regmap);
> +       }
> +
> +       ret = ltq_rcu_usb2_get_vbus_gpios(dev, priv->gpiod_vbus);
> +       if (ret) {
> +               dev_err(dev, "failed to request shared USB VBUS GPIO\n");
> +               return ret;
> +       }
> +
> +       priv->ctrl_gate_clk = devm_clk_get(dev, "ctrl");
> +       if (IS_ERR(priv->ctrl_gate_clk)) {
> +               dev_err(dev, "Unable to get USB ctrl gate clk\n");
> +               return PTR_ERR(priv->ctrl_gate_clk);
> +       }
> +
> +       priv->phy_gate_clk = devm_clk_get(dev, "phy");
> +       if (IS_ERR(priv->phy_gate_clk)) {
> +               dev_err(dev, "Unable to get USB phy gate clk\n");
> +               return PTR_ERR(priv->phy_gate_clk);
> +       }
> +
> +       priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
> +       if (IS_ERR(priv->ctrl_reset)) {
> +               dev_err(dev, "failed to get 'ctrl' reset\n");
> +               return PTR_ERR(priv->ctrl_reset);
> +       }
> +
> +       priv->phy_reset = devm_reset_control_get_optional(dev, "phy");
> +       if (IS_ERR(priv->phy_reset)) {
> +               if (PTR_ERR(priv->phy_reset) == -EPROBE_DEFER)
> +                       return PTR_ERR(priv->phy_reset);
> +               priv->phy_reset = NULL;
> +       }
a recent reset controller framework improvement allows us to make this
much easier as:
"As of commit bb475230b8e5 ("reset: make optional functions really
optional"), the reset framework API calls use NULL pointers to describe
optional, non-present reset controls." (see [0])
so we can basically turn this into IS_ERR() then return PTR_ERR()

> +       ret = of_property_read_u32_index(phynode, "lantiq,rcu-syscon", 1,
> +                                        &priv->phy_reg_offset);
> +       if (ret) {
> +               dev_err(dev, "Failed to get RCU PHY reg offset\n");
> +               return ret;
> +       }
> +
> +       if (priv->reg_bits->have_ana_cfg) {
> +               ret = of_property_read_u32_index(phynode, "lantiq,rcu-syscon",
> +                                                2, &priv->ana_cfg1_reg_offset);
> +               if (ret) {
> +                       dev_dbg(dev, "Failed to get RCU ANA CFG1 reg offset\n");
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int ltq_rcu_usb2_phy_probe(struct platform_device *pdev)
> +{
> +       struct device_node *child, *np = pdev->dev.of_node;
> +       struct ltq_rcu_usb2_priv *priv;
> +       struct phy_provider *provider;
> +       int ret;
> +
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv),
> +                                      GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = &pdev->dev;
> +       dev_set_drvdata(priv->dev, priv);
> +
> +       ret = ltq_rcu_usb2_of_probe(np, priv);
> +       if (ret)
> +               return ret;
> +
> +       priv->phy = devm_phy_create(&pdev->dev, child,
> +                                        &ltq_rcu_usb2_phy_ops);
> +       if (IS_ERR(priv->phy)) {
> +               dev_err(&pdev->dev, "failed to create PHY\n");
> +               return PTR_ERR(priv->phy);
> +       }
> +
> +       phy_set_drvdata(priv->phy, priv);
> +
> +       ltq_rcu_usb2_start_cores(pdev);
> +
> +       provider = devm_of_phy_provider_register(&pdev->dev,
> +                                                of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static struct platform_driver ltq_rcu_usb2_phy_driver = {
> +       .probe  = ltq_rcu_usb2_phy_probe,
> +       .driver = {
> +               .name   = "lantiq-rcu-usb2-phy",
> +               .of_match_table = ltq_rcu_usb2_phy_of_match,
> +       }
> +};
> +module_platform_driver(ltq_rcu_usb2_phy_driver);
> +
> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
> +MODULE_DESCRIPTION("Lantiq XWAY USB2 PHY driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.11.0
>

[0] https://patchwork.kernel.org/patch/9545031/
[1] http://lxr.free-electrons.com/source/drivers/phy/phy-core.c#L276
