Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35352 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbdIDRlO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 4 Sep 2017 13:41:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170819221823.13850-8-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de> <20170819221823.13850-8-hauke@hauke-m.de>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Sep 2017 19:40:52 +0200
Message-ID: <CAFBinCD_q4=x-HB1rnLkGt_x+2dgUqhUe6t1a+PVt41hZGPhAQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Aug 20, 2017 at 12:18 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
>
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you Hauke for pushing this!

> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..7b9be2d13c53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,90 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +The RCU register range is used for multiple purposes. Mostly one device
> +uses one or multiple register exclusively, but for some registers some
> +bits are for one driver and some other bits are for a different driver.
> +With this patch all accesses to the RCU registers will go through
> +syscon.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible   : The first and second values must be:
> +                 "lantiq,xrx200-rcu", "simple-mfd", "syscon"
> +- reg          : The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +       rcu0: rcu@203000 {
> +               compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
> +               reg = <0x203000 0x100>;
> +               ranges = <0x0 0x203000 0x100>;
> +               big-endian;
> +
> +               gphy0: gphy@20 {
> +                       compatible = "lantiq,xrx200a2x-gphy";
> +                       reg = <0x20 0x4>;
> +
> +                       resets = <&reset0 31 30>, <&reset1 7 7>;
> +                       reset-names = "gphy", "gphy2";
> +                       lantiq,gphy-mode = <GPHY_MODE_GE>;
> +               };
> +
> +               gphy1: gphy@68 {
> +                       compatible = "lantiq,xrx200a2x-gphy";
> +                       reg = <0x68 0x4>;
> +
> +                       resets = <&reset0 29 28>, <&reset1 6 6>;
> +                       reset-names = "gphy", "gphy2";
> +                       lantiq,gphy-mode = <GPHY_MODE_GE>;
> +               };
> +
> +               reset0: reset-controller@10 {
> +                       compatible = "lantiq,xrx200-reset";
> +                       reg = <0x10 4>, <0x14 4>;
> +
> +                       #reset-cells = <2>;
> +               };
> +
> +               reset1: reset-controller@48 {
> +                       compatible = "lantiq,xrx200-reset";
> +                       reg = <0x48 4>, <0x24 4>;
> +
> +                       #reset-cells = <2>;
> +               };
> +
> +               usb_phy0: usb2-phy@18 {
> +                       compatible = "lantiq,xrx200-usb2-phy";
> +                       reg = <0x18 4>, <0x38 4>;
> +                       status = "disabled";
> +
> +                       resets = <&reset1 4 4>, <&reset0 4 4>;
> +                       reset-names = "phy", "ctrl";
> +                       #phy-cells = <0>;
> +               };
> +
> +               usb_phy1: usb2-phy@34 {
> +                       compatible = "lantiq,xrx200-usb2-phy";
> +                       reg = <0x34 4>, <0x3C 4>;
> +                       status = "disabled";
> +
> +                       resets = <&reset1 5 4>, <&reset0 4 4>;
> +                       reset-names = "phy", "ctrl";
> +                       #phy-cells = <0>;
> +               };
> +
> +               reboot@10 {
> +                       compatible = "syscon-reboot";
> +                       reg = <0x10 4>;
> +
> +                       regmap = <&rcu0>;
> +                       offset = <0x10>;
> +                       mask = <0x40000000>;
> +               };
> +       };
> +
> --
> 2.11.0
>
