Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34478 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422717AbbD2KyV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Apr 2015 06:54:21 -0400
Received: by wgso17 with SMTP id o17so23772472wgs.1
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Apr 2015 03:54:20 -0700 (PDT)
Date: Wed, 29 Apr 2015 11:54:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH V1 6/6] devicetree: da9062: Add bindings for DA9062 driver
Message-ID: <20150429105415.GX9169@x1>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource@diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, 17 Apr 2015, S Twiss wrote:

> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add device tree bindings for the DA9062 driver
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> 
> This patch applies against linux-next and v4.0 
> 
> 
> 
>  Documentation/devicetree/bindings/mfd/da9062.txt | 107 +++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt

I don't see anything groundbreaking or offensive.

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
> new file mode 100644
> index 0000000..cf8f3f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -0,0 +1,107 @@
> +* Dialog DA9062 Power Management Integrated Circuit (PMIC)
> +
> +DA9062 consists of a large and varied group of sub-devices:
> +
> +Device                   Supply Names    Description
> +------                   ------------    -----------
> +da9062-regulator        :               : LDOs & BUCKs
> +da9062-onkey            :               : On Key
> +da9062-rtc              :               : Real-Time Clock
> +da9062-watchdog         :               : Watchdog Timer
> +
> +======
> +
> +Required properties:
> +
> +- compatible : Should be "dlg,da9062".
> +- reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
> +  modified to match the chip's OTP settings).
> +- interrupt-parent : Specifies the reference to the interrupt controller for
> +  the DA9062.
> +- interrupts : IRQ line information.
> +- interrupt-controller
> +
> +See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
> +further information on IRQ bindings.
> +
> +Sub-nodes:
> +
> +- regulators : This node defines the settings for the LDOs and BUCKs. The
> +  DA9062 regulators are bound using their names listed below:
> +
> +    buck1    : BUCK_1
> +    buck2    : BUCK_2
> +    buck3    : BUCK_3
> +    buck4    : BUCK_4
> +    ldo1     : LDO_1
> +    ldo2     : LDO_2
> +    ldo3     : LDO_3
> +    ldo4     : LDO_4
> +
> +  The component follows the standard regulator framework and the bindings
> +  details of individual regulator device can be found in:
> +  Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +
> +- rtc : This node defines settings required for the Real-Time Clock associated
> +  with the DA9062. There are currently no entries in this binding, however
> +  compatible = "dlg,da9062-rtc" should be added if a node is created.
> +
> +
> +- onkey : This node defines the OnKey settings for controlling the key
> +  functionality of the device. The node should contain the compatible property
> +  with the value "dlg,da9062-onkey".
> +
> +  Optional onkey properties:
> +
> +  - dlg,disable-key-power : Disable power-down using a long key-press. If this
> +    entry exists the OnKey driver will remove support for the KEY_POWER key
> +    press. If this entry does not exist then by default the key-press
> +    triggered power down is enabled and the OnKey will support both KEY_POWER
> +    and KEY_SLEEP.
> +
> +- watchdog: This node defines the settings for the watchdog driver associated
> +  with the DA9062 PMIC. The compatible = "dlg,da9062-watchdog" should be added
> +  if a node is created.
> +
> +
> +Example:
> +
> +	pmic0: da9062@58 {
> +		compatible = "dlg,da9062";
> +		reg = <0x58>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +
> +		rtc {
> +			compatible = "dlg,da9062-rtc";
> +		};
> +
> +		onkey {
> +			compatible = "dlg,da9062-onkey";
> +			dlg,disable-key-power;
> +		};
> +
> +		watchdog {
> +			compatible = "dlg,da9062-watchdog";
> +		};
> +
> +		regulators {
> +			DA9062_BUCK1: buck1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1570000>;
> +				regulator-min-microamp = <500000>;
> +				regulator-max-microamp = <2000000>;
> +				regulator-boot-on;
> +			};
> +			DA9062_LDO1: ldo1 {
> +				regulator-name = "LDO_1";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
